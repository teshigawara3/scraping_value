#! ruby -Ku	
require 'pg'
require 'yaml'
require './product'

class ProductList
	def getproductlist
#	user_id="000"
	productlist = Array.new
#	urllist = Hash.new	
	dbconf = YAML.load_file("./database.yml")["db"]["development"]
	connect = PG::connect(dbconf)
	results = connect.exec("SELECT user_id,url,first_value,last_value,borderprice FROM userurl")
	results.each{|result|
		pro = Product.new
		pro.user_id=result["user_id"]
		pro.url=result["url"]
		pro.first_value=result["first_value"]
		pro.last_value=result["last_value"]
		pro.borderprice=result["borderprice"]
		productlist.push(pro)
	}
	connect.finish
	return productlist 
	end
end
