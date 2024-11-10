# Netflix Movies and TV Shows Data Analysis Project using SQL

![Netflix Logo](https://github.com/Suranjan-Dey/netflix-sql-project/blob/main/Netflix%20Logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Database Schema

```sql
CREATE TABLE netflix
(
	show_id	VARCHAR(10),
	type VARCHAR(15),
	title VARCHAR(300),
	director VARCHAR(600),
	casts VARCHAR(1100),
	country	VARCHAR(6000),
	date_added VARCHAR(60),
	release_year INT,
	rating VARCHAR(15),
	duration VARCHAR(15),
	listed_in VARCHAR(300),
	description VARCHAR(800)
);
```

## Business Problems and Solutions

Business Problem 1: Count the number of Movies vs TV Shows

```sql
SELECT type, COUNT(*) as total_count
FROM netflix
GROUP BY type;
```

**Objective:** Determine the distribution of content types on Netflix.

Business Problem 2: Find the most common rating for movies and TV shows

```sql
WITH RatingCounts AS (
    SELECT type, rating, COUNT(*) AS rating_count
    FROM netflix
    GROUP BY 1,2
),
RankedRatings AS (
    SELECT type, rating, rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT type, rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

Business Problem 3: List all movies released in a specific year (e.g., 2020)

```sql
SELECT * FROM netflix
WHERE type='Movie' and release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

Business Problem 4: Find the top 5 countries with the most content on Netflix

```sql
SELECT
		UNNEST(STRING_TO_ARRAY(country, ', ')) as country,
		COUNT(*) as total_content
	FROM netflix
	GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

Business Problem 5: Identify the longest movie

```sql
SELECT title,  SUBSTRING(duration, 1,position ('m' in duration)-1)::int duration
FROM Netflix
WHERE type = 'Movie' and duration is not null
ORDER by 2 desc
LIMIT 1;
```

**Objective:** Find the movie with the longest duration.

Business Problem 6: Find content added in the last 5 years

```sql
SELECT * FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

Business Problem 7: Find all the movies/TV shows by director 'Rajiv Chilaka'!

```sql
SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

Business Problem 8: List all TV shows with more than 5 seasons

```sql
SELECT * FROM netflix
WHERE 
	TYPE = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::INT > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

Business Problem 9: Count the number of content items in each genre

```sql
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ', ')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1;
```

**Objective:** Count the number of content items in each genre.

Business Problem 10: Find each year and the average numbers of content release by India on netflix. Return top 5 year with highest avg content release !

```sql
SELECT country, release_year, COUNT(show_id) as total_release,
	ROUND(
		COUNT(show_id)::numeric/
								(SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
		)
		as avg_release
FROM netflix
WHERE country = 'India' 
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5;
```

**Objective:** Calculate and rank years by the average number of content releases by India.

Business Problem 11: List all movies that are documentaries

```sql
SELECT * FROM netflix
WHERE listed_in ILIKE '%Documentaries%';
```

**Objective:** Retrieve all movies classified as documentaries.

Business Problem 12: Find all content without a director

```sql
SELECT * FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

Business Problem 13: Find how many movies actor 'Salman Khan' appeared in last 10 years!

```sql
SELECT * FROM netflix
WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

Business Problem 14: Find the top 10 actors who have appeared in the highest number of movies produced in India.

```sql
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor, COUNT(*) AS number_of_movies
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

Business Problem 15: Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.

```sql
SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;
```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/suranjandey/)
