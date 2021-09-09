CREATE TABLE user_signin (
    user_id serial primary key,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(100),
    password VARCHAR(100)
);

CREATE TABLE user_profile (
    profile_id serial primary key
);

CREATE TABLE ingredients (
    ingredients_id serial primary key,
    ingredient_name VARCHAR(50)
);

CREATE TABLE recipes (
    recipe_id serial primary key,
    ingredient_name VARCHAR(225),
    ingredients_id INT NOT NULL REFERENCES ingredients(ingredients_id),
    instructions TEXT,
    profile_id INT NOT NULL REFERENCES user_profile(profile_id),
    public BOOLEAN 
);

CREATE TABLE grocery_lists (
    grocery_list_id serial primary key,
    ingredient_name VARCHAR(225),
    ingredients_id INT NOT NULL REFERENCES ingredients(ingredients_id),
    profile_id INT NOT NULL REFERENCES user_profile(profile_id)
);

CREATE TABLE occasions (
    occasion_id serial primary key,
    profile_id INT NOT NULL REFERENCES user_profile(profile_id),
    recipes_id INT NOT NULL REFERENCES recipes(recipe_id)
);

ALTER TABLE user_profile 
ADD recipe_id INT REFERENCES recipes(recipe_id),
ADD grocery_id INT NOT NULL REFERENCES grocery_lists(grocery_list_id),
ADD occasions_id INT NOT NULL REFERENCES occasions(occasion_id),
ADD user_id INT NOT NULL REFERENCES user_signin(user_id);

-- add data

INSERT INTO user_signin (first_name, last_name, email, password)
VALUES ('Jacob', 'Laboissonniere', 'jacob@jacob.com', 'ilovetocode');


INSERT INTO ingredients(ingredient_name)
VALUES ('cheese');


INSERT INTO recipes (ingredient_name, ingredients_id, instructions, public)
VALUES 
('cheese',  
(SELECT ingredients_id from ingredients WHERE ingredient_name ='cheese'),
 'cut the cheese',  
 true
);