-- psql -d recipes < schema.sql
-- \i ~/Documents/LS/recipe_app/schema.sql

DROP TABLE IF EXISTS recipes;

CREATE TABLE recipes (
  id serial PRIMARY KEY,
  name text NOT NULL,

);
