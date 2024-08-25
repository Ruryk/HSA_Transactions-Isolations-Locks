-- Scenario to demonstrate Non-repeatable Read

-- First transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;  -- Suppose it returns 100
-- (Do not commit yet)

-- Second transaction
BEGIN;
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;  -- The second transaction commits the update

-- First transaction resumes
SELECT value FROM test_table WHERE id = 1;  -- Non-repeatable read: returns 200, which is different from the first read
COMMIT;
