class Product
	attr_accessor :user_id, :url, :last_value, :first_value, :border_value,
		:error_flg

	def initialize
		@user_id=""
		@url=""
		@last_value=0
		@first_value=0
		@border_value=0
		@error_flg="0"
	end
end
