#! ruby -Ku	
require 'pg'
require 'yaml'
require './product'

class ProductDba
	def select_all
	  products = Array.new
	  dbconf = YAML.load_file("./database.yml")["db"]["development"]
	  connect = PG::connect(dbconf)
	  results = connect.exec("SELECT user_id,url,first_value,last_value,
		                  border_value,error_flg,error_mail_send_flg 
		                  FROM scraping.goodsinfo ORDER BY user_id")
	  results.each{|result|
		  product = Product.new
		  product.user_id = result["user_id"]
	  	product.url = result["url"]
		  product.first_value = result["first_value"].to_i
		  product.last_value = result["last_value"].to_i
		  product.border_value = result["border_value"].to_i
	  	product.error_flg = result["error_flg"].to_i
		  products << product
	  }
	  connect.finish
	  return products
	end

	def select_product_by_user_id(user_id)
		products = Array.new
		dbconf = YAML.load_file("./database.yml")["db"]["development"]
		connect = PG::connect(dbconf)
		results = connect.exec("SELECT user_id,url,first_value,last_value,
												   border_value,error_flg,error_mail_send_flg 
                           FROM scraping.goodsinfo WHERE user_id = $1 ORDER BY user_id",
													 [user_id])
		results.each{|result|
			product = Product.new
		  product.user_id = result["user_id"]
	  	product.url = result["url"]
		  product.first_value = result["first_value"].to_i
		  product.last_value = result["last_value"].to_i
		  product.border_value = result["border_value"].to_i
	  	product.error_flg = result["error_flg"].to_i
			product.error_mail_send_flg = result["error_mail_send_flg"].to_i
		  products << product			
		}
    connect.finish
		return products
	end

	def update_value(product)
	  dbconf = YAML.load_file("./database.yml")["db"]["development"]
	  connect = PG::connect(dbconf)
	  connect.exec("UPDATE scraping.goodsinfo SET
					  			first_value = CASE 
						  		WHEN first_value = 0 THEN $1
							  	ELSE first_value END,
								  last_value=$1
								  WHERE user_id=$2 AND url=$3", 
									[product.last_value,product.user_id,product.url])
	  connect.finish
	end

	def update_error_mail_send_flg(product)
	  dbconf = YAML.load_file("./database.yml")["db"]["development"]
	  connect = PG::connect(dbconf)
	  connect.exec("UPDATE scraping.goodsinfo SET
					  			error_mail_send_flg = 1 
								  WHERE user_id=$1 AND url=$2", 
									[product.user_id,product.url])
	  connect.finish
	end
end
