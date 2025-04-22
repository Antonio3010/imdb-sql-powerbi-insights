USE imdb_project;

ALTER TABLE imdb_data
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;


-- Top 10 peliculas con mayores ganancias (Gross) --
SELECT Series_Title, Gross FROM imdb_data ORDER BY Gross DESC limit 10;


-- ¿Qué directores obtienen mayores ganancias (Gross)? --
Select Director, AVG(Gross) AS Avg_Gross 
FROM imdb_data
GROUP BY Director
ORDER BY AVG_GROSS DESC limit 10;


-- ¿Qué actores suelen tener películas con mayores ingresos (Gross)? --
SELECT star AS Actor, AVG(Gross) AS Avg_Gross FROM (
SELECT star1 AS star, Gross FROM imdb_data UNION ALL
SELECT star2 AS star, Gross FROM imdb_data UNION ALL
SELECT star3 AS star, Gross FROM imdb_data) AS combined_stars
GROUP BY ACTOR
ORDER BY Avg_Gross DESC LIMIT 10;


-- Qué directores reciben más votos (No_of_votes)
SELECT Director, AVG(No_of_Votes) AS Avg_No_of_Votes FROM imdb_data
GROUP BY Director
ORDER BY Avg_No_of_Votes DESC limit 10;

-- ¿Qué actores suelen tener películas con mejores calificaciones (IMDB_Rating)? --
SELECT star AS Actor, AVG(IMDB_Rating) AS Avg_IMDB_Rating FROM (
SELECT star1 AS star, IMDB_Rating FROM imdb_data UNION ALL
SELECT star2 AS star, IMDB_Rating FROM imdb_data UNION ALL
SELECT star3 AS star, IMDB_Rating FROM imdb_data) AS combined_stars
GROUP BY ACTOR
ORDER BY Avg_IMDB_Rating DESC limit 10;


-- ¿Cual es el genero más común por actor?
SELECT star AS Actor, Genre, COUNT(*) AS Frecuencia FROM (
    SELECT star1 AS star, Genre FROM imdb_data UNION ALL 
	SELECT star2 AS star, Genre FROM imdb_data UNION ALL 
	SELECT star3 AS star, Genre FROM imdb_data) AS combined_stars
GROUP BY Actor, Genre
ORDER BY Frecuencia DESC;

 
-- Cual es el genero más común entre todos los actores?
SELECT Genre, COUNT(*) AS Frecuencia_Total
FROM (
SELECT Star1 AS star, Genre FROM imdb_data
UNION ALL
Select Star2 AS star, Genre FROM imdb_data
UNION ALL
Select Star3 AS star, Genre FROM imdb_data) AS combined
GROUP BY Genre
ORDER BY Frecuencia_Total DESC;


-- ¿Qué combinaciones de actores tienen mejores resultados (Gross o IMDB)? --

SELECT actor1, actor2, AVG(gross) AS promedio_ganancia$
FROM (
     SELECT LEAST(star1, star2) AS actor1, GREATEST(star1, star2) AS actor2, gross FROM imdb_data
     UNION ALL
     SELECT LEAST(star1, star3), GREATEST(star1, star3), gross FROM imdb_data
     UNION ALL
     SELECT LEAST(star2, star3), GREATEST(star2, star3), gross FROM imdb_data
) AS combinaciones_actores
GROUP BY actor1, actor2
ORDER BY promedio_ganancia$ DESC LIMIT 10;


-- ¿Qué género ha generado más ingresos brutos (gross) en promedio?--
SELECT genre, AVG(gross) AS ingreso_promedio
FROM imdb_data
WHERE gross IS NOT NULL
GROUP BY genre
ORDER BY ingreso_promedio DESC;
