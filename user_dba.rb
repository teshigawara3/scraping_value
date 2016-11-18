#! ruby -Ku	
require 'pg'
require 'yaml'
require './user'

class UserDba
	def select_all
		sql = "SELECT user_id,email FROM scraping.users ORDER BY user_id"
	  users = Array.new
	  dbconf = YAML.load_file("./database.yml")["db"]["development"]
	  connect = PG::connect(dbconf)
		results = connect.exec(sql)
	  #results = connect.exec("SELECT user_id,url,first_value,last_value,borderprice,error_flg FROM userurl ORDER BY user_id")
	  results.each{|result|
		  user = User.new
		  user.user_id = result["user_id"]
		  user.email = result["email"]
		  users << user
	  }
	  connect.finish
	  return users 
	end
end
