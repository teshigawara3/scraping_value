#! ruby -Ku	
require 'pg'
require 'yaml'

class Updateprice
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
end
