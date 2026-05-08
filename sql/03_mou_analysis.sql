-- MoU Data Cleaning Queries
-- Find records with missing organization or country values
SELECT *
FROM mou
WHERE organization IS NULL
   OR country IS NULL;
   
-- Identify duplicate MOU records by organization, country, and signed year
SELECT organization,
       country,
       signed_year,
       COUNT(*)
FROM mou
GROUP BY organization, country, signed_year
HAVING COUNT(*) > 1;

-- Standardize country name by replacing 'United States' with 'USA'
UPDATE mou
SET country = 'USA'
WHERE country = 'United States';

-- MoU Exploratory Data Analysis (EDA) Queries
-- Count total number of MOU records
SELECT COUNT(*) AS total_mous
FROM mou;

-- Count number of MOUs per country and sort in descending order
SELECT country,
       COUNT(*) AS total_mous
FROM mou
GROUP BY country
ORDER BY total_mous DESC;

-- Count number of MOUs signed per year in chronological order
SELECT signed_year,
       COUNT(*) AS total_mous
FROM mou
GROUP BY signed_year
ORDER BY signed_year;

-- Get top 10 organizations with the highest number of MOUs
SELECT organization,
       COUNT(*) AS total_mous
FROM mou
GROUP BY organization
ORDER BY total_mous DESC
LIMIT 10;

-- MoU Advanced SQL Queries
-- Rank countries based on total number of MOUs
SELECT country,
       COUNT(*) AS total_mous,
       RANK() OVER(ORDER BY COUNT(*) DESC) AS ranking
FROM mou
GROUP BY country;

-- Compute total MOUs per year and sort by highest count
WITH yearly_mou AS (
    SELECT signed_year,
           COUNT(*) AS total_mous
    FROM mou
    GROUP BY signed_year
)

SELECT *
FROM yearly_mou
ORDER BY total_mous DESC;