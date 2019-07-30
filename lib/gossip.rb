require 'csv'
class Gossip

	attr_accessor :author, :content

	def initialize(author,content)  
		@author = author
		@content = content
	end	
	
	def save 
		 CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end
	
	def self.all 
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end	

	def self.find(id)
		id = id.to_i - 1
		data = CSV.read("./db/gossip.csv")
		return data[id]
	end	

	def self.update(id,content)
		id = id.to_i - 1 
		data = CSV.read("./db/gossip.csv")
		data[id][1] = content

		print data

		CSV.open("./db/gossip.csv","r+") do |csv|
			for i in 0..data.length - 1 do
				csv << data[i]
			end
		end
	end
end	