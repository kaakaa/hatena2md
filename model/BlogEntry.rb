require 'pandoc-ruby'


class BlogEntry
	attr_accessor :id
	attr_accessor :published
	attr_accessor :title
	attr_accessor :content

	def initialize(entry)
		@id = entry.elements['id'].text
		@published = entry.elements['published'].text
		@title = entry.elements['title'].text
		@content = entry.elements['content'].text
	end

	def article_id
		array = @id.split('-')
		return array[array.size-1]
	end

	def make_link
		hash = {}
		name = @id.split(",")[0].split(":")[1]
		ele = @id.split(",")[1].split(":")[1].split("-")
		return "http://#{name}/#{ele[1]}/#{ele[2]}##{ele[3]}"
	end

	def get_published_date
		return @published.split("T")[0]
	end

	def get_markdown_content
		return PandocRuby.convert(@content, :from => :html, :to => :markdown)
	end

	def get_entry_title
		return @title.gsub(/\[.*\]/,'')
	end

	def get_tags
		array = @title.split(']')
		tags = []
		for i in 0..array.size-2
			tags << array[i].gsub('[','')
		end
		return tags.join(',')
	end
end
