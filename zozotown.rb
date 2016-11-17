#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './changecode'

class Zozo
	def self.getvalue(url)
		charset="UTF-8"
		html = open(url,{'Cache-Control' => 'no-cache'}) do |f|
			f.read
		end
		html = ChangeCode::utf_str(html)
		doc = Nokogiri::HTML.parse(html,nil,charset)
		elem = doc.xpath('//div[@id="item-intro"]')
		if elem.xpath('//p[@class="price"]').text().length > 0 then
			price = elem.xpath('//p[@class="price"]').text()
			price = price.gsub(/[^0-9]/,"").to_i
			return price
		elsif elem.xpath('//p[@class="price discount"]').text().length > 0 then
			elemlist = elem.xpath('//p[@class="price discount"]').text().split(/[[:space:]]/)
			price = elemlist[2].gsub(/[^0-9]/,"").to_i
			return price
			else
			p "nothing value\n"
		end
	end
end
