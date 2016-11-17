#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './changecode'
require './zozotown'
#require './amazon'
#require './rakuten'
require './wiggle'
#require './kakakucom'

class Scrapingvalue
	def getvalue(url)
		case url
#		when /amazon\.co\.jp/
#			Amazon::getvalue(url)
#		when /rakuten\.co\.jp/
			#getrakutenvalue
		when /zozo\.jp/
			Zozo::getvalue(url)
			#getzozotownvalue
		when /wiggle\.jp/
			Wiggle::getvalue(url)
		when /kakaku\.com/
			Kakakucom::getvalue(url)
		else
			print("登録されていないサイトです。\n")
			return -1
		end
	end
end
