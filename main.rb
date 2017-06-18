require 'rubygems'
require 'yaml'
require 'json'
require 'open-uri'
require 'redis'
require 'rest-client'
require 'nokogiri'

require_relative 'lib/base.rb'
require_relative 'lib/bank_of_taiwan.rb'
require_relative 'lib/esun.rb'


$redis = Redis.new
$ssdb  = Redis.new


BankOfTaiwan.start!
Esun.start!