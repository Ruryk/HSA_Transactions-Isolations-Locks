-- Scenario to demonstrate Phantom Read

-- Set transaction isolation level to REPEATABLE READ (optional)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- First transaction
BEGIN;
SELECT COUNT(*) FROM test_table WHERE value > 100;  -- Suppose it returns 2 rows
-- (Do not commit yet)

-- Second transaction
BEGIN;
INSERT INTO test_table (value) VALUES (150);  -- Insert a new row that meets the condition in the first transaction
COMMIT;

-- First transaction resumes
SELECT COUNT(*) FROM test_table WHERE value > 100;  -- Phantom read: now returns 3 rows, including the new row
COMMIT;
