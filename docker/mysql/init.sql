-- Maximus Pet Store - MySQL Initialization
-- This file runs automatically when the MySQL container starts for the first time

-- Create database if not exists (already created via MYSQL_DATABASE env var, but just in case)
CREATE DATABASE IF NOT EXISTS maximus_petstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the database
USE maximus_petstore;

-- Grant privileges
GRANT ALL PRIVILEGES ON maximus_petstore.* TO 'root'@'%';
FLUSH PRIVILEGES;

-- Note: Laravel migrations will create the actual tables
-- This file is for initial database setup only
