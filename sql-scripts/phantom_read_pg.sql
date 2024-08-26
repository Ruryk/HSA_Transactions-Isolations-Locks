-- Set transaction isolation level to REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- First transaction
BEGIN;
SELECT COUNT(*) FROM test_table WHERE value > 100;

-- Second transaction
BEGIN;
INSERT INTO test_table (value) VALUES (150);
COMMIT;

-- First transaction resumes
SELECT COUNT(*) FROM test_table WHERE value > 100;
COMMIT;
