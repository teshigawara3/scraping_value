#! ruby -Ku

require './productlist'
require './dbaccess'
require './product'
require './scraping_value'
require './make_mail'

productlist = DbAccess.new.getproductlist
value = Scrapingvalue.new
productlist.each{|product|
	mail_id=DbAccess.new.getmailid(product.user_id)
	product.last_value = value.getvalue(product.url)
	Makemail::makemail(product)
	#	upprice.updprice(product)
}

