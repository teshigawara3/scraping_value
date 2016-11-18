#! ruby -Ku

require 'open-uri'
require 'nokogiri'
#require './change_char_code'
#require './zozotown'
require './amazon'
#require './rakuten'
#require './wiggle'
#require './kakakucom'

class SiteController
	def get_value(url)
		case url
		when /amazon\.co\.jp/
			Amazon::get_value(url)
#		when /rakuten\.co\.jp/
			#getrakutenvalue
#		when /zozo\.jp/
#			Zozo::get_value(url)
#		when /wiggle\.jp/
#			Wiggle::get_value(url)
#		when /kakaku\.com/
#			Kakakucom::get_value(url)
		else
			return -1
		end
	end
end
