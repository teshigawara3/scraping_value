#! ruby -Ku

require 'open-uri'
require 'nokogiri'
require './movie'
require './MovieList'

class ScrapingMovie
	def initialize
		@url = 'http://eiga.com/ranking/'
	end
	
	def getMovies
		charset = nil
		html = open(@url) do |f|
			charset = f.charset
			f.read
		end

		doc = Nokogiri::HTML.parse(html,nil,charset)
		msList = MovieList.new
		doc.xpath('//div[@id = "rankBox"]//a').each do |title|
			p title.css('img').attribute('alt').value
#			title.css('img').map do |alt|
#				ms = Movie.new(alt.attribute('alt').value)
#				msList.push(ms)
#			end
		end

		return msList
	end
end

