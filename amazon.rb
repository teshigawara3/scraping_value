#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './change_char_code'

class Amazon
	def self.getvalue(url)
		charset = "UTF-8"
		html = open(url,{'Cache-Control' => 'no-cache'}) do |f|
			f.read
		end
		html = ChangeCode::utf_str(html)
		doc = Nokogiri::HTML.parse(html,nil,charset)
		buybox = doc.xpath('//div[@id="buybox"]')
		price = buybox.xpath('//span[@class="a-size-medium a-color-price offer-price a-text-normal"]').text()
		if price.length > 0
			return price.gsub(/[^0-9]/,"").to_i
		else
			print("nothing value\n")
		end
	end
end
