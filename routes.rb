require_relative ("./data_base_mng.rb")

get '/' do
	@notes = Note.all :order => :id.desc
	@title = "All Notes"
	erb :home
end