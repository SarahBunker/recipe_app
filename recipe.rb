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



  def display_list(list)
    result = list.split("\n").map do |item|
      "<li>#{item}</li>"
    end.join
    "<ul> #{result} </ul>"
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

get "/recipe/:recipe_id" do
  @recipe = @storage.load_recipe(params[:recipe_id])
  erb :recipe, layout: :layout
end

# not_found do
#   'This is nowhere to be found.'
# end

after do
  @storage.disconnect
end
