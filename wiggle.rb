#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './change_char_code'

class Wiggle
	
	def self.getvalue(url)
		charset = "UTF-8"
		html = open(url,{'Cache-Control' => 'no-cache'}) do |f|
			f.read
		end
		html = ChangeCode::utf_str(html)
		doc = Nokogiri::HTML.parse(html,nil,charset)
		elem = doc.xpath('//div[@class="bem-product-price__unit--pdp"]')
		price = elem.xpath('span').text()
		if price.length > 0 then
			return price.gsub(/[^0-9]/,"").to_i
		else
			print("nothing value\n")
		end
	end
end

