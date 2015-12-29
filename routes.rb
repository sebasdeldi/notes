require 'data_mapper'
require 'sinatra'

require_relative ("./data_base_mng.rb")

get '/' do
    @notes = Note.all :order => :id.desc
    @title = "All Notes"
    erb :home
end

post '/' do
	n = Note.new
	n.content = params[:content]
	n.created_at = Time.now
	n.updated_at = Time.now
	n.save
	redirect '/'
end

get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end