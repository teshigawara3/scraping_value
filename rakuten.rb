#! ruby -Ku

require 'open-uri'
require 'nokogiri'

url1='http://item.rakuten.co.jp/masashi/371307/#371307'

class Scrapingvalue
	def initialize(url)
		@url = url
	end
	
	def getvalue
		charset = nil
		html = open(@url) do |f|
			charset = f.charset
			f.read
		end
		doc = Nokogiri::HTML.parse(html,nil,charset)
		price = doc.xpath('//div[@id="pagebody"]')
		price.each{|value|
			p value.xpath('//span[@class="price2"]').text()
		}
	end
end

aa = Scrapingvalue.new(url1).getvalue

