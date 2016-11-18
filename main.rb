#! ruby -Ku

require './product_dba'
require './user_dba'
require './product'
require './site_controller'
require './make_mail'

product_dba = ProductDba.new
users = UserDba.new.select_all
site = SiteController.new

users.each{|user|
  products = product_dba.select_product_by_user_id(user.user_id)
  products.each{|product|
		if product.error_flg == 0 then
			latest_goods_value = site.get_value(product.url)
			if goodsvalue < 0 then
				# URLが間違っている場合とサイト自体が対応していない場合で分けるロジック要追加
				product.error_flg = 2
			else
				if product.first_value == 0 then
					product_dba.update(product)
				else
  				if product.last_value != latest_goods_value then
			      if (product.last_value - latest_goods_value).abs >= border_value then
							mail = MakeMail.new(user.user_id)
							if !File.exist?(mail.filename) then
                mail.set_mail_header(user.email)
							  mail.set_mail_content(product)
							else
								mail.set_mail_content(product)
							end
							#mail send login have to add
						end
							product_dba.update(product)
					end
				end				
			end
		else
	    if product.error_mail_send_flg != 0
			  error_mail = MakeMail.new(user.user_id)
				if !File.exist?(error_mail.filename) then
					error_mail.set_mail_header(user.email)
					error_mail.set_mail_content(product)
				else
					error_mail.set_mail_content(product)
				end
			end
		end
	}
}

