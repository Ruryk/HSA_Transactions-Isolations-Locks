-- First transaction
BEGIN;
SELECT value FROM test_table WHERE id = 1;

-- Second transaction
BEGIN;
UPDATE test_table SET value = 200 WHERE id = 1;
COMMIT;

-- First transaction resumes
SELECT value FROM test_table WHERE id = 1;
COMMIT;
