-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Indexes
-- Nov 3 2022
-- Instructor: Yichun Zhao
-------------------------------

--> IMDB dataset imported from https://datasets.imdbws.com/



--> Demonstrating how slow a query can be: Get info of actors with name starting with "Robert"
SELECT * from name_basics WHERE primaryName like "Robert%";

--> Intro to indexes

-- Create index on name column of actors table
CREATE INDEX 'inx_name' ON name_basics (primaryName);
CREATE INDEX 'inx_name' ON name_basics (primaryName);
-- Try again! 
SELECT * FROM name_basics WHERE primaryName like "Robert%";
-- To see index(es) on a table:
SHOW INDEX FROM name_basics;

-- To delete an index on a table:
DROP INDEX inx_name ON name_basics;



--> Indexes and primary key 

-- using toy example
CREATE database indexes;
USE indexes;

CREATE TABLE data(id int, x int, primary key(id));

DESCRIBE data;

-- What does a pk do? 
INSERT INTO data VALUES (5,2), (4,6), (1,3), (2,5), (3,4);
SELECT * FROM data;


-- Where are the actual data stored on disc? 
-- usually: /var/lib/mysql
-- in my case on my Mac: /opt/homebrew/var/mysql


-- Add some VARCHAR data and check data on disc. What do we see? 


-- What if we change the pk values? (pk = 10 - pk)



--> Information schema
SHOW DATABASES;
USE information_schema;
SHOW TABLES;

-- Let's check out the table that stores the indexes! 


--> More about indexes
USE indexes;

-- EXPLAIN keyword
EXPLAIN SELECT * FROM data WHERE id = 5;

EXPLAIN SELECT * FROM data WHERE x = 5;

-- How does the query execution change if we add an index on x?

-- What if change the values of the column(s) which is not a pk but indexed? (x = 10 - x) 
-- Why are we not seeing the same effect as we did with the pk?



--> Cluster index, primary index, secondary / non-clustered index

-- Muti-column index 
ALTER TABLE data DROP -- as a reminder to drop existing indexes;



--> Why don't we indexes all possible combinations of columns then?