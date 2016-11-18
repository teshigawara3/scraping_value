require 'nkf'

class ChangeCharCode
	
	def self.utf_str(inputstr)
		inputcode = ""
		outputcode = "UTF-8"
		utf_str = ""
		inputcode = NKF.guess(inputstr).to_s
		if inputcode != outputcode then
			utf_str = inputstr.encode(outputcode,inputcode, 
						                    :invalid => :replace,
																:undef => :replace, 
																:replace => "")
		elsif
			utf_str = inputstr
		end
		return utf_str
	end

end
