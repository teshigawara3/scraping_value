#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require 'kconv'
require './changecode'

url1='http://zozo.jp/shop/globalwork/goods/9484469/?did=23572857'
url2='http://qiita.com/riocampos/items/72b86103aa08532a5b30'
url3='http://zozo.jp/shop/shiffon/goods-sale/7611998/?did=20606200&rid=1068'
class Scrapingvalue
	def initialize(url)
		@url = url
	end
	
	def getvalue
		charset = nil
		html = open(@url) do |f|
			f.read
		end
		html = ChangeCode.new.utf_str(html)

		doc = Nokogiri::HTML.parse(html,nil,"UTF-8")
		price = doc.xpath('//div[@id="item-intro"]')
		if price.xpath('//p[@class="price"]').text().length > 0 then
			abcd = price.xpath('//p[@class="price"]').text()
			p abcd
		elsif price.xpath('//p[@class="price discount"]').text().length > 0 then
			abcd = price.xpath('//p[@class="price discount"]').text()
			p abcd
		else
			p "nothing value\n"
		end
	end
end

#aa = Scrapingvalue.new(url1).getvalue
#bb = Scrapingvalue.new(url2).getvalue
cc = Scrapingvalue.new(url3).getvalue

