-- Scenario to demonstrate transaction isolation

-- First transaction
BEGIN;
UPDATE test_table SET value = 200 WHERE id = 1;
-- (Do not commit yet)

-- Second transaction
BEGIN;
-- Use READ COMMITTED, the default isolation level in PostgreSQL
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT value FROM test_table WHERE id = 1;  -- This will see the value only if the first transaction is committed
COMMIT;

-- First transaction rolls back
ROLLBACK;  -- The update to 200 is undone
