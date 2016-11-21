module Utility
  def change_dirformat_to_unixformat(windows_dirformat)
		windows_dirformat.gsub(/C:\\|\\/i, 'C:\\'=>'/', '\\'=>'/')
	end
end
