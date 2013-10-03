require 'net/http'
require 'uri'
require 'wsse'
require 'rexml/document'

body = nil

Net::HTTP.start('d.hatena.ne.jp'){ |http|
	req = Net::HTTP::Get.new('/kaakaa_hoe/atom/blog')
#	req.basic_auth 'kaakaa_hoe', 'sweden92'
#	res = http.request(req)
	res = http.get('/kaakaa_hoe/atom/blog', {'X-WSSE' => WSSE::header('kaakaa_hoe', 'sweden92')})
	body = res.body
}

doc = REXML::Document.new(body)
doc.elements.each('feed/entry') do |ele|
	ele.elements.each do |e|
		p e.name
	end
end
