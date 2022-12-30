-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Indexes
-- Nov 3 2022
-- Instructor: Yichun Zhao
-------------------------------

--> IMDB dataset imported from https://datasets.imdbws.com/
USE imdb;
SHOW TABLES;
SELECT * FROM name_basics limit 1;
SELECT * FROM title_basics limit 1;


--> Demonstrating how slow a query can be: Get info of actors with name starting with "Robert"
SELECT * FROM name_basics WHERE primaryName like "Robert%";

--> Intro to indexes

-- Create index on name column of actors table
CREATE INDEX `inx_name` ON name_basics (primaryName);

-- Try again! 
SELECT * FROM name_basics WHERE primaryName like "Robert%";

-- To see index(es) on a table:
SHOW INDEX FROM name_basics;

-- To delete an index on a table:
DROP INDEX inx_name ON name_basics;


--> Indexes and primary key indexes and primary key

-- using toy example
CREATE database indexes;
USE indexes;

CREATE TABLE data(id int, x int, primary key(id));

DESCRIBE data;

-- What does a pk do? 
INSERT INTO data VALUES (5,2), (4,6), (1,3), (2,5), (3,4);
SELECT * FROM data;

-- When are indexes created by default? 
-- Pk, unique, foreign keys
-- Or if any combinations of the attributes do not contain unique tuples, dbms would auto generate one


-- Where are the actual data stored on disc? 
-- usually: /var/lib/mysql
-- in my case on my Mac: /opt/homebrew/var/mysql
hexdump -C dbfilepath

-- Add some VARCHAR data and check data on disc. What do we see? 
ALTER TABLE data ADD name VARCHAR(16);
UPDATE data SET name = CONCAT('name', id);



-- What if we change the pk values? (pk = 10 - pk)
UPDATE data SET id = 10-id; 
UPDATE data SET name = CONCAT('newname', id);


--> Information schema
SHOW DATABASES;
USE information_schema;
SHOW TABLES;

-- Let's check out the table that stores the indexes! 
SELECT * FROM INNODB_INDEXES;
SELECT * FROM TRIGGERS;
SELECT * FROM INNODB_COLUMNS WHERE TABLE_ID = someId; -- from INNODB_TABLES

--> More about indexes
USE indexes;

-- EXPLAIN keyword
EXPLAIN SELECT * FROM data WHERE id = 5;

EXPLAIN SELECT * FROM data WHERE x = 5;

-- How does the query execution change if we add an index on x?
CREATE INDEX x_index ON data(x);

-- What if change the values of the column(s) which is not a pk but indexed? (x = 10 - x) 
UPDATE data SET x = 10 - x; 
-- Why are we not seeing the same effect as we did with the pk?



--> Clustered index, primary index, secondary / non-clustered index
-- Primary index are the ones involving the PRIMARY key
-- Clustered index includes primary index, with extra case where a UNIQUE key with NOT NULL constraint could also be a clusterd index, or be part of a clustered index. Another case would be if no tuples are unique, then the dbms creates a generated key for each tuple. 
-- Clustered index gets to define the physical ordering of the data. 
-- Indexes that are not clustered are called secondary or non-clustered index. 
-- All of the above could be multi-column index

-- Multi-column index 
ALTER TABLE data DROP x_index; -- as a reminder to drop existing indexes;

SELECT * FROM WHERE x=8 ORDER BY name;

CREATE INDEX x_index ON data(x);
CREATE INDEX name_index ON data(name);
CREATE INDEX multi_index ON data(x, name); -- the best because the order of columns specified follows the same order of the columns being used in the execution of the query
CREATE INDEX multi_index ON data(name, x)


--> Why don't we index all possible combinations of columns then?
-- Think about what happens to the indexes when we do insertion, updates involving the keys used in an index, and deletion.


--> An intuitive example showcasing how indexes could work under the hood

-- Consider the following table where id is the pk:
-- id | x
-- 1  | 2
-- 2  | 5
-- 3  | 4
-- 4  | 6
-- 5  | 3

-- If we create an index on x, we would have something like this:
-- x -> id
-- 2 -> 1
-- 3 -> 5
-- 4 -> 3
-- 5 -> 2
-- 6 -> 4

-- Now if we do SELECT * FROM data WHERE x = 3, we would first search for the index to find the id, and then find the actual data in the table. 
-- In module 4 you will learn the data structure behind this, but for now you could think of it as a binary search tree: 
-- Values of x are partitioned into two groups, (2,3) and (4,5,6). So when this query finds x = 3, it first selects group #1, which then divides into (2) and (3), and the later group contains what we want. In this way, we could search in log time, instead of linear time. 