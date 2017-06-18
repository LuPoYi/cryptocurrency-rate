module Base

  def set_redis(key, field, value)
    puts "set field #{field} value #{value}"
    $redis.hset(key, field, value)
  end
end