#! ruby -Ku
require 'open-uri'
require 'nokogiri'

# スクレイピング先のURL
url = 'http://eiga.com/ranking/'

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

#p html
# htmlをパース(解析)してオブジェクトを作成
doc = Nokogiri::HTML.parse(html, nil, charset)

#doc.xpath('/html/body/div[@id="body"]/div[@id="main"]/div[@class="wrap_ctsBox"]/div[@class="ctsBox"]/div[@id="ranking_top"]/div[@id="rankBox"]/table/tbody/tr/td/em/a').each do |node|
doc.xpath('/html/body/div[@id="body"]/div[@id="main"]/div[@class="wrap_ctsBox"]/div[@class="ctsBox"]/div[@id="ranking_top"]/div[@id="rankBox"]/table/tbody/tr/td/a').each do |node|
  # tilte
	p node.text()
#  p node.css('img').attribute('alt').value

end
