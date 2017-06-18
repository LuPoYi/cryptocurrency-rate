module BankOfTaiwan
  extend Base

  def self.start!
    currencies = ['USD', 'JPY']
    
    url = "http://rate.bot.com.tw/xrt?Lang=zh-TW"
    puts "url: #{url}"
    doc = Nokogiri::HTML(open(URI.encode(url)))

    rate_set = doc.search('table.table.table-striped.table-bordered.table-condensed.table-hover tbody tr')
    rate_set.each do |a|
      currency = nil
      currency_info = a.search('td.currency div.print_hide')[0].content # 美元(USD)

      currencies.each do |cur|
        if currency_info.include? cur
          currency = cur
          break
        end
      end
      
      if currency
        spot_selling = a.search('td.rate-content-sight')[1].content
        spot_buying = a.search('td.rate-content-sight')[0].content
        spot_avg = (spot_selling.to_f + spot_buying.to_f) / 2.0

        set_redis("BOT", "#{currency}:TWD", spot_avg)
      end
    end
  end

end
