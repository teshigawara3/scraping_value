#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './change_char_code'

class Amazon
	def self.get_value(url)
		charset = "UTF-8"
		opt = { 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; 
					WOW64) AppleWebKit/537.36 (KHTML, like Gecko) 
					Chrome/54.0.2840.71 Safari/537.36' ,
		      'Cache-Control' => 'no-cache'}
		html = open(url, opt) do |f|
			f.read
		end
		html = ChangeCharCode::utf_str(html)
		doc = Nokogiri::HTML.parse(html,nil,charset)
    price = doc.xpath('//span[@id="priceblock_ourprice"]').text()
		if price.length > 0
			return price.gsub(/[^0-9]/,"").to_i
		else
			print("nothing value\n")
		end
	end
end
