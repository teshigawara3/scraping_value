#! ruby -Ku

require './product_dba'
require './user_dba'
require './mail_controller'
require './mail_contents'
require './utility'
include Utility

product_dba = ProductDba.new
users = UserDba.new.select_all
#site = SiteController.new
mail_controller = MailController.new

users.each{|user|
  products = product_dba.select_product_by_user_id(user.user_id)
  products.each{|product|
    mail_controller.create_message(user, product)    
	}
  mail_controller.do_send_mail(Mailcontents::FROM_ADDRESS, user.email)
  mail_controller.delete_all_files(change_dirformat_to_unixformat(Mailcontents::MAIL_FILE_PATH))
}

