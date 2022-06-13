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
  def format_cook_time(time)
    hrs = time / 60
    mins = time % 60
    hrs > 0 ? "#{hrs} hrs #{mins} mins" : "#{mins} mins"
  end
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

get "/hello" do
  "Hello World"
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

get "/dumplings" do
  @recipe = @storage.load_recipe(2)
  erb :recipe, layout: :layout
end

get "/granola" do
  @recipe = @storage.load_recipe(3)
  p @recipe
  erb :recipe, layout: :layout
end

# not_found do
#   'This is nowhere to be found.'
# end

after do
  @storage.disconnect
end
