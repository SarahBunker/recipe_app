require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

require_relative "database_persistence"

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure (:development) do
  require "sinatra/reloader"
  also_reload "database_persistence.rb"
end

helpers do
end

# Other methods

before do
  @storage = DatabasePersistence.new(logger)
end

get "/home" do
  redirect "/"
end

get "/" do
  erb :home, layout: :layout
end

get "/new_recipe" do
  erb :add_recipe, layout: :layout
end

get "/granola" do
  erb :recipe, layout: :layout
end

get "/hello_world" do
  "Hello Emily"
end

# not_found do
#   'This is nowhere to be found.'
# end

after do
  @storage.disconnect
end
