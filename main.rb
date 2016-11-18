#! ruby -Ku

require './product_dba'
require './user_dba'
require './product'
require './site_controller'
require './make_mail'

products = ProductDba.new.select_all
site = SiteController.new
products.each{|product|
	if(product.error_flg == "0") then
		if(site.getvalue(product.url) < 0) then
			product.error_flg = "2"
		else
			product.last_value = site.getvalue(product.url)
		end

		if user_id != product.user_id then
			user_id = product.user_id
			mail = Makemail.new(user_id)
			mail.set_mail_destination
			mail.set_mail_content(product)
		else
			mail = Makemail.new(user_id)
			mail.set_mail_content(product)
		end
	#	upprice.updproduct(product)
	end
}

