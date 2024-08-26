SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Disable autocommit to start manual transaction management
SET autocommit = 0;

START TRANSACTION;
UPDATE test_table SET value = 200 WHERE id = 1;

START TRANSACTION;
SELECT value FROM test_table WHERE id = 1;
COMMIT;

ROLLBACK;

-- Re-enable autocommit after transactions are done
SET autocommit = 1;