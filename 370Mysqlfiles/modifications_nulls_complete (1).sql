-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Insertion, Update, Deletion; NULLs
-- Oct 24 2022
-- Instructor: Yichun Zhao
-------------------------------


--> DB Setup

CREATE DATABASE nulls;
USE nulls;

-- Create tables based on schema (all attributes are int type): 
-- R (x, y) with x being pk
CREATE TABLE R (x INT, y INT, PRIMARY KEY(x));
-- S (y, z) with y being pk
CREATE TABLE S (y INT PRIMARY KEY, z INT);

--> Insertion

-- (0, 0),(1, 1),(2, 2) -> R 
INSERT INTO R VALUES (0, 0),(1, 1),(2, 2);
-- (3, 0) -> S
INSERT INTO S VALUES (3, 0);


--> Insert from another table
INSERT INTO `S` (SELECT * FROM `R`);


--> General update 

-- For the tuple(s) with x value of 1, update y value to 0
UPDATE R SET y = 0 WHERE x = 1;


--> Update pk attribute(s) 

-- For the tuple(s) with x value of 1, update x value to 4
UPDATE R SET x = 4 WHERE x = 1; 
-- What do you notice that is different? 


--> Update with sub query

-- For the tuple(s) with y value of the ones in S, update y value to 4
UPDATE R SET y = 4 WHERE y IN 
(SELECT y FROM S); 


--> Deletion

-- Remove tuple(s) with x value of 4
DELETE FROM R WHERE x = 4; 

-- To delete everything: DELETE FROM R;

--> NULL values: insertion

-- (1, NULL) -> R
INSERT INTO R VALUES (1, NULL);

-- Add 3 only to the values of x in R 
INSERT INTO R (x) VALUES (3); 

-- Why can we do this?


--> Null values: update and deletion; and the effect of logical operators on NULL

UPDATE R SET x = 4 WHERE y = NULL; 
-- versus
UPDATE R SET x = 4 WHERE y IS NULL; 


--> NULL values: semantics

-- What does NULL mean? How does this inform our db design? 
-- NULL essentially means UNKONWN 
-- What are some situations where NULLs could happen in practice? 

-- Three-valued logics


--> Truth tables in SQL

CREATE TABLE three_values(v BOOL);

INSERT INTO three_values VALUES (TRUE), (FALSE), (NULL);

-- cross join / cartesian product giving all possible combinations of values
CREATE TABLE truth AS (SELECT t0.v AS x, t1.v AS y FROM three_values AS t0, three_values AS t1);

SELECT * FROM truth;

SELECT x, y, x AND y FROM truth;

-- How do we intuitively and effectively make sense of this? 
-- Treat NULL as 0.5 
-- AND -> MIN()
-- OR -> MAX()


SELECT x, y, x OR y FROM truth;

--> NULLS and various JOIN operations

-- INNER JOIN, NATURAL JOIN
SELECT t0.v AS x, t1.v as y 
FROM three_values as t0, three_values as t1
WHERE t0.v = t1.v; 

SELECT * FROM three_values as t0 
NATURAL JOIN three_values as t1; 

SELECT * FROM three_values as t0 
INNER JOIN three_values as t1 ON t0.v = t1.v; 

-- OUTER JOIN
CREATE TABLE two_values (v bool); 
INSERT INTO two_values VALUES (TRUE), (FALSE); 

SELECT * FROM three_values LEFT OUTER JOIN two_values ON three_values.v = two_values.v;

--> NULLS and set operations (demonstraing union and intersection; for difference, try on your own!)

-- If you look up the MySQL documentation on set operations, it does say it supports intersection and difference, until you try the keywords yourself. My MySQL version is 8.0.30 and it just does not support them. 

SELECT * FROM three_values UNION SELECT * FROM two_values;

SELECT * FROM three_values UNION ALL SELECT * FROM two_values;

SELECT DISTINCT v FROM three_values as T0 INNER JOIN three_values as T1 USING(v); -- This is almost the same as the intersection of the two tables - recall that INNER JOINS do not care about NULLs

SELECT DISTINCT v FROM three_values WHERE (v) IN (SELECT v FROM three_values) OR v IS NULL; -- This is a hack to include the NULL values in the intersection