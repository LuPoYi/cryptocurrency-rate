module Esun
  extend Base

  def self.start!
    ans = []
    currencies = ['USD', 'JPY']
    
    url = "https://www.esunbank.com.tw/bank/personal/deposit/rate/forex/foreign-exchange-rates"
    puts "url: #{url}"
    doc = Nokogiri::HTML(open(URI.encode(url)))

    #rate_set = doc.search('#inteTable1 tbody tr td.itemTtitle')
    rate_set = doc.search('#inteTable1  tr:not(.titleRow)')
    rate_set.each do |a|
      # 先判斷該行幣別
      currency = nil
      currency_info = a.search('td.itemTtitle a')[0].content # 美元(USD)
      currencies.each do |cur|
        if currency_info.include? cur
          currency = cur
          break
        end
      end
      
      if currency
        spot_selling = a.search('td.odd')[0].content
        spot_buying = a.search('td.even')[0].content
        spot_avg = (spot_selling.to_f + spot_buying.to_f) / 2.0

        set_redis("Esun", "#{currency}:TWD", spot_avg)
      end
    end
    

    return rate_set
  end
end

=begin
    box_set.each do |a|
      av_title = a.search('.photo-frame img')[0]['title']
      av_img_link = a.search('.photo-frame img')[0]['src'].gsub(/s.jpg\z/ , 'l.jpg') # 小圖轉大圖

      av_id = a.search('.photo-info span date')[0].content
      av_created_at = a.search('.photo-info span date')[1].content

      ans << "#{av_id}\n#{av_title}\n#{av_created_at}\n#{av_img_link}"
    end
=end
#inteTable1 tbody tr td.itemTtitle