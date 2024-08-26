CREATE DATABASE IF NOT EXISTS my_database;

USE my_database;

CREATE TABLE test_table (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            value INT
);

INSERT INTO test_table (value) VALUES (10);