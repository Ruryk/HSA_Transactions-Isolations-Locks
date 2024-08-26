-- First transaction
BEGIN;
UPDATE test_table SET value = 200 WHERE id = 1;

-- Second transaction
BEGIN;
-- Use READ COMMITTED, the default isolation level in PostgreSQL
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT value FROM test_table WHERE id = 1;
COMMIT;

-- First transaction rolls back
ROLLBACK;  -- The update to 200 is undone
