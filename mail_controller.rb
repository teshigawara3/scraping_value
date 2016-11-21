#! ruby -Ku
require './mail_contents'
require './product_dba'
require './site_controller'
require './set_mail_content'
include SetMailContent

class MailController
	def create_message(user, product)
		site = SiteController.new
    product_dba = ProductDba.new

    if product.error_flg == 0 then
      latest_goods_value = site.get_value(product.url)
      if latest_goods_value < 0 then
		  # URLが間違っている場合とサイト自体が対応していない場合で分けるロジック要追加
			  product.error_flg = 2
		  else
			  if product.first_value == 0 then
				  product.last_value = latest_goods_value
			    product_dba.update_value(product)
			  else
  			  if product.last_value != latest_goods_value then
			      if (product.last_value - latest_goods_value).abs >= product.border_value then
						  mail_filename = Mailcontents::MAIL_FILE_PATH + user.user_id + 
								         Mailcontents::MAIL_FILE_EXTENSION 
						  if !File.exist?(mail_filename) then
                set_mail_header(mail_filename, user.email)
								p product
							  set_mail_content(mail_filename, product)
						  else
							  set_mail_content(mail_filename, product)
						  end
					  end
						  product_dba.update_value(product)
				  end
			  end				
		  end
	  else
	    if product.error_mail_send_flg != 0 then
			  mail_filename = Mailcontents::MAIL_FILE_PATH + user.user_id + 
					         Mailcontents::MAIL_FILE_EXTENSION 
			  if !File.exist?(mail_filename) then
				  set_mail_header(mail_filename, user.email)
				  set_mail_content(mail_filename, product)
			  else
				  set_mail_content(mail_filename, product)
			  end
			  product_dba.update_error_mail_send_flg(product)
		  end
	  end
	end

	def do_send_mail(from, to)
    mail_files = Array.new
		mail_flles = %x[ ls #{Mailcontents::MAIL_FILE_PATH} ]
		mail_files.each{|mail_file|
			%x[ sendmail -f #{from} -t #{to} ]
		}
	end

	def delete_all_files(dir)
		files = dir + '*'
    File.delete(*Dir.glob("#{files}"))
	end
end
