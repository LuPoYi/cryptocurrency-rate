require 'rubygems'
require 'yaml'
require 'json'
require 'open-uri'
require 'redis'
require 'rest-client'
require 'nokogiri'


require_relative 'lib/bank_of_taiwan.rb'


$redis = Redis.new
$ssdb  = Redis.new

BankOfTaiwan.start!