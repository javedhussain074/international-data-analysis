-- Create a database named international_analysis
CREATE DATABASE international_analysis;

-- Select the database to use for upcoming operations
USE international_analysis;

-- Create a table named visits to store visit data
CREATE TABLE visits (
    id INT PRIMARY KEY,
    country VARCHAR(100),
    visit_type VARCHAR(50),
    year INT,
    visitors INT
);

-- Create a table named mou to store MoU data
CREATE TABLE mou (
    id INT PRIMARY KEY,
    organization VARCHAR(255),
    country VARCHAR(100),
    sector VARCHAR(100),
    signed_year INT
);

-- Create a table named projects to store project data
CREATE TABLE projects (
    id INT PRIMARY KEY,
    project_name VARCHAR(255),
    country VARCHAR(100),
    sector VARCHAR(100),
    budget DECIMAL(15,2),
    status VARCHAR(50),
    year INT
);