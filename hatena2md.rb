require 'net/http'
require 'uri'
require 'yaml'
require 'rexml/document'
require './model/BlogEntry.rb'
require 'wsse'

auth = YAML.load_file('auth.yml')

page = 1
entry_list = []
begin
	body = nil
	Net::HTTP.start('d.hatena.ne.jp'){ |http|
		res = http.get("/#{auth['id']}/atom/blog?page=#{page}", {'X-WSSE' => WSSE::header(auth['id'], auth['pass'])})
		body = res.body
	}
	doc = REXML::Document.new(body)
	list = []
	doc.elements.each('feed/entry') do |e|
		entry = BlogEntry.new(e)
		list << entry
		p "read entry => #{entry.title}"
	end
	entry_list += list
	page += 1
end while list.size != 0

p "==================="
p "CONPLETELY READING!"
p "==================="

home_dir = File.dirname(__FILE__)
Dir::mkdir("#{home_dir}/html") unless File.exists?("#{home_dir}/html")
Dir::mkdir("#{home_dir}/source") unless File.exists?("#{home_dir}/source")
entry_list.each do |e|
	file_name = "#{e.get_published_date}-#{e.article_id()}"
	p "write => #{file_name}"

	html_name = "#{home_dir}/html/#{file_name}.html"
	html = File.open(html_name, 'w')
	html << e.content
	html.close

	source_name = "#{home_dir}/source/#{file_name}.html.markdown"
	source = File.open(source_name,'w')
	source << "---\n"
	source << "title: #{e.get_entry_title()}\n"
	source << "date: #{e.get_published_date()}\n"
	source << "tags: #{e.get_tags()}\n"
	source << "---\n"
	source << "#{e.get_markdown_content()}"
	source.close
end
