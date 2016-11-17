#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './changecode'

class Kakakucom
	def self.getvalue(url)
		charset="UTF-8"
		minvalue = 0
		html = open(url,{'Cache-Control' => 'no-cache'}) do |f|
			f.read
		end
		html = ChangeCode::utf_str(html)
		doc = Nokogiri::HTML.parse(html,nil,charset)
		elem = doc.xpath('//div[@id="mainLeft"]')
		if elem.xpath('//p[@class="fontPrice wordwrapPrice"]').text().length > 0 then
			pricelist = elem.xpath('//p[@class="fontPrice wordwrapPrice"]').text()
#			price = price.gsub(/[^0-9]/,"").to_i
			p pricelist.split(/[^\d,]/).each{|price|
				if price.length > 0 then
					price = price.gsub(/[^0-9]/,"").to_i
					if minvalue == 0 then
						minvalue = price
					elsif minvalue > price
						minvalue = price
					end
				end
			}
			return minvalue
		else
			print "nothing value\n"
		end
	end
end
