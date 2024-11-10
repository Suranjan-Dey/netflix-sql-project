-- Netflix Movies and TV Shows Data Analysis Project using SQL

-- Database Schemas

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

SELECT * FROM netflix;