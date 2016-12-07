#app.rb
require "sinatra"
require "sinatra/base"
require 'sinatra/reloader' if development?
require "sinatra/activerecord"
require 'byebug'

require 'awesome_print'

require "./models"

set :database, {adapter: "sqlite3", database: "db/database.db"}
# # or set :database_file "path/to/database.yml"

class App < Sinatra::Base
        register Sinatra::ActiveRecordExtension

        def current_user
                @current_user ||= User.find_by_email('ivey@gitthisdev.com')
        end

        get '/' do
          haml :home
        end

        get '/users' do
          @users = User.all
          haml :users
        end

        get '/users/create' do
          User.create(first_name: 'First Name', last_name: 'Last Name', email: 'happy@123.com')
          haml :user
        end

        get '/users/last' do
          @user = User.last
          haml :user
        end

        get '/users/:id' do
          @user = User.find(params[:id])
          haml :user
        end

        run! if __FILE__ == $0
end
