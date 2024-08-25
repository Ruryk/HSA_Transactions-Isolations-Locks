-- First transaction
START TRANSACTION;
SELECT COUNT(*) FROM test_table WHERE value > 100;

-- Second transaction
START TRANSACTION;
INSERT INTO test_table (value) VALUES (150);
COMMIT;

-- First transaction resumes
SELECT COUNT(*) FROM test_table WHERE value > 100;
COMMIT;
