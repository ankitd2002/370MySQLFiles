-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Views
-- Nov 7 2022
-- Instructor: Yichun Zhao
-------------------------------


--> Non-materialized view

-- Non-materialized is essentially a virtual table. 
--The data in this virtual table is not stored on disk, 
--but is generated on the fly when the query is executed.

CREATE DATABASE views;
USE views;

CREATE TABLE data (id INT PRIMARY KEY, x INT); 
INSERT INTO data VALUES (0, 2), (1, 3), (2, 4), (3, 5), (4, 6);

CREATE TABLE data_v (x INT PRIMARY KEY, y INT);
INSERT INTO data_v VALUES (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);

ALTER TABLE data ADD FOREIGN KEY (x) REFERENCES data_v(x);


-- Create a view, for tuples with x value < 6 in data
SELECT * FROM data where x < 6;

CREATE VIEW x_less_than_6 AS SELECT * FROM data where x < 6;

SELECT * FROM x_less_than_6;


-- Check SHOW CREATE TABLE
SHOW CREATE TABLE x_less_than_6; 



-- Check files on disc. What do we notice? 
ls /opt/homebrew/var/mysql/views -- or your path to your mysql db files


---> Inseret, update, delete on views

-- Delete tuple(s) with x = 4
DELETE FROM x_less_than_6 WHERE x = 4;

-- Delete tuple(s) with x = 6
DELETE FROM x_less_than_6 WHERE x = 6;

-- Insert tuple (4, 5)
INSERT INTO x_less_than_6 VALUES (4, 5); -- violate pk constraint 

-- Insert tuple (10, 1)
INSERT INTO x_less_than_6 VALUES (10, 1); -- violate fk constraint 

-- Insert tuple (10, 2)
INSERT INTO x_less_than_6 VALUES (10, 2);

-- Insert tuple (11, 6)
INSERT INTO x_less_than_6 VALUES (11, 6);


---> Views for more complex queries

-- Create a view for id, data_v.x, y from natural joins between the two tables
SELECT id, data_v.x, y FROM data NATURAL JOIN data_v; 

CREATE VIEW view_join AS SELECT id, data_v.x, y FROM data NATURAL JOIN data_v; -- which table x is selected from matter! 


-- Try delete (also notice how generally DELETE only deletes whole rows)
DELETE FROM view_join WHERE id = 100;

-- Insert (100, 1, 2)
INSERT INTO view_join VALUES (100, 1, 2); 
INSERT INTO view_join(id, x, y) VALUES (100, 1, 2); 

-- Insert (1,1) for x, y 
INSERT INTO view_join(x, y) VALUES (1, 1); 
-- would not work if x is from data (instead of data_v) in the original query for the view 

-- Update id from 10 to 101
UPDATE view_join SET id = 101 WHERE id = 10;

-- Update x from 5 to 7
UPDATE view_join SET x = 7 WHERE x = 5;

-- Change referential integrity policy of fk constraint to CASCADE and try again
ALTER TABLE data DROP FOREIGN KEY data_ibfk_1; 
ALTER TABLE data ADD FOREIGN KEY (x) REFERENCES data_v(x) ON UPDATE CASCADE; 


---> Access controls
-- eg. CREATE USER 'testuser'@'localhost' IDENTIFIED BY '';
GRANT SELECT, INSERT ON view_join TO 'testuser'@'localhost';
-- Then test if a DELETE could work with testuser
DELETE FROM view_join;

-- More at https://dev.mysql.com/doc/refman/8.0/en/grant.html



--> Materialized view

-- CREATE MATERIALIZED VIEW statement is not available in MySQL, but we can emulate it 

-- Create a materialized view for id, data_v.x, y from natural joins between the two tables
CREATE TABLE view_m AS SELECT id, data_v.x, y FROM data NATURAL JOIN data_v; 

-- Update on the base table, data_v, to set id from 7 to 200, and check the materialized view 
UPDATE view_join SET x = 200 WHERE x = 7;

-- What could we do about this? 
-- AFTER Triggers on insertion, update, deletion 


--> Indexes vs materialized views
-- Both could improve query performance. 
-- Materialized views are considered as a separate entity which could involve multiple tables, but an index is only for a table / relation.
-- Materialized views could be more flexible to use, and better especially for complex queries involving joins / aggregation, when a query's computation cost is high and the resulting data set is small. 
-- An index on a relation is generally smaller than the relation itself, and all indexes on one relation take roughly the same amount of space. However, materialized views can vary radically in size, and some — those involving joins — can be very much larger than the relation or relations on which they are built. 