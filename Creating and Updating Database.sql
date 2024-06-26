### Chapter:- SQL Basics: Database Creation & Updates



### Module: Insert Statement

-- Simple insert for new record in movies
	INSERT INTO movies VALUES (141, "Bahuhbali 3", "Bollywood", 2030, 9.0, "Arka Media Works", 2);

-- Insert with NULL or DEFAULT values
	INSERT INTO movies VALUES (142, "Thor 10", "Hollywood", NULL, DEFAULT, "Marvel Studios", 5);

-- Same insert with column names
	INSERT INTO movies (movie_id, title, industry, language_id) VALUES (143, "Pushpa 5", "Bollywood", 2);

-- Insert with invalid language_id. Foreign key constraint fails
	INSERT INTO movies (movie_id, title, industry, language_id) VALUES (144, "Pushpa 6", "Bollywood", 10);

-- Insert multiple rows
	INSERT INTO movies 
    	     (movie_id, title, industry, language_id)
	VALUES 
    	     (145, "Inception 2", "Hollywood", 5),
             (146, "Inception 3", "Hollywood", 5),
             (147, "Inception 4", "Hollywood", 5);



### Module: Update and Delete

-- Say THOR 10 movie is released in 2050, and you want to update the rating now :)
	UPDATE movies 
	SET imdb_rating=8, release_year=2050
	WHERE movie_id=142;

-- Update multiple records. [Update all studios with 'Warner Bros. Pictures' for all the Inception movies records] 
	UPDATE movies 
	SET studio='Warner Bros. Pictures'
	WHERE title like "Inception %";

-- Delete all new inception movies
	DELETE FROM movies 
	WHERE  title like "Inception %";

-- Another delete to restore the database to normal again
	DELETE FROM movies 
	WHERE movie_id in (141, 142, 143);
