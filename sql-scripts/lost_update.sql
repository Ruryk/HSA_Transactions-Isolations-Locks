-- Set transaction isolation level (optional)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Disable autocommit to start manual transaction management
SET autocommit = 0;

-- First transaction
START TRANSACTION;
SELECT value FROM test_table WHERE id = 1;

-- Second transaction
START TRANSACTION;
SELECT value FROM test_table WHERE id = 1;
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;

-- First transaction resumes
UPDATE test_table SET value = 150 WHERE id = 1;
COMMIT;

-- Re-enable autocommit after transactions are done
SET autocommit = 1;
