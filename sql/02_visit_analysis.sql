-- Visit Data Cleaning Queries
-- Retrieve all records from visits where the country value is missing (NULL)
SELECT * 
FROM visits
WHERE country IS NULL;

SET SQL_SAFE_UPDATES = 0;
-- Update country values from 'United States' to 'USA' in the visits table
UPDATE visits
SET country = 'USA'
WHERE country = 'United States';

-- Count records grouped by country and year, filtering only groups with more than one record
SELECT country, year, COUNT(*)
FROM visits
GROUP BY country, year
HAVING COUNT(*) > 1;

-- Visit Exploratory Data Analysis (EDA) Queries
-- Calculate total number of visitors from the visits table
SELECT SUM(visitors) AS total_visitors
FROM visits;

-- Get top 10 countries by total visitors
SELECT country,
       SUM(visitors) AS total
FROM visits
GROUP BY country
ORDER BY total DESC
LIMIT 10;

-- Calculate total visitors per year ordered chronologically
SELECT year,
       SUM(visitors) AS total
FROM visits
GROUP BY year
ORDER BY year;

-- Visit Advanced SQL Queries
-- Rank years based on total visitors using a window function
WITH yearly_data AS (
    SELECT year,
           SUM(visitors) AS total_visitors
    FROM visits
    GROUP BY year
)

SELECT *,
       RANK() OVER(ORDER BY total_visitors DESC) AS ranking
FROM yearly_data;