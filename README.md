# HSA12  10. Transactions, Isolations, Locks

## Set up percona and postgres and create an InnoDB table.

By changing isolation levels and making parallel queries, reproduce the main problems of parallel access:

- lost update;
- dirty read;
- non-repeatable read;
- phantom read;

## Setup

````bash
docker-compose up
````

## Results

The second command should be called from a different terminal within 5-10 seconds after the first command was called.
You can use:

````sql
DO
SLEEP(10);
````

### Lost update

Occurs when two transactions read the same data and then update it based on the value read, leading to one update being
lost.

### Dirty read

Risky reads, as they can work with unprotected data that can be reversed.

### Non-repeatable read

Occurs when a transaction reads the same row twice and finds different data because another transaction has modified it
in between.

### Phantom read

Occurs when a transaction reads a set of rows that match a condition, but another transaction inserts or deletes rows
that affect the result set.