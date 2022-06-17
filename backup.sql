--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4 (Ubuntu 14.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 14.4 (Ubuntu 14.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: planned_meals; Type: TABLE; Schema: public; Owner: sarahnd
--

CREATE TABLE public.planned_meals (
    id integer NOT NULL,
    day_of_week character varying(3),
    meal_of_day character varying(10),
    CONSTRAINT planned_meals_day_of_week_check CHECK (((day_of_week)::text = ANY ((ARRAY['sun'::character varying, 'mon'::character varying, 'tue'::character varying, 'wed'::character varying, 'thu'::character varying, 'fri'::character varying, 'sat'::character varying])::text[]))),
    CONSTRAINT planned_meals_meal_of_day_check CHECK (((meal_of_day)::text = ANY ((ARRAY['breakfast'::character varying, 'lunch'::character varying, 'dinner'::character varying])::text[])))
);


ALTER TABLE public.planned_meals OWNER TO sarahnd;

--
-- Name: planned_meals_id_seq; Type: SEQUENCE; Schema: public; Owner: sarahnd
--

CREATE SEQUENCE public.planned_meals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planned_meals_id_seq OWNER TO sarahnd;

--
-- Name: planned_meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarahnd
--

ALTER SEQUENCE public.planned_meals_id_seq OWNED BY public.planned_meals.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: sarahnd
--

CREATE TABLE public.recipes (
    id integer NOT NULL,
    name text NOT NULL,
    author text,
    servings integer,
    cook_time integer,
    url_link text,
    difficulty character varying(6),
    meal_type character varying(10),
    labels text,
    ingredients text NOT NULL,
    directions text NOT NULL,
    create_at timestamp without time zone DEFAULT now(),
    favorite boolean DEFAULT false,
    CONSTRAINT recipes_difficulty_check CHECK (((difficulty)::text = ANY ((ARRAY['hard'::character varying, 'medium'::character varying, 'easy'::character varying])::text[]))),
    CONSTRAINT recipes_meal_type_check CHECK (((meal_type)::text = ANY ((ARRAY['breakfast'::character varying, 'lunch'::character varying, 'dinner'::character varying])::text[])))
);


ALTER TABLE public.recipes OWNER TO sarahnd;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: sarahnd
--

CREATE SEQUENCE public.recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_id_seq OWNER TO sarahnd;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarahnd
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: planned_meals id; Type: DEFAULT; Schema: public; Owner: sarahnd
--

ALTER TABLE ONLY public.planned_meals ALTER COLUMN id SET DEFAULT nextval('public.planned_meals_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: sarahnd
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Data for Name: planned_meals; Type: TABLE DATA; Schema: public; Owner: sarahnd
--

COPY public.planned_meals (id, day_of_week, meal_of_day) FROM stdin;
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: sarahnd
--

COPY public.recipes (id, name, author, servings, cook_time, url_link, difficulty, meal_type, labels, ingredients, directions, create_at, favorite) FROM stdin;
1	Dumplinigs	Carol	6	20	https://www.allrecipes.com/recipe/6900/dumplings/	easy	dinner	potatoes, pasta	1 cup all-purpose flour, 2 teaspoons baking powder, 1 teaspoon white sugar, ½ teaspoon salt, 1 tablespoon margarine, ½ cup milk	Step 1 Stir together flour, baking powder, sugar, and salt in a bowl. Cut in butter until mixture is crumbly. Stir in milk and mix until a batter forms that is thick enough to be scooped with a spoon. Allow batter to rest for 3 to 5 minutes..\n  Step 2 Drop batter by spoonfuls into boiling stew or soup. Cover and simmer without lifting the lid for 15 minutes. Serve.	2022-06-17 08:32:58.516042	f
2	Granola	Cookie and Kate	16	26	https://cookieandkate.com/healthy-granola-recipe/#tasty-recipes-23967-jump-target	easy	breakfast	oats, cereal	4 cups old-fashioned rolled oats (use certified gluten-free oats for gluten-free granola)\n  1 1/2 cup raw nuts and/or seeds (I used 1 cup pecans and 1/2 cup pepitas)\n  1 teaspoon fine-grain sea salt (if you’re using standard table salt, scale back to 3/4 teaspoon)\n  1/2 teaspoon ground cinnamon\n  1/2 cup melted coconut oil or olive oil\n  1/2 cup maple syrup or honey\n  1 teaspoon vanilla extract\n  2/3 cup dried fruit, chopped if large (I used dried cranberries)\n  Totally optional additional mix-ins: 1/2 cup chocolate chips or coconut flakes*	Preheat oven to 350 degrees Fahrenheit and line a large, rimmed baking sheet with parchment paper.\n  In a large mixing bowl, combine the oats, nuts and/or seeds, salt and cinnamon. Stir to blend.\n  Pour in the oil, maple syrup and/or honey and vanilla. Mix well, until every oat and nut is lightly coated. Pour the granola onto your prepared pan and use a large spoon to spread it in an even layer.\n  Bake until lightly golden, about 21 to 24 minutes, stirring halfway (for extra-clumpy granola, press the stirred granola down with your spatula to create a more even layer). The granola will further crisp up as it cools.\n  Let the granola cool completely, undisturbed (at least 45 minutes). Top with the dried fruit (and optional chocolate chips, if using). Break the granola into pieces with your hands if you want to retain big chunks, or stir it around with a spoon if you don’t want extra-clumpy granola.\n  Store the granola in an airtight container at room temperature for 1 to 2 weeks, or in a sealed freezer bag in the freezer for up to 3 months. The dried fruit can freeze solid, so let it warm to room temperature for 5 to 10 minutes before serving.	2022-06-17 08:32:58.518744	f
3	Fettuccine Alfredo	Modern Honey	6	20	https://www.modernhoney.com/fettuccine-alfredo/	medium	dinner	pasta, italian	1 lb Fettuccine Pasta\r\n6 Tablespoons Butter\r\n1 Garlic Clove (minced)\r\n1 ½ cups Heavy Cream\r\n¼ teaspoon Salt\r\n1 ¼ cup Shredded Parmesan Cheese\r\n¼ teaspoon Pepper\r\n2 Tablespoons Italian Parsley (optional)	In a large pot, heat water over high heat until boiling. Add salt to season the water. Once it is boiling, add fettuccine and cook according to package instructions. \r\nIn a large skillet or pan, heat butter over medium heat. Add minced garlic and cook for 1 to 2 minutes. Stir in heavy cream. \r\nLet heavy cream reduce and cook for 5 to 8 minutes. Add half of the parmesan cheese to the mixture and whisk well until smooth. Keep over heat and whisk well until cheese is melted.\r\nSave some pasta water. The pasta water is full of flavor and can be used to thin out the sauce.\r\nToss alfredo sauce with fettuccine pasta and add half of the parmesan cheese. Once it is tossed, garnish with the remaining parmesan cheese. Add a little pasta water if it needs to be thinned out.\r\nGarnish with Italian parsley, if so desired.	2022-06-17 08:35:47.72897	f
4	The Perfect Greek Salad	Sam | Ahead of Thyme	4	10	https://www.aheadofthyme.com/2016/03/the-perfect-greek-salad/#tasty-recipes-5531-jump-target	easy	lunch	salad, vegan	3 cups romaine lettuce, chopped\r\n1 cup grape tomatoes (or cherry tomatoes)\r\n1 cup red onion, chopped (roughly 1 small red onion)\r\n1 + ½ cups cucumber, sliced and chopped into quarters (roughly 1 medium cucumber)\r\n1 medium green pepper, chopped\r\n¼ cup whole Kalamata olives\r\n¼ cup feta cheese, crumbled\r\n2 tablespoons extra virgin olive oil\r\n1 + ½ tablespoons freshly squeezed lemon juice\r\n½ teaspoon dried oregano\r\n¼ teaspoon sea salt\r\n¼ teaspoon ground black pepper (or more to taste)\r\n2 tablespoons extra virgin olive oil\r\n1 + ½ tablespoons freshly squeezed lemon juice\r\n½ teaspoon dried oregano\r\n¼ teaspoon sea salt\r\n¼ teaspoon ground black pepper (or more to taste)	In a large bowl, combine the romaine lettuce, cherry tomatoes, red onion, cucumber, olives and feta cheese.\r\nIn a small bowl, make the lemon Greek salad dressing by whisking together the olive oil, lemon juice, oregano, salt and pepper.\r\nPour dressing over the salad and toss to combine. Add more black pepper to taste.	2022-06-17 08:41:41.66991	f
5	TOMATO CUCUMBER AVOCADO SALAD	Sam | Ahead of Thyme	2	5	https://www.aheadofthyme.com/2016/09/simple-tomato-cucumber-and-avocado-salad/#tasty-recipes-5561-jump-target	easy	lunch	salad, vegan	1 cup grape tomatoes, halved\r\n½ large English cucumber, sliced and quartered\r\n1 avocado, chopped\r\n¼ cup cilantro, chopped\r\n1 + ½ tablespoons lemon juice (roughly from ½ lemon)\r\n1 tablespoon extra virgin olive oil\r\n¼ teaspoon salt\r\n⅛ teaspoon ground black pepper	In a large mixing bowl, add tomatoes, cucumber, avocado, and cilantro.\r\nIn a small mixing bowl, mix together the lemon juice, olive oil, salt and pepper until smooth and combined.\r\nPour dressing the salad and toss gently to combine.	2022-06-17 08:44:44.587722	f
6	CHICKEN GARDEN SALAD WITH RANCH DRESSING	Sam | Ahead of Thyme	4	5	https://www.aheadofthyme.com/2016/03/grilled-chicken-garden-salad-with-homemade-ranch-dressing/#tasty-recipes-5523-jump-target	easy	lunch	salad	1 head romaine lettuce, chopped\r\n1 cup purple cabbage, chopped\r\n1 cup grape tomatoes, halved\r\n3 radishes, thinly sliced\r\n1 medium carrot, julienned or shredded\r\n1 Persian cucumber, sliced\r\n¼ red onion, thinly sliced\r\n1 cooked chicken breast, cut into ½-inch slices\r\n½ cup seasoned croutons\r\n¼ cup ranch dressing, store-bought or homemade (ingredients below):\r\n2 tablespoons whole milk\r\n1 teaspoon lemon juice, freshly squeezed\r\n¼ cup sour cream (or Greek yogurt)\r\n1 tablespoon mayonnaise\r\n½ tablespoon fresh parsley, finely chopped\r\n½ teaspoon fresh dill, finely chopped\r\n⅛ teaspoon onion powder\r\n⅛ teaspoon garlic powder\r\n⅛  teaspoon salt\r\n⅛ teaspoon ground black pepper\r\n2 tablespoons whole milk\r\n1 teaspoon lemon juice, freshly squeezed\r\n¼ cup sour cream (or Greek yogurt)\r\n1 tablespoon mayonnaise\r\n½ tablespoon fresh parsley, finely chopped\r\n½ teaspoon fresh dill, finely chopped\r\n⅛ teaspoon onion powder\r\n⅛ teaspoon garlic powder\r\n⅛  teaspoon salt\r\n⅛ teaspoon ground black pepper	In a large mixing bowl or serving plate, add romaine lettuce, cabbage, grape tomatoes, radishes, carrot, cucumber, red onion, and cooked chicken breast. Pour ranch dressing on top and toss to combine. Top with croutons and serve.\r\nIf making homemade ranch dressing, combine the dressing ingredients into a medium mixing bowl. Whisk until smooth, then pour over the salad.	2022-06-17 08:46:38.531168	f
7	 MEDITERRANEAN ORZO PASTA SALAD	Sam | Ahead of Thyme	6	25	https://www.aheadofthyme.com/mediterranean-orzo-pasta-salad/#tasty-recipes-13570-jump-target	easy	lunch	salad	1 cup dry orzo pasta\r\n1 + ½ cups grape tomatoes (or cherry tomatoes), halved (about 20 grape tomatoes)\r\n1 + ½ cups mini cucumbers, halved and sliced (3 mini cucumbers)\r\n½ cup red onion, finely diced\r\n½ cup Kalamata olives, pitted and halved\r\n½ cup feta cheese, cubed or crumbled\r\n1 tablespoon fresh dill (or parsley), chopped\r\n3 tablespoons olive oil\r\n2 tablespoons lemon juice\r\n½ teaspoon dried oregano\r\n¼ teaspoon salt (or to taste)\r\n¼ teaspoon ground black pepper (or to taste)	Cook orzo pasta in a pot of boiling water until al dente, about 8-10 minutes, or according to package instructions. Drain in a colander and run it under cold water. Set aside to cool.\r\nIn a large bowl, combine cooled orzo, tomato, cucumber, red onion, olives, feta, and dill.\r\nIn a small bowl, mix together the dressing (add olive oil, lemon juice, oregano, salt, and pepper). Stir to mix well.\r\nPour dressing over top of the salad and toss to combine.	2022-06-17 08:50:05.475571	f
8	TOMATO AND MOZZARELLA CAPRESE SALAD	Sam | Ahead of Thyme	3	10	https://www.aheadofthyme.com/tomato-and-mozzarella-caprese-salad/#tasty-recipes-23412-jump-target	easy	lunch	salad, tomatoes	2 cups cherry tomatoes (1 pint), halved\r\n1 cup mozzarella balls (bocconcini), halved\r\n¼ cup fresh basil, chopped\r\n2 tablespoons olive oil\r\n1 tablespoon balsamic vinegar\r\n¼ teaspoon dried oregano or Italian seasoning\r\n½ teaspoon salt\r\n¼ teaspoon ground black pepper\r\n1 tablespoon balsamic reduction (optional)	In a large mixing bowl or serving dish, combine tomatoes, mozzarella balls, and basil. \r\nIn a small mixing bowl, whisk together olive oil, balsamic vinegar, dried oregano (or Italian seasoning), salt, and pepper. \r\nPour dressing into the salad and toss to combine. Top with a drizzle of balsamic reduction (optional).	2022-06-17 08:51:59.289003	f
9	LEMON KALE SALAD	Sam | Ahead of Thyme	4	5	https://www.aheadofthyme.com/lemon-kale-salad/	easy	lunch	salad, kale	5 cups kale, shredded\r\n1 cup cherry tomatoes, halved\r\n½ cup croutons\r\n¼ cup cheddar cheese, shredded\r\n2 tablespoons olive oil\r\n2 tablespoons lemon juice, freshly squeezed\r\n1 tablespoon Parmesan cheese, freshly grated\r\n½ teaspoon garlic powder\r\n¼ teaspoon salt (or to taste)\r\n¼ teaspoon ground black pepper (or to taste)	Place kale into a large mixing bowl or serving plate. Add cherry tomatoes, croutons, cheddar cheese. \r\nIn a small mixing bowl, stir to combine olive oil, lemon juice, Parmesan cheese, garlic powder, salt and pepper.\r\nPour the dressing over the salad and toss to combine. 	2022-06-17 08:53:33.654531	f
10	Greek Chicken Salad	Sam | Ahead of Thyme	4	5	https://www.aheadofthyme.com/greek-chicken-salad/#tasty-recipes-23545-jump-target	easy	lunch	salad, greek	1 cooked chicken breast, sliced\r\n3 cups romaine lettuce\r\n1 cup grape tomatoes, halved\r\n2 Persian cucumbers, halved and sliced\r\n½ cup red onion, diced\r\n½ cup kalamata olives, pitted\r\n⅓ cup feta cheese, crumbled\r\n¼ cup Greek salad dressing\r\n3 tablespoons olive oil\r\njuice from ½ lemon\r\n¼ teaspoon dried oregano\r\n¼ teaspoon salt (or to taste)\r\n¼ teaspoon ground black pepper (or to taste)\r\n3 tablespoons olive oil\r\njuice from ½ lemon\r\n¼ teaspoon dried oregano\r\n¼ teaspoon salt (or to taste)\r\n¼ teaspoon ground black pepper (or to taste)	In a large serving bowl, combine the salad ingredients including chicken, romaine lettuce, tomatoes, cucumbers, red onion, cucumber, olives, and feta cheese.\r\nTo make the Greek salad dressing, whisk together olive oil, lemon juice, oregano, salt, and pepper in a small mixing bowl. \r\nPour dressing on top of salad and toss to combine. Add more salt and pepper to taste, if needed.	2022-06-17 08:54:40.860083	f
11	Creamy Avocado Smoothie 	Love and Lemons	2	5	https://www.loveandlemons.com/avocado-smoothie/#wprm-recipe-container-49654	easy	breakfast	smoothie, avocado, spinach	1/2 cup cubed frozen pineapple\r\n2 cups packed fresh spinach, or 1 cup frozen spinach\r\n1 ripe avocado\r\n1 frozen banana\r\n3/4 cup light coconut milk, canned or from a carton\r\n3 tablespoons fresh lime juice, plus 1/2 teaspoon zest\r\n1 teaspoon maple syrup\r\npinch of sea salt\r\n8 ice cubes\r\n2 scoops vanilla protein powder*, optional	Combine the pineapple, spinach, avocado, banana, coconut milk, lime juice, maple syrup, salt, ice, and protein powder, if using, in a blender. Blend until creamy.\r\nTaste and adjust the sweetness to your liking. If you prefer a sweeter smoothie, add more maple syrup. If the consistency is too thick, add more coconut milk, and blend again	2022-06-17 09:00:19.159479	f
12	Best Green Smoothie	Love and Lemons	2	5	https://www.loveandlemons.com/best-green-smoothie-recipe/	easy	breakfast	smoothie, spinach, green	1 frozen banana\r\nbig handfuls fresh baby spinach, about 2 cups\r\n¼ cup fresh mint, about 10 leaves\r\n2 tablespoons almond butter\r\n2 ice cubes\r\n¼ teaspoon good vanilla extract\r\n¾ cup Almond Breeze Almondmilk Cashewmilk, more as needed	In a blender, combine the banana, spinach, mint leaves, almond butter, ice, vanilla and cashew milk. Blend until smooth. Add more cashew milk as needed for desired consistency.\r\nPour into glasses and serve.	2022-06-17 09:02:37.606706	f
\.


--
-- Name: planned_meals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarahnd
--

SELECT pg_catalog.setval('public.planned_meals_id_seq', 1, false);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarahnd
--

SELECT pg_catalog.setval('public.recipes_id_seq', 12, true);


--
-- Name: planned_meals planned_meals_pkey; Type: CONSTRAINT; Schema: public; Owner: sarahnd
--

ALTER TABLE ONLY public.planned_meals
    ADD CONSTRAINT planned_meals_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_name_key; Type: CONSTRAINT; Schema: public; Owner: sarahnd
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_name_key UNIQUE (name);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: sarahnd
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

