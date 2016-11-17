#! ruby -Ku	
require 'pg'
require 'yaml'
require './product'

class DbAccess
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
	def updprice(product)
	dbconf = YAML.load_file("./database.yml")["db"]["development"]
	connect = PG::connect(dbconf)
	connect.exec("UPDATE userurl SET
								first_value = CASE 
								WHEN first_value = 0 THEN $1
								ELSE first_value END,
								last_value=$1
								WHERE user_id=$2 AND url=$3", [product.last_value,product.user_id,product.url])
	connect.finish
	end
	def getmailid(user_id)
		mail_id=""
		dbconf = YAML.load_file("./database.yml")["db"]["development"]
		connect = PG::connect(dbconf)
		results = connect.exec("SELECT mail_id FROM userinfo WHERE user_id=$1", [user_id])
		results.each {|result|
			mail_id=result["mail_id"]
		}
		connect.finish
		return mail_id
	end
end
