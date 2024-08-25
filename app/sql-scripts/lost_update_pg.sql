-- Scenario to demonstrate Lost Update

-- Set transaction isolation level (optional, to demonstrate behavior)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- First transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;  -- Suppose it returns 100
-- (Do not commit yet)

-- Second transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;  -- Returns 100 as well
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;  -- This transaction commits

-- First transaction resumes
UPDATE test_table SET value = 150 WHERE id = 1;
COMMIT;  -- This transaction also commits, but the update to 200 is lost
