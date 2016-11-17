class Product
	def initialize
		@user_id=""
		@url=""
		@last_value=0
		@first_value=0
		@borderprice=0
	end
	def user_id
		return @user_id
	end
	def user_id=(userid)
		@user_id = userid
	end
	def url
		return @url
	end
	def url=(url)
		@url = url
	end
	def last_value
		return @last_value
	end
	def last_value=(value)
		@last_value=value
	end
	def first_value
		return @first_value
	end
	def first_value=(value)
		@first_value=value
	end
	def borderprice
	 return @broderprice
	end
	def borderprice=(value)
		@borderprice = value
	end
end
