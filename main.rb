#! ruby -Ku

require './productlist'
require './dbaccess'
require './product'
require './scraping_value'
require './make_mail'

user_id=""
productlist = DbAccess.new.getproductlist
scraping = Scrapingvalue.new
productlist.each{|product|
	if(product.error_flg == "0") then
		if(scraping.getvalue(product.url) < 0) then
			product.error_flg = "2"
		else
			product.last_value = scraping.getvalue(product.url)
		end
		if user_id != product.user_id then
			user_id = product.user_id
			mail = Makemail.new(user_id)
			mail.makemailfile
			mail.makemailcontent(product)
		else
			mail = Makemail.new(user_id)
			mail.makemailcontent(product)
		end
	#	upprice.updproduct(product)
	end
}

