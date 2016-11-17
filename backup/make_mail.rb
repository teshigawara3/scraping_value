#! ruby -Ku
require './mail_contents'
require './dbaccess'

class Makemail
	@@count=0
	def self.makemail(product)
		mailcontent = Mailcontents.new
		mailcontent.mail_id=DbAccess.new.getmailid(product.user_id)
		filename="./tmp/test#{@@count}.txt"
		File.open(filename,"w") { |file|
			file.print(Mailcontents::FROM)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::TO)
			file.print(mailcontent.mail_id)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CC)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::BCC)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::REPLY_TO)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::SUBJECT)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CONTENTS01)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CONTENTS02)
			file.print(product.first_value)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CONTENTS03)
			file.print(product.last_value)
			file.print(Mailcontents::BACKSLASH)
			file.print(Mailcontents::CONTENTS04)
			file.print(product.first_value.to_i - product.last_value.to_i)
			file.print(Mailcontents::BACKSLASH)
			file.close
		}
		@@count+=1
	end
end
