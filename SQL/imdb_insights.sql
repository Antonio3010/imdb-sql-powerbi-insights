USE imdb_project;

ALTER TABLE imdb_data
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;


-- Top 10 movies with highest earnings (Gross) --
SELECT Series_Title, Gross FROM imdb_data ORDER BY Gross DESC limit 10;


-- Which directors make the most profit (Gross)? --
Select Director, AVG(Gross) AS Avg_Gross 
FROM imdb_data
GROUP BY Director
ORDER BY AVG_GROSS DESC limit 10;


-- Which actors tend to have movies with higher income (Gross)? --
SELECT star AS Actor, AVG(Gross) AS Avg_Gross FROM (
SELECT star1 AS star, Gross FROM imdb_data UNION ALL
SELECT star2 AS star, Gross FROM imdb_data UNION ALL
SELECT star3 AS star, Gross FROM imdb_data) AS combined_stars
GROUP BY ACTOR
ORDER BY Avg_Gross DESC LIMIT 10;


-- Which directors receive the most votes (No_of_votes)
SELECT Director, AVG(No_of_Votes) AS Avg_No_of_Votes FROM imdb_data
GROUP BY Director
ORDER BY Avg_No_of_Votes DESC limit 10;

-- Which actors tend to have films with better ratings (IMDB_Rating)? --
SELECT star AS Actor, AVG(IMDB_Rating) AS Avg_IMDB_Rating FROM (
SELECT star1 AS star, IMDB_Rating FROM imdb_data UNION ALL
SELECT star2 AS star, IMDB_Rating FROM imdb_data UNION ALL
SELECT star3 AS star, IMDB_Rating FROM imdb_data) AS combined_stars
GROUP BY ACTOR
ORDER BY Avg_IMDB_Rating DESC limit 10;


-- What is the most common gender per actor?
SELECT star AS Actor, Genre, COUNT(*) AS frenquencyFROM (
    SELECT star1 AS star, Genre FROM imdb_data UNION ALL 
	SELECT star2 AS star, Genre FROM imdb_data UNION ALL 
	SELECT star3 AS star, Genre FROM imdb_data) AS combined_stars
GROUP BY Actor, Genre
ORDER BY frenquency DESC;

 
-- What is the most common gender among all actors?
SELECT Genre, COUNT(*) AS frenquency
FROM (
SELECT Star1 AS star, Genre FROM imdb_data
UNION ALL
Select Star2 AS star, Genre FROM imdb_data
UNION ALL
Select Star3 AS star, Genre FROM imdb_data) AS combined
GROUP BY Genre
ORDER BY frenquency DESC;


-- Which combinations of actors perform best (Gross or IMDB)? --

SELECT actor1, actor2, AVG(gross) AS avg_gain
FROM (
     SELECT LEAST(star1, star2) AS actor1, GREATEST(star1, star2) AS actor2, gross FROM imdb_data
     UNION ALL
     SELECT LEAST(star1, star3), GREATEST(star1, star3), gross FROM imdb_data
     UNION ALL
     SELECT LEAST(star2, star3), GREATEST(star2, star3), gross FROM imdb_data
) AS combinaciones_actores
GROUP BY actor1, actor2
ORDER BY avg_gain DESC LIMIT 10;


-- Which gender has generated the most gross (gross) income on average? --
SELECT genre, AVG(gross) AS gross_avg
FROM imdb_data
WHERE gross IS NOT NULL
GROUP BY genre
ORDER BY gross_avg DESC;
