-- psql -d recipes < schema.sql
-- \i ~/Documents/LS/recipe_app/schema.sql
-- pg_dump recipes > backup.sql

DROP TABLE IF EXISTS recipes, ingredients, ingredient_recipe, directions, planned_meals;

CREATE TABLE recipes (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE,
  author text,
  servings int,
  cook_time int,
  url_link text,
  difficulty varchar(6) CHECK (difficulty IN ('hard', 'medium', 'easy')),
  meal_type varchar(10) CHECK (meal_type IN ('breakfast', 'lunch', 'dinner')),
  labels text,
  ingredients text NOT NULL,
  directions text NOT NULL,
  create_at timestamp DEFAULT NOW(),
  favorite boolean DEFAULT false
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


-- INSERT INTO recipes (name, difficulty, meal_type)
-- VALUES ('spagehtti', 'easy', 'dinner');
--
INSERT INTO recipes
VALUES (DEFAULT,
  'Dumplinigs', 'Carol', 6, 20, 'https://www.allrecipes.com/recipe/6900/dumplings/', 'easy', 'dinner', 'potatoes, pasta',
  '1 cup all-purpose flour, 2 teaspoons baking powder, 1 teaspoon white sugar, ½ teaspoon salt, 1 tablespoon margarine, ½ cup milk',
  'Step 1 Stir together flour, baking powder, sugar, and salt in a bowl. Cut in butter until mixture is crumbly. Stir in milk and mix until a batter forms that is thick enough to be scooped with a spoon. Allow batter to rest for 3 to 5 minutes..
  Step 2 Drop batter by spoonfuls into boiling stew or soup. Cover and simmer without lifting the lid for 15 minutes. Serve.',
  DEFAULT, DEFAULT);

INSERT INTO recipes
VALUES (DEFAULT,
  'Granola', 'Cookie and Kate', 16, 26, 'https://cookieandkate.com/healthy-granola-recipe/#tasty-recipes-23967-jump-target', 'easy', 'breakfast', 'oats, cereal',

  '4 cups old-fashioned rolled oats (use certified gluten-free oats for gluten-free granola)
  1 1/2 cup raw nuts and/or seeds (I used 1 cup pecans and 1/2 cup pepitas)
  1 teaspoon fine-grain sea salt (if you’re using standard table salt, scale back to 3/4 teaspoon)
  1/2 teaspoon ground cinnamon
  1/2 cup melted coconut oil or olive oil
  1/2 cup maple syrup or honey
  1 teaspoon vanilla extract
  2/3 cup dried fruit, chopped if large (I used dried cranberries)
  Totally optional additional mix-ins: 1/2 cup chocolate chips or coconut flakes*',

  'Preheat oven to 350 degrees Fahrenheit and line a large, rimmed baking sheet with parchment paper.
  In a large mixing bowl, combine the oats, nuts and/or seeds, salt and cinnamon. Stir to blend.
  Pour in the oil, maple syrup and/or honey and vanilla. Mix well, until every oat and nut is lightly coated. Pour the granola onto your prepared pan and use a large spoon to spread it in an even layer.
  Bake until lightly golden, about 21 to 24 minutes, stirring halfway (for extra-clumpy granola, press the stirred granola down with your spatula to create a more even layer). The granola will further crisp up as it cools.
  Let the granola cool completely, undisturbed (at least 45 minutes). Top with the dried fruit (and optional chocolate chips, if using). Break the granola into pieces with your hands if you want to retain big chunks, or stir it around with a spoon if you don’t want extra-clumpy granola.
  Store the granola in an airtight container at room temperature for 1 to 2 weeks, or in a sealed freezer bag in the freezer for up to 3 months. The dried fruit can freeze solid, so let it warm to room temperature for 5 to 10 minutes before serving.',
  DEFAULT, DEFAULT);


SELECT name, difficulty, meal_type FROM recipes;
