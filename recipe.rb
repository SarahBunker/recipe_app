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

get "/add_recipe" do
  erb :add_recipe, layout: :layout
end

post "/add_recipe" do
  @storage.add_recipe(params)
  redirect "/"
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip

  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :new_list, layout: :layout
  else
    @storage.create_new_list(list_name)
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end

get "/granola" do
  erb :recipe, layout: :layout
end

# not_found do
#   'This is nowhere to be found.'
# end

after do
  @storage.disconnect
end
