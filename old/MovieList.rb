class MovieList
	def initialize
		@movies = Array.new
	end
	def append(movie)
		@movies.push(movie)
		self
	end
	def delete_first
		@movies.shift
	end
	def delete_last
		@movies.pop
	end
	def [](index)
		@movies [index]
	end
	def search_title(title)
		@movies.find {|movie| title == movie.title}
	end
end
