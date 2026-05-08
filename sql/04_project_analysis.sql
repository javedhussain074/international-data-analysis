-- Project Data Cleaning Queries
-- Find projects with missing project name or budget values
SELECT *
FROM projects
WHERE project_name IS NULL
   OR budget IS NULL;
   
-- Identify duplicate projects by name, country, and year
SELECT project_name,
       country,
       year,
       COUNT(*)
FROM projects
GROUP BY project_name, country, year
HAVING COUNT(*) > 1;

-- Standardize project status by replacing 'complete' with 'Completed'
UPDATE projects
SET status = 'Completed'
WHERE status = 'complete';

-- Project Exploratory Data Analysis (EDA) Queries
-- Count total number of projects
SELECT COUNT(*) AS total_projects
FROM projects;

-- Calculate total budget across all projects
SELECT SUM(budget) AS total_budget
FROM projects;

-- Count number of projects per sector and sort in descending order
SELECT sector,
       COUNT(*) AS total_projects
FROM projects
GROUP BY sector
ORDER BY total_projects DESC;

-- Calculate total project budget per country and sort in descending order
SELECT country,
       SUM(budget) AS total_budget
FROM projects
GROUP BY country
ORDER BY total_budget DESC;

-- Count number of projects per year in chronological order
SELECT year,
       COUNT(*) AS total_projects
FROM projects
GROUP BY year
ORDER BY year;

-- Project Advanced SQL Queries
-- Rank projects based on budget in descending order
SELECT project_name,
       budget,
       RANK() OVER(ORDER BY budget DESC) AS ranking
FROM projects;

-- Categorize projects based on budget ranges
SELECT project_name,
       budget,
       CASE
           WHEN budget > 1000000 THEN 'High Budget'
           WHEN budget BETWEEN 500000 AND 1000000 THEN 'Medium Budget'
           ELSE 'Low Budget'
       END AS budget_category
FROM projects;

-- Compute total budget per sector and sort in descending order
WITH sector_budget AS (
    SELECT sector,
           SUM(budget) AS total_budget
    FROM projects
    GROUP BY sector
)

SELECT *
FROM sector_budget
ORDER BY total_budget DESC;