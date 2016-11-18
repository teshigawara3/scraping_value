#! ruby -Ku
require './mail_contents'
require './product_dba'
require './user_dba'

class Makemail
	def initialize(user_id)
		@user_id=user_id
		@filename="./tmp/tmpmail_content_#{user_id}.txt"
	end

	def get_mail(user_id)
		mail_id=DbAccess.new.getmailid(user_id)
		return mail_id
	end

	def set_mail_destination
		File.open( @filename , "a") {|file|
			file.print(Mailcontents::FROM)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::TO)
			file.print(getmail(@user_id))
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CC)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::BCC)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::REPLY_TO)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::SUBJECT)
			file.print(Mailcontents::BACKSLASH)		
			file.close()
		}
	end

	def set_mail_content(product)
		if(product.error_flg == "0") then
			File.open( @filename ,"a") {|file|
				file.print(Mailcontents::CONTENTS01)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::CONTENTS02)
				file.print(product.first_value)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::CONTENTS03)
				file.print(product.last_value)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::CONTENTS04)
				file.print(product.last_value.to_i - product.first_value.to_i)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::BACKSLASH)
				file.close
			}
		elsif(product.error_flg == "1") then
			File.open( @filename ,"a") {|file|
				file.print(Mailcontents::ERRORMSG01)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::ERRORMSG02)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::BACKSLASH)
				file.close
			}
		elsif(product.error_flg == "2") then
			File.open( @filename ,"a") {|file|
				file.print(Mailcontents::ERRORMSG03)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::ERRORMSG04)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::URL)
				file.print(product.url)
				file.print(Mailcontents::BACKSLASH)
				file.print(Mailcontents::BACKSLASH)
				file.close
			}
		end
	end
end
