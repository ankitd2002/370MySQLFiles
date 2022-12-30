-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Constraints; Triggers
-- Oct 31 2022
-- Instructor: Yichun Zhao
-------------------------------


--> DB Setup 

CREATE DATABASE constraints;
USE constraints;

CREATE TABLE adult(id int, age int, primary key (id));
DESCRIBE adult;


--> 1. We have seen two common constraints

-- 1.1. UNIQUE constraint: try inserting duplicate values
INSERT INTO adult VALUES (0,0), (0,1);

-- 1.2. NOT NULL constraint: try inserting NULL value directly and indirectly 
INSERT INTO adult VALUES (NULL,0);
INSERT INTO adult VALUES (age) (0);

-- Add NOT NULL constraint to the `age` attribute 
ALTER TABLE adult modify age INT NOT Null;


--> 2. DEFAULT constraint: default value for `age` is 19, and try inserting just into `id`

-- The MODIFY keyword is used to modify attributes (eg. change data type, add constraint, etc.)
ALTER TABLE ADULT MODIFY AGE INT DEFAULT 19;
INSERT INTO  adult (id) VALUES (0);


--> 3. Value CHECK constraint: values for `age` must be more than 18
ALTER TABLE ADULT MODIFY age >18;

-- We could use both MODIFY and ADD keywords in this case, where the CHECK condition only involves the current attribute of interest. The ADD keyword is used to add constraints to the table, not just specific to an attribute

-- Try inserting a value less than 18

show CREATE TABLE adult; -- to check the constraint(s)


--> 4. Tuple CHECK constraint: involving multuple attributes where age has to be more than id 

-- Clear all tuples
DELETE FROM adult;

-- Only ADD can be used here, since the CHECK condition involves multiple attributes

-- Try inserting and updating values to furfill and violate the constraint



--> 5. Triggers
-- Triggers are used to execute some codes when a certain event occurs on INSERT, UPDATE, DELETE

-- We will try to achieve the same effects of the above constraints with triggers instead
CREATE TABLE adult_trigger(id int, age int, primary key (id)); 

-- 5.1. BEFORE

-- Store age limit in a variable to be reused
SET @age_limit = 19;

-- Create a trigger that changes the value of `age` to the age limit 


-- To see the trigger:
SHOW TRIGGERS;
-- To delete the trigger:
DROP TRIGGER trigger_name;


-- Create a trigger that changes the value of `age` to the age limit only if it is below the limit
DELIMITER $$ -- need to first change the delimiter to allow multiple statements in the terminal 



DELIMITER ;


-- 5.2. AFTER

-- Create a trigger that after updating `adult`, it will insert the same old values into `adult_trigger`

-- Test it by updating `adult`



--> 6. Triggger vs constraint


--practice exam questions

CREATE DATABASE exam4;
USE exam4;

CREATE TABLE R(x int, y int, z VARCHAR (35));
CREATE TABLE S(t int, u int, v VARCHAR (35));
CREATE TABLE County(countyid INT PRIMARY KEY, stateid int, name1 VARCHAR (35));
CREATE TABLE State1(stateid INT, name1 VARCHAR(35));
DESCRIBE R;

INSERT INTO R VALUES (1,1,'Alice'), (1,2,'Eve'), (1,2,'Eve'), (2,4,'Carol'), (3,5,'Eve'), (4,6,'Bob');
INSERT INTO S VALUES (1,NULL,'a'), (2,4,'b'), (3,2,'a'), (4,5,'b'), (5,3,'a'), (6,2,'b');

INSERT INTO County(1,5,'ankit'),(3,5,'aman'),(4,5,'akshay');
INSERT INTO State1(4,'ankit'),(5,'aman'),(5,'akshay');

SELECT x, COUNT(z)
FROM R
GROUP BY x;

SELECT *
FROM R
JOIN S ON (R.x = S.u);

SELECT *
FROM R
INNER JOIN S ON (R.x = S.u);

SELECT *
FROM R
LEFT OUTER JOIN S ON (R.x = S.u);