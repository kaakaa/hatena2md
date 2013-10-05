class Entry
	attr_accessor :id
	attr_accessor :published
	attr_accessor :title
	attr_accessor :content

	def make_link
		hash = {}
		name = @id.split(",")[0].split(":")[1]
		ele = @id.split(",")[1].split(":")[1].split("-")
		return "http://#{name}/#{ele[1]}/#{ele[2]}##{ele[3]}"
	end

	def get_published_date
		return @published.split("T")[0]
	end
end
