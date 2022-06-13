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
    query(sql,params[:name], params[:author], params[:servings], params[:cook_time], params[:url_link], params[:difficulty], params[:meal_type], params[:labels], params[:ingredient_list], params[:directions])
  end

  def load_recipe(recipe_id)
    sql = <<~SQL
    SELECT * FROM recipes WHERE id = $1
    SQL
    result = query(sql, recipe_id)
    tuple_to_recipe_hash(result.first)
  end

  def tuple_to_recipe_hash(tuple)
    { id: tuple["id"].to_i,
      name: tuple["name"]}
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def disconnect
    @db.close
  end
end
