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

  def display_n_recipe_links(recipes)
    result = recipes.map do |recipe|
      "<li><h4><a href='/recipe/#{recipe[:id]}'>#{recipe[:name]}</a></h4></li>"
    end.join
    "<ul> #{result} </ul>"
  end

  def display_label_links(recipe)
    result = recipe[:labels].split.map do |label|
      "<li><h4><a href='/recipe/#{label}'>#{label.capitalize}</a></h4></li>"
    end.join
    "<ul> #{result} </ul>"
  end
end

before do
  @storage = DatabasePersistence.new(logger)
end

get "/home" do
  redirect "/"
end

get "/" do
  @recipes_popular = @storage.search_popular
  @recipes_recent = @storage.search_recent
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

get "/search" do
  @query = params[:query]
  @query = 'fun' if params[:query] == nil
  @recipes = @storage.search_recipes(@query)
  erb :search, layout: :layout
end

get "/search/:meal_type" do
  @type = params[:meal_type].downcase
  @recipes = @storage.search_mealtype(@type)
  @title = "#{@type.capitalize} Recipes"
  erb :meal_type, layout: :layout
end

get "/find/:label" do
  @label = params[:label]
  @recipes = @storage.search_recipes(@label)
  @title = "Recipes with '#{@label.capitalize}'"
  erb :meal_type, layout: :layout
end

get "/allrecipes" do
  @recipes = @storage.allrecipes
  @title = "All Recipes"
  erb :meal_type, layout: :layout
end

# not_found do
#   'This is nowhere to be found.'
# end

after do
  @storage.disconnect
end
