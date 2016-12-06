#app.rb
require "sinatra"
require "sinatra/activerecord"

set :database, {adapter: "squlite3", database: "database.db"}
# # or set :database_file "path/to/database.yml"

class App < Sinatra::Base
	register Sinatra::ActiveRecordExtension
end
