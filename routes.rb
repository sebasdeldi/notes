require 'data_mapper'
require 'sinatra'
require_relative ("./data_base_mng.rb")
require 'sinatra/flash'

enable :sessions

SITE_TITLE = "Notes"
SITE_DESCRIPTION = "'cause you're too dumb to remember"

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

    if n.save
        flash[:notice] = 'Note created successfully.'
        redirect '/'
    else
        flash[:error] = 'Failed to save note.'
        redirect '/'
    end

end


get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note #{params[:id]}"
  erb :edit
end


put '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.updated_at = Time.now
  if n.save
      flash[:notice] = 'Note updated successfully.'
      redirect '/'
  else
      flash[:error] = 'Failed to update note.'
      redirect '/'
  end
end

get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note #{params[:id]}"
  erb :delete
end

delete '/:id' do
	n = Note.get params[:id]


	if n.destroy
	    flash[:notice] = 'Note deleted successfully.'
	    redirect '/'
	else
	    flash[:error] = 'Failed to delete note.'
	    redirect '/'
	end
end

get '/:id/complete' do
  n = Note.get params[:id]
  n.complete = n.complete ? 0 : 1
  n.updated_at = Time.now
  if n.save
      flash[:notice] = 'Note clompleted successfully.'
      redirect '/'
  else
      flash[:error] = 'Failed to complete note.'
      redirect '/'
  end
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

