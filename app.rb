# REST
#get /posts         => Show all Posts
#get /posts/:id     => Show Post
#get /posts/new     => Shows the form for creating a post
#post /posts/create => Create Post
#get /posts/:id/edit => Edit Post
#post/put /posts/:id/update => Update Post
#post /posts/:id/delete

#app.rb
require "sinatra"
require "sinatra/base"
#require 'sinatra/reloader' if development?
require "sinatra/activerecord"
require 'byebug'

require 'awesome_print'

require "./models"

#Load Sinatra-Flash
require 'sinatra/flash'

def seed
  user1 = User.create(username: 'ivey', password: 'password', first_name: 'Ivey', last_name: 'Taylor', email: 'ivey@gitthisdev.com')
  user2 = User.create(username: 'demo', password: 'password', first_name: 'Demo', last_name: 'Last', email: 'demo@demo.com')
  blog1 = Blog.create(slug: 'blog1',title: 'Ivey Blog',user_id: user1.id)
  blog2 = Blog.create(slug: 'blog2', title: 'Demo Blog',user_id: user2.id)
  post1 = Post.create(slug:'first_post', title: 'First Post', blog_id: blog1.id)
  post2 = Post.create(slug:'different_post', title: 'First Demo Post', blog_id: blog2.id)
end

set :database, {adapter: "sqlite3", database: "db/database.db"}
# # or set :database_file "path/to/database.yml"
#


class App < Sinatra::Base
        register Sinatra::ActiveRecordExtension

        enable :sessions
        register Sinatra::Flash

        def current_user
          if session[:user_id]
            @current_user ||= User.find(session[:user_id])
          end
        end

        get '/' do
          @top_ten_posts = Post.last(10)
          haml :home
        end

        get '/profile' do
          haml :profile
        end

        post '/profile' do
          puts "Params: " + params.inspect
          if current_user.update_attributes(params[:user])
            @message = 'Profile Updated!'
          end
          haml :profile
        end

        get '/profile/delete' do
        if User.destroy(current_user.id)
          session[:user_id] = nil

            @message = 'Profile Deleted!'

          end

          redirect '/'
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

        get '/blogs/:slug' do
          @blog = Blog.find_by_slug(params[:slug])
          haml :blog
        end

        get '/sign_in' do
         haml :sign_in
        end

        get '/sessions/new' do
          haml :sign_in
        end

        get '/sign_up' do
          haml :sign_up
        end

        post '/sign_up' do
          puts "Params: " + params.inspect
          if @user = User.create(username: params[:username], first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
          #byebug
            #session[:user_id] = @user.id
            flash[:info] = "Thanks for signing up for my blog!"
            redirect '/sign_in'
          else
            puts "Uh-oh! Something went wrong."
            @error = "Sign-up Failed"
            haml :sign_up
          end
        end

        post '/sessions/create' do
          puts "Params: " + params.inspect
          if  @user = User.where(username: params[:username], password: params[:password]).first
             puts 'Login Success'
             session[:user_id] = @user.id
             #byebug
             flash[:info] = 'You logged in successfully!'
             #haml :success
             redirect '/'
         else
             puts 'Failed Login Attempt'
             @error = 'Login Failed'
             haml :sign_in
          end
        end

       get '/create_post' do
         haml :create_post
       end

       post '/create_post' do
          @post = Post.new(params[:post])
          if @post.save
            flash[:info] = 'Post Created!'
            redirect "/blogs/#{current_user.blog.slug}"
          else
            flash.now[:error] = 'We have a problem! Please fix it!'
            haml :create_post
          end
       end

        get '/logout' do
          session[:user_id] = nil
          redirect '/'
        end

        run! if __FILE__ == $0
end
