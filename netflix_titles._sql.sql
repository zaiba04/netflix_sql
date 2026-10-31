-- CREATE TABLE netflix (
--     show_id VARCHAR(10) PRIMARY KEY,
--     type VARCHAR(20),
--     title VARCHAR(500),
--     director TEXT,
--     "cast" TEXT,
--     country TEXT,
--     date_added VARCHAR(50),
--     release_year INTEGER,
--     rating VARCHAR(50),
--     duration VARCHAR(50),
--     listed_in TEXT,
--     description TEXT
-- );
SELECT *
FROM netflix
LIMIT 10;
SELECT COUNT(*)
FROM netflix;
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY type;
--3: Which release years had the highest number of Netflix titles?
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 1
--4: Which countries have the highest number of titles on Netflix?
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;
--5: What is the distribution of Movies and TV Shows on Netflix?
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY type
ORDER BY total_titles DESC;
--6: Which directors have the highest number of titles on Netflix?
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;
--7: Which movies were released after 2020?
SELECT
    title,
    release_year,
    type
FROM netflix
WHERE release_year > 2020
  AND type = 'Movie'
ORDER BY release_year DESC;
-- 8: Which Netflix titles have a rating of TV-MA?
SELECT
    title,
    type,
    rating
FROM netflix
WHERE rating = 'TV-MA';
--9: Which Netflix titles contain the word "Love" in their title?
SELECT
    title,
    type,
    release_year
FROM netflix
WHERE title LIKE '%Love%';
--10: How many Netflix titles have missing director information?
SELECT
    COUNT(*) AS missing_director_count
FROM netflix
WHERE director IS NULL;
--11: How many Netflix titles have missing country information?
SELECT
    COUNT(*) AS missing_country_count
FROM netflix
WHERE country IS NULL;
--12: What is the total number of missing values in the director, cast, and country columns?
SELECT
    COUNT(*) FILTER (WHERE director IS NULL) AS missing_directors,
    COUNT(*) FILTER (WHERE "cast" IS NULL) AS missing_cast,
    COUNT(*) FILTER (WHERE country IS NULL) AS missing_countries
FROM netflix;
--13: Which Netflix movies have a duration longer than 120 minutes?
SELECT
    title,
    duration,
    release_year
FROM netflix
WHERE type = 'Movie'
  AND CAST(REPLACE(duration, ' min', '') AS INTEGER) > 120
ORDER BY CAST(REPLACE(duration, ' min', '') AS INTEGER) DESC
LIMIT 20;
--14: What is the average duration of Netflix movies?
SELECT
    ROUND(
        AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER)),
        2
    ) AS average_movie_duration
FROM netflix
WHERE type = 'Movie'
  AND duration LIKE '% min';
--15: Which year had the highest number of Netflix titles added to the platform?
SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year_added,
    COUNT(*) AS total_titles
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY total_titles DESC
LIMIT 10;
--16: What are the most common genres on Netflix?
SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix
WHERE listed_in IS NOT NULL
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;
--17: How many Movies and TV Shows were released in each year?
SELECT
    release_year,
    type,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY release_year, type
ORDER BY release_year DESC, total_titles DESC;
--18: Which ratings are most common on Netflix?
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 10;
--19: Which Netflix titles were released between 2015 and 2020?
SELECT
    title,
    type,
    release_year
FROM netflix
WHERE release_year BETWEEN 2015 AND 2020
ORDER BY release_year DESC;
--20: Which Netflix titles were released before the year 2000?
SELECT
    title,
    type,
    release_year
FROM netflix
WHERE release_year < 2000
ORDER BY release_year ASC;
--21: How many Netflix titles were added in each month?
SELECT
    EXTRACT(MONTH FROM TO_DATE(TRIM(date_added), 'Month DD, YYYY')) AS month_number,
    COUNT(*) AS total_titles
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY month_number
ORDER BY total_titles DESC;
--22: What percentage of Netflix titles are Movies and TV Shows?
SELECT
    type,
    COUNT(*) AS total_titles,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix),
        2
    ) AS percentage
FROM netflix
GROUP BY type
ORDER BY percentage DESC;
--23: Which Netflix titles have the longest descriptions?
SELECT
    title,
    type,
    LENGTH(description) AS description_length
FROM netflix
WHERE description IS NOT NULL
ORDER BY description_length DESC
LIMIT 10;
--24: How can Netflix titles be categorized into different release-year periods?
SELECT
    title,
    release_year,
    CASE
        WHEN release_year < 2000 THEN 'Before 2000'
        WHEN release_year BETWEEN 2000 AND 2009 THEN '2000-2009'
        WHEN release_year BETWEEN 2010 AND 2019 THEN '2010-2019'
        ELSE '2020 onwards'
    END AS release_period
FROM netflix
ORDER BY release_year DESC
LIMIT 20;
--25: Which Netflix directors have more than 5 titles?
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 5
ORDER BY total_titles DESC;



