require 'gossip'
class ApplicationController < Sinatra::Base
	get '/' do 
		erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/'do
		erb :new_gossip
	end	 

	post '/gossips/new/' do
		puts "Salut, je suis dans le serveur"
		puts "Ceci est le contenu du hash params : #{params}"
		Gossip.new(params["gossip_author"],params["gossip_content"]).save
		puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
  	puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
  	puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
		redirect '/' 
	end

	get '/gossips/:id' do 

	 	data = Gossip.find(params["id"])
	 	author = data[0]
	 	content = data[1]

	 	gossip = Gossip.new(author,content)

	 	erb :show, locals: {gossip: gossip, id: params["id"]}
	end		

	get '/gossips/:id/edit/' do 
				erb :edit, locals: {id: params["id"]}
	end
	post '/gossips/:id/edit/' do
		content = params["new_gossip_content"]
		Gossip.update(params["id"],content)
		redirect '/'
	end


end
