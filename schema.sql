-- psql -d recipes < schema.sql
-- \i ~/Documents/LS/recipe_app/schema.sql

DROP TABLE IF EXISTS recipes, ingredients, ingredient_recipe, directions, planned_meals;

CREATE TABLE recipes (
  id serial PRIMARY KEY,
  name text NOT NULL,
  author text,
  servings int,
  cook_time int,
  url text,
  difficulty varchar(6) CHECK (difficulty IN ('hard', 'medium', 'easy')),
  meal_type varchar(10) CHECK (meal_type IN ('breakfast', 'lunch', 'dinner')),
  labels text,
  ingredients text,
  directions text,
  create_at timestamp DEFAULT NOW()
);

-- CREATE TABLE ingredients (
--   id serial PRIMARY KEY,
--   name text NOT NULL,
--   units text,
--   description text,
-- );
--
-- CREATE TABLE ingredient_recipe (
--   id serial PRIMARY KEY,
--   amount integer NOT NULL,
--   ingredient_id integer NOT NULL REFERENCES ingredient_id(id) ON DELETE CASCADE
--   recipe_id integer NOT NULL REFERENCES recipes(id) ON DELETE CASCADE
-- );

-- CREATE TABLE directions (
--   id serial PRIMARY KEY,
--   step_number integer,
--   step_text text,
--   recipe_id integer NOT NULL REFERENCES recipes(id) ON DELETE CASCADE
-- );

CREATE TABLE planned_meals (
  id serial PRIMARY KEY,
  day_of_week varchar(3)
    CHECK (day_of_week IN ('sun','mon','tue','wed', 'thu','fri','sat')),
  meal_of_day varchar(10) CHECK (meal_of_day IN ('breakfast', 'lunch', 'dinner'))
);


INSERT INTO recipes (name, difficulty, meal_type)
VALUES ('spagehtti', 'easy', 'dinner');

-- INSERT INTO recipes
-- VALUES (DEFAULT, 'Dumplinigs', 'Carol', 6, 20, 'https://www.allrecipes.com/recipe/6900/dumplings/', 'easy', 'dinner', 'potatoes, pasta', '1 cup all-purpose flour, 2 teaspoons baking powder, 1 teaspoon white sugar, ½ teaspoon salt, 1 tablespoon margarine, ½ cup milk', 'Step 1 Stir together flour, baking powder, sugar, and salt in a bowl. Cut in butter until mixture is crumbly. Stir in milk and mix until a batter forms that is thick enough to be scooped with a spoon. Allow batter to rest for 3 to 5 minutes..
-- Step 2 Drop batter by spoonfuls into boiling stew or soup. Cover and simmer without lifting the lid for 15 minutes. Serve.', DEFAULT);


SELECT * FROM recipes;
