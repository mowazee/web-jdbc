-- SQL migration: add image column to NEWS table
-- Run this in your database to add the image column (nullable)

-- For SQL Server:
ALTER TABLE NEWS ADD image NVARCHAR(255) NULL;

-- For MySQL:
-- ALTER TABLE NEWS ADD COLUMN image VARCHAR(255) NULL;

-- For PostgreSQL:
-- ALTER TABLE NEWS ADD COLUMN image VARCHAR(255);

-- Note: choose the statement matching your DB and run it in your DB admin tool.
