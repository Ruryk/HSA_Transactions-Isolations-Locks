-- Set transaction isolation level (optional)
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Disable autocommit to start manual transaction management
SET autocommit = 0;

-- First transaction
START TRANSACTION;
SELECT value FROM test_table WHERE id = 1;

-- Second transaction
START TRANSACTION;
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;

-- First transaction resumes
SELECT value FROM test_table WHERE id = 1;
COMMIT;

-- Re-enable autocommit after transactions are done
SET autocommit = 1;
