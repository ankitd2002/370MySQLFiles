-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Insertion, Update, Deletion; NULLs
-- Oct 24 2022
-- Instructor: Yichun Zhao
-------------------------------

-- Topics/Plan:
  -- insertion
  -- deletion
  -- updates
  -- NULL values: semantics
  -- ternary logic, try and or not, contrast to is not null
  -- left outer join
  -- union, intersect (i.e., join), set difference (i.e., not in) 


--> DB Setup

CREATE DATABASE nulls;
USE nulls;

--- Practice Exam questions 
CREATE DATABASE practiceExam;
USE practiceExam;

--Q1 Inserting tuples into the data for practice Exam

--creating a table data3 with x being the primary key
CREATE TABLE Data3 (x INT PRIMARY KEY, y VARCHAR(30), z VARCHAR(30));
INSERT INTO Data3 VALUES (1,'foo','9 JULY'), (2,'foo','13 Aug'), (3,'foobar','NULL');

--option1 
INSERT INTO Data3 (x,y,z) VALUES (4,Null,'i o');

--option2
INSERT INTO Data3 VALUES (1,NUll,Null); -- ERROR 1062 (23000): DUPLICATE ENTRY '1' FOR KEY 'data3.PRIMARY'

--option3
INSERT INTO Data3 (x,y,z) VALUES (Null,Null,Null); -- ERROR 1048 (23000): COLUMN 'x' CANNOT BE NULL

--Q2 Remove all the tuples from the table

--option1 
DELETE * FROM Data3;  -- this is not valid by syntax

--option2 
DELETE FROM Data3 WHERE y LIKE 'foo%' or x <3;   -- correct option

--option3
DROP Table Data1; -- this would delete everything metadata and tables;

-- Create tables based on schema (all attributes are int type): 
-- R (x, y) with x being pk
-- S (y, z) with y being pk

CREATE TABLE R(x INT, y INT,PRIMARY KEY (x));
CREATE TABLE S(y INT PRIMARY KEY, z INT);


--> Insertion

-- (0, 0),(1, 1),(2, 2) -> R 
-- (3, 0) -> S

INSERT INTO R VALUES (0,0),(1,1),(2,2);
INSERT INTO S VALUES (3,0);


--> Insert from another table
INSERT INTO S (SELECT * FROM R);



--> General update 

-- For the tuple(s) with x value of 1, update y value to 0
UPDATE R SET y = 0 WHERE x = 1;



--> Update pk attribute(s) 

-- For the tuple(s) with x value of 1, update x value to 4
-- What do you notice that is different? 
UPDATE R SET x = 4 WHERE x = 1;


--> Update with sub query

-- For the tuple(s) with y value of the ones in S, update y value to 4
UPDATE R SET y = 4 WHERE (SELECT y FROM S  WHERE y = 1);


--> Deletion

-- Remove tuple(s) with x value of 4
DELETE FROM R WHERE x=4;


--> NULL values: insertion

-- (1, NULL) -> R
-- Add 3 only to the values of x in R
-- Why can we do this?


--> Null values: update and deletion; and the effect of logical operators on NULL



--> NULL values: semantics

-- What does NULL mean? How does this inform our db design? 
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

SELECT x, y, x OR y FROM truth;

--> NULLS and various JOIN operations

-- INNER JOIN, NATURAL JOIN

-- OUTER JOIN


--> NULLS and set operations
