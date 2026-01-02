-- Migration: add image and view_count columns to NEWS table
-- Run the appropriate block for your DBMS (MySQL or SQL Server).

-- MySQL
-- ALTER TABLE NEWS ADD COLUMN image VARCHAR(255) DEFAULT NULL AFTER thumbnail;
-- ALTER TABLE NEWS ADD COLUMN view_count INT DEFAULT 0 AFTER image;

-- SQL Server
-- ALTER TABLE NEWS ADD image NVARCHAR(255) NULL;
-- ALTER TABLE NEWS ADD view_count INT NULL DEFAULT 0;

-- If you prefer a single command for SQL Server (and if DEFAULT with ADD is supported):
-- ALTER TABLE NEWS ADD image NVARCHAR(255) NULL, view_count INT DEFAULT 0;

-- Notes:
-- 1) Make a backup before running migrations.
-- 2) After adding column, you can populate `image` with paths or leave NULL. The UI will fall back to `thumbnail` or a placeholder.
-- 3) `view_count` is read by the application when listing top viewed. Consider adding an index on view_count for performance:
--    MySQL: ALTER TABLE NEWS ADD INDEX idx_view_count (view_count DESC);
--    SQL Server: CREATE INDEX idx_view_count ON NEWS(view_count DESC);
