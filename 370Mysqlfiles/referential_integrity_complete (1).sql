-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Referential Integrity; ALTER TABLE
-- Oct 24 2022
-- Instructor: Yichun Zhao
-------------------------------


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
ALTER TABLE R ADD FOREIGN KEY (y) REFERENCES S(y); 
INSERT INTO S VALUES (0,0);

--> Deletion and referential integrity

-- Delete tuple(s) in S with y value of 0. Does it work? 
DELETE FROM `S` WHERE `y` = 0;


---> SET NULL policy

-- Change referential integrity policy of fk constraint
ALTER TABLE R ADD FOREIGN KEY (y) REFERENCES S(y) ON DELETE SET NULL; 
-- Try the previous deletion again
DELETE FROM `S` WHERE `y` = 0;
-- Still Fails! Why? 
ALTER TABLE R DROP CONSTRAINT r_ibfk_1; 
-- Try again
DELETE FROM `S` WHERE `y` = 0;


---> CASCADE policy

INSERT INTO `S` VALUES (1, 1);
INSERT INTO `R` VALUES (1, 1);

-- Change referential integrity policy of fk constraint
ALTER TABLE R ADD FOREIGN KEY (y) REFERENCES S(y) ON DELETE CASCADE; 

ALTER TABLE R DROP CONSTRAINT r_ibfk_2;

-- Recall tables
SELECT * FROM `R`;
SELECT * FROM `S`;

-- Now delete from S with y value of 1
DELETE FROM `S` WHERE `y` = 1;

-- Check again
SELECT * FROM `S`;
SELECT * FROM `R`;


--> Update and referential integrity

ALTER TABLE R ADD FOREIGN KEY (y) REFERENCES S(y) ON UPDATE CASCADE; 

ALTER TABLE R DROP CONSTRAINT r_ibfk_3;

INSERT INTO `S` VALUES (1, 1);
INSERT INTO `R` VALUES (1, 1);

-- Update value of S.y to 2 from 1
UPDATE `S` SET `y` = 2 WHERE `y` = 1;

-- As a comparison, check R
SELECT * FROM `R`;
UPDATE `R` SET `y` = 1 WHERE `y` = 2; -- This fails because y in R is a foreign key of S.y; CASCADE means that if the value from the pk is changed, the the value from the fk is also changed; not the other way around. 


--> Unique keys
ALTER TABLE T ADD UNIQUE KEY(z); -- Just as an example (table T is not created)
-- What is the difference between unique and primary key?

-- Note that in the lecutre I answered a question saying that no multiple NULLS are allowed for a UNIQUE KEY; It turns out that you can do this in MySQL. Some other SQL DB systems do not allow this. A quick example:
ALTER TABLE R UNIQUE KEY(y);
INSERT INTO R VALUES (4, NULL), (5, NULL);
SELECT * FROM R;