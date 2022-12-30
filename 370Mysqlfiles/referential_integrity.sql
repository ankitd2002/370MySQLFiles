-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Referential Integrity; ALTER TABLE
-- Oct 24 2022
-- Instructor: Yichun Zhao
-------------------------------

  -- referential integrity & alter table
    -- insert, inconsistent state. what to do?
    -- add FK won't work, why not?
    -- drop tuple, add FK
    -- add tuple now it works
    -- drop fk to try again
    -- set policy as cascade this time
    -- add tuple, show cascading effect
    -- drop tuple, drop fk
    -- update
    -- show set null policy
    -- delete

--> DB Setup

CREATE DATABASE referential_integrity;
USE referential_integrity;

CREATE TABLE R(x int, y int, primary key (x));
CREATE TABLE S(y int, z int, primary key (y));

-- What are the constraints introduced here?


--> Insertion in the presence of constraints related to pk

INSERT INTO `R` VALUES (0, 0),(0, 1);
-- Why does this fail? 

INSERT INTO `R` VALUES (0, 0);


--> Foreign key and ALTER TABLE

-- Add another constraint: R.y is a foreign key of S.y. Does it work? 


--> Deletion and referential integrity

-- Delete tuple(s) in S with y value of 0. Does it work? 
DELETE FROM `S` WHERE `y` = 0;

---> SET NULL policy

-- Change referential integrity policy of fk constraint
-- Try the previous deletion again
-- Still Fails! Why? 
-- Try again


---> CASCADE policy

INSERT INTO `S` VALUES (1, 1);
INSERT INTO `R` VALUES (1, 1);

-- Change referential integrity policy of fk constraint

-- Recall tables
SELECT * FROM `R`;
SELECT * FROM `S`;

-- Now delete from S with y value of 1
DELETE FROM `S` WHERE `y` = 1;

SELECT * FROM `S`;
SELECT * FROM `R`;


--> Update and referential integrity

INSERT INTO `S` VALUES (1, 1);
INSERT INTO `R` VALUES (1, 1);

-- Update value of S.y to 2 from 1
UPDATE `S` SET `y` = 2 WHERE `y` = 1;

-- As a comparison, check R
SELECT * FROM `R`;
UPDATE `R` SET `y` = 1 WHERE `y` = 2; -- This fails! 


--> Unique keys
ALTER TABLE T ADD UNIQUE KEY(z); -- Just as an example (table T is not created)
-- What is the difference between unique and primary key?
