-- Join Queries
-- Join visit records with MOU details by matching country names
SELECT 
    v.country,
    v.year AS visit_year,
    v.visitors,
    m.organization,
    m.sector,
    m.signed_year
FROM visits v
INNER JOIN mou m
    ON v.country = m.country;

-- Retrieve matching MOU and project details based on country and sector
SELECT
    m.country,
    m.organization,
    m.sector,
    p.project_name,
    p.budget,
    p.status,
    p.year
FROM mou m
INNER JOIN projects p
    ON m.country = p.country
   AND m.sector = p.sector;

-- Combine visits, MOU, and project data by matching country and sector relationships
SELECT
    v.country,
    v.year AS visit_year,
    v.visitors,
    m.organization,
    m.sector,
    p.project_name,
    p.budget,
    p.status
FROM visits v
INNER JOIN mou m
    ON v.country = m.country
INNER JOIN projects p
    ON m.country = p.country
   AND m.sector = p.sector;
   
-- Retrieve all visit records along with matching MOU details where available
SELECT
    v.country,
    v.year,
    v.visitors,
    m.organization,
    m.sector
FROM visits v
LEFT JOIN mou m
    ON v.country = m.country;
    
-- Retrieve all MOU records along with matching project details where available
SELECT
    m.country,
    m.organization,
    m.sector,
    p.project_name,
    p.status
FROM mou m
LEFT JOIN projects p
    ON m.country = p.country
   AND m.sector = p.sector;
   
-- Calculate the total project budget for each country and sort by highest budget
SELECT
    p.country,
    SUM(p.budget) AS total_budget
FROM projects p
GROUP BY p.country
ORDER BY total_budget DESC;

-- Calculate total visitors and total project budget for each country by joining visits and projects
SELECT
    v.country,
    SUM(v.visitors) AS total_visitors,
    SUM(p.budget) AS total_project_budget
FROM visits v
INNER JOIN projects p
    ON v.country = p.country
GROUP BY v.country;

-- Summarize organizations, projects, and total budget for each sector using MOU and project data
SELECT
    m.sector,
    COUNT(DISTINCT m.organization) AS total_mou_orgs,
    COUNT(DISTINCT p.project_name) AS total_projects,
    SUM(p.budget) AS total_budget
FROM mou m
LEFT JOIN projects p
    ON m.country = p.country
   AND m.sector = p.sector
GROUP BY m.sector;

-- Retrieve visit, MOU, and project details for each country and sort projects by highest budget
SELECT
    v.country,
    v.visit_type,
    v.year AS visit_year,
    v.visitors,
    m.organization,
    m.sector,
    m.signed_year,
    p.project_name,
    p.budget,
    p.status,
    p.year AS project_year
FROM visits v
LEFT JOIN mou m
    ON v.country = m.country
LEFT JOIN projects p
    ON m.country = p.country
   AND m.sector = p.sector
ORDER BY v.country, p.budget DESC;