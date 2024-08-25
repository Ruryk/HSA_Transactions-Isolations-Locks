-- Set transaction isolation level (optional)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

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
