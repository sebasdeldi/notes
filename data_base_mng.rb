require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/notes_app.db")

class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, Default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.auto_upgrade!

