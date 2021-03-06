require "pg"

class DatabasePersistence
  def initialize(logger)
    @db = if Sinatra::Base.production?
        PG.connect(ENV['DATABASE_URL'])
      else
        PG.connect(dbname: "recipes")
      end
    @logger = logger
  end

  def add_recipe(params)
    sql = <<~SQL
    INSERT INTO recipes
    VALUES (DEFAULT, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, DEFAULT);
    SQL
    params[:url_link] = 'not_provided' if params[:url_link] == nil
    query(sql, params[:name], params[:author], params[:servings], params[:cook_time], params[:url_link], params[:difficulty], params[:meal_type], params[:labels], params[:ingredients], params[:directions])
  end

  def load_recipe(recipe_id)
    sql = <<~SQL
    SELECT * FROM recipes WHERE id = $1
    SQL
    result = query(sql, recipe_id)
    tuple_to_recipe_hash(result.first)
  end

  def update_recipe(params)
    sql = <<~SQL
    UPDATE recipes
      SET name = $1,
          author = $2,
          servings = $3,
          cook_time = $4,
          url_link = $5,
          difficulty = $6,
          meal_type = $7,
          labels = $8,
          ingredients = $9,
          directions = $10
    WHERE id = $11
    SQL
    params[:url_link] = 'not_provided' if params[:url_link] == nil
    query(sql, params[:name], params[:author], params[:servings], params[:cook_time], params[:url_link], params[:difficulty], params[:meal_type], params[:labels], params[:ingredients], params[:directions], params[:recipe_id].to_i)
  end

  def delete_recipe(recipe_id)
    # FIXME
  end

  def allrecipes
    sql = <<~SQL
    SELECT * FROM recipes
    ORDER BY name
    SQL
    recipes = query(sql)
    recipes.map do |recipe|
      tuple_to_recipe_hash(recipe)
    end
  end

  def search_recipes(term)
    sql = <<~SQL
    SELECT * FROM recipes
    WHERE labels ~ $1
    SQL
    recipes = query(sql, term)
    recipes.map do |recipe|
      tuple_to_recipe_hash(recipe)
    end
  end

  def search_recent
    sql = <<~SQL
    SELECT * FROM recipes
    ORDER BY create_at DESC
    LIMIT 3
    SQL
    recipes = query(sql)
    recipes.map do |recipe|
      tuple_to_recipe_hash(recipe)
    end
  end

  def search_popular
    sql = <<~SQL
    SELECT * FROM recipes
    WHERE favorite = true
    LIMIT 3
    SQL
    recipes = query(sql)
    recipes.map do |recipe|
      tuple_to_recipe_hash(recipe)
    end
  end

  def search_mealtype(type)
    sql = <<~SQL
    SELECT * FROM recipes
    WHERE meal_type ~ $1
    SQL
    recipes = query(sql, type)
    recipes.map do |recipe|
      tuple_to_recipe_hash(recipe)
    end
  end

  def tuple_to_recipe_hash(tuple)
    { id: tuple["id"].to_i,
      name: tuple["name"],
      author: tuple["author"],
      servings: tuple["servings"].to_i,
      cook_time: tuple["cook_time"].to_i,
      url_link: tuple["url_link"],
      difficulty: tuple["difficulty"],
      meal_type: tuple["meal_type"],
      labels: tuple["labels"],
      ingredients: tuple["ingredients"],
      directions: tuple["directions"]
    }
  end

  def split_newlines(collection)
    collection.split("/n")
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def disconnect
    @db.close
  end
end
