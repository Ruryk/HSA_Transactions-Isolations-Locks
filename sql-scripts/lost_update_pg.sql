-- Set transaction isolation level (optional, to demonstrate behavior)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- First transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;

-- Second transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;  -- This transaction commits

-- First transaction resumes
UPDATE test_table SET value = 150 WHERE id = 1;
COMMIT;
