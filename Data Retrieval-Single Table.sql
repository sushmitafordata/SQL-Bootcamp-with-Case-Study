----- Chapter:- SQL Basics: Data Retrieval - Single Table---------




### -----			Module: Retrieve data using text query(SELECT, WHERE, DISTINCT, LIKE)							-----------------

-- Simply print all the movies 
	SELECT * from movies;

-- Get movie title and industry for all the movies
	SELECT title, industry from movies;

-- Print all moves from Hollywood 
	SELECT * from movies where industry="Hollywood";
  
-- Print all moves from Bollywood 
	SELECT * from movies where industry="Bollywood";

-- Get all the unique industries in the movies database
	SELECT DISTINCT industry from movies;

-- Select all movies that starts with THOR
	SELECT * from movies where title LIKE 'THOR%';

-- Select all movies that have 'America' word in it. That means to select all captain America movies
	SELECT * from movies where title LIKE '%America%';

-- How many hollywood movies are present in the database?
	SELECT COUNT(*) from movies where industry="Hollywood";

-- Print all  movies where we don't know the value of the studio
	SELECT * FROM movies WHERE studio='';




### -----    Module: Retrieve data using numeric query (BETWEEN, IN, ORDER BY, LIMIT, OFFSET)		------------------------------

-- Which movies had greater than 9 imdb rating?
	SELECT * from movies where imdb_rating>9;

-- Movies with rating between 6 and 8
	SELECT * from movies where imdb_rating>=6 and imdb_rating <=8;
	SELECT * from movies where imdb_rating BETWEEN 6 AND 8;

-- Select all movies whose release year can be 2018 or 2019 or 2022
	-- Approach1:
	SELECT * from movies where release_year=2022 
	or release_year=2019 or release_year=2018;

	-- Approach2:
	SELECT * from movies where release_year IN (2018,2019,2022);

-- All movies where imdb rating is not available (imagine the movie is just released)
	SELECT * from movies where imdb_rating IS NULL;

-- All movies where imdb rating is available 
	SELECT * from movies where imdb_rating IS NOT NULL;

-- Print all bollywood movies ordered by their imdb rating
	SELECT * 
        from movies WHERE industry = "bollywood"
        ORDER BY imdb_rating ASC;

-- Print first 5 bollywood movies with highest rating
	SELECT * 
        from movies WHERE industry = "bollywood"
        ORDER BY imdb_rating DESC LIMIT 5;

-- Select movies starting from second highest rating movie till next 5 movies for bollywood
	SELECT * 
        from movies WHERE industry = "bollywood"
        ORDER BY imdb_rating DESC LIMIT 5 OFFSET 1;
        
-- Exercise Question

-- 1) print all movies by the order of their release year (latest first)
   
   select * from movies order by release_year desc
   
-- 2) all movies released this year in 2022
   
   select * from movies where release_year=2022  
   
-- 3) all the movies released after 2020

   select * from movies where release_year>2020  
   
-- 4) all movies after year 2020 that has more than 8 rating

   select * from movies where release_year>2020 and imdb_rating>8
   
-- 5) select all movies that are by marvel studios and hombale films

   select * from movies where studio in ("marvel studios", "hombale films")
   
-- 6) select all thor movies by their release year

   select title, release_year from movies 
   where title like '%thor%' order by release_year asc

-- 7) select all movies that are not from marvel studios

   select * from movies where studio!="marvel studios"


### -----     Module: Summary Analytics (COUNT, MAX, MIN, AVG, GROUP BY) -----------------------
 
-- How many total movies do we have in our movies table?
	SELECT COUNT(*) from movies;
	
-- Select highest imdb rating for bollywood movies
	SELECT MAX(imdb_rating) from movies where industry="Bollywood";

-- Select lowest imdb rating for bollywood movies
	SELECT MIN(imdb_rating) from movies where industry="Bollywood";

-- Print average rating of Marvel Studios movies
	SELECT AVG(imdb_rating) from movies where studio="Marvel Studios";
	SELECT ROUND(AVG(imdb_rating),2) from movies where studio="Marvel Studios";

-- Print min, max, avg rating of Marvel Studios movies
	SELECT 
           MIN(imdb_rating) as min_rating, 
           MAX(imdb_rating) as max_rating, 
           ROUND(AVG(imdb_rating),2) as avg_rating
        FROM movies 
        WHERE studio="Marvel Studios";

-- Print count of movies by industry
	SELECT 
           industry, count(industry) 
        FROM movies
        GROUP BY industry;

-- Same thing but add average rating
	SELECT 
            industry, 
            count(industry) as movie_count,
            avg(imdb_rating) as avg_rating
	FROM movies
	GROUP BY industry;

-- Count number of movies released by a given production studio
	SELECT 
	    studio, count(studio) as movies_count 
        from movies WHERE studio != ''
	GROUP BY studio
	ORDER BY movies_count DESC;

-- What is the average rating of movies per studio and also order them by average rating in descending format?
	SELECT 
	   studio, 
	   count(studio) as cnt, 
	   round(avg(imdb_rating), 1) as avg_rating 
	from movies WHERE studio != ''
	GROUP BY studio
        order by avg_rating DESC;

-- Exercise Questions

-- 1) how many movies were released between 2015 and 2022

   select 
        count(*)
   from movies 
   where release_year between 2015 and 2022;
   
-- 2) print the max and min movie release year

   select 
      min(release_year) as min_year,
      max(release_year) as max_year
   from movies;
   
-- 3) print a year and how many movies were released in that year starting with latest year

   select release_year, count(*) as movies_count 
   from movies group by release_year order by release_year desc;

       



###-----------------			 Module: HAVING Clause 								--------------------------------------------

-- Print all the years where more than 2 movies were released
	SELECT 
           release_year, 
           count(*) as movies_count
	FROM movies    
	GROUP BY release_year
	HAVING movies_count>2
	ORDER BY movies_count DESC;




###-------------			 Module: Calculated Columns (IF, CASE, YEAR, CURYEAR)		------------------------------------------

-- Print actor name, their birth_year and age
	SELECT 
           name, birth_year, (YEAR(CURDATE())-birth_year) as age
	FROM actors;

-- Print profit for every movie
	SELECT 
	    *, 
           (revenue-budget) as profit 
	from financials;

-- Print revenue of all movies in INR currency
	SELECT 
           movie_id, 
	   revenue, 
           currency, 
           unit,
           IF (currency='USD', revenue*77, revenue) as revenue_inr
	FROM financials;

-- Get all the unique units from financial table
	select 
	   distinct unit 
	From financials;

-- Print revenue in millions 
	SELECT 
           movie_id, revenue, currency, unit,
           CASE
              WHEN unit="Thousands" THEN revenue/1000
              WHEN unit="Billions" THEN revenue*1000
             ELSE revenue
           END as revenue_mln
	FROM financials;

-- Exercise Questions---

-- 1) Print profit % for all the movies 
   
   select 
        *, 
    (revenue-budget) as profit, 
    (revenue-budget)*100/budget as profit_pct 
   from financials
   