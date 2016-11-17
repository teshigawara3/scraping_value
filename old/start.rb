#! ruby -Ku
require "./scraping_movie_title.rb"
#require "./twitter_search.rb"

msList = ScrapingMovie.new.getMovies()
#msList.each do |movietitle|
#	p movietitle
#end
