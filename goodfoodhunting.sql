CREATE DATABASE goodfoodhunting;


CREATE TABLE dishes (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(100),
    image_url VARCHAR(400)
); 

INSERT INTO dishes (name, image_URL) values ('birthday cake', 'https://img.taste.com.au/-l6L5bYJ/w720-h480-cfill-q80/taste/2016/11/homemade-chocolate-cake-85524-1.jpeg');

INSERT INTO dishes (name, image_URL) values ('bbq ribs', 'https://img.taste.com.au/kAHAQyC-/w720-h480-cfill-q80/taste/2013/02/pork-ribs-with-spiced-barbecue-glaze-130279-1.jpg');

INSERT INTO dishes (name, image_URL) values ('choc pudding', 'https://img.taste.com.au/4TRyMICK/w720-h480-cfill-q80/taste/2016/11/chocolate-pudding-3643-1.jpeg');


CREATE TABLE comments (
    id SERIAL4 PRIMARY KEY,
    content TEXT NOT NULL,
    dish_id INTEGER NOT NULL,
    FOREIGN KEY (dish_id) REFERENCES dishes (id) ON DELETE RESTRICT 
);

INSERT INTO comments (content, dish_id) values ('yum', 2);

CREATE TABLE users (
    id SERIAL4 PRIMARY KEY,
    email VARCHAR(300),
    password_digest VARCHAR(400)
);

ALTER TABLE dishes ADD COLUMN user_id INTEGER; 

CREATE TABLE likes (
    id SERIAL4 PRIMARY KEY,
    user_id INTEGER,
    dish_id INTEGER
);

ALTER TABLE comments ADD COLUMN user_id INTEGER; 

UPDATE comments SET user_id = 1;