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
INSERT INTO adult VALUES (NULL, 0);
INSERT INTO adult(age) VALUES (0);

-- Add NOT NULL constraint to the `age` attribute 
ALTER TABLE adult MODIFY age INT NOT NULL;

--> 2. DEFAULT constraint: default value for `age` is 19, and try inserting just into `id`
ALTER TABLE adult MODIFY age INT NOT NULL DEFAULT 19; 
INSERT INTO adult(id) VALUES (0); 

-- The MODIFY keyword is used to modify attributes (eg. change data type, add constraint, etc.)


--> 3. Attribute CHECK constraint: values for `age` must be more than 18

ALTER TABLE adult MODIFY age INT NOT NULL DEFAULT 19 CHECK (age > 18);

-- We could use both MODIFY and ADD keywords in this case, where the CHECK condition only involves the current attribute of interest. The ADD keyword is used to add constraints to the table, not just specific to an attribute

ALTER TABLE adult ADD CHECK(age>18); 

-- To delete this: 
ALTER TABLE adult DROP Constraint adult_chk_2;

-- Try inserting a value less than 18
INSERT INTO adult VALUES (1, 10);

show CREATE TABLE adult; -- to check the constraint(s)


--> 4. Tuple CHECK constraint: involving multuple attributes where age has to be more than id 

ALTER TABLE adult ADD CHECK(age>id);

-- Clear all tuples
DELETE FROM adult;

-- Only ADD can be used here, since the CHECK condition involves multiple attributes

-- Try inserting and updating values to furfill and violate the constraint
INSERT INTO adult VALUES (21,20);
INSERT INTO adult VALUES (21,22);
UPDATE adult SET age = 19; 


--> 5. Triggers
-- Triggers are used to execute some codes when a certain event occurs on INSERT, UPDATE, DELETE

-- We will try to achieve the similar effects of the above constraints with triggers instead
CREATE TABLE adult_trigger(id int, age int, primary key (id)); 

-- 5.1. BEFORE

-- Store age limit in a variable to be reused
SET @age_limit = 19; 

-- Create a trigger that changes the value of `age` to the age limit 
DELIMITER $$
CREATE TRIGGER trigger_age
BEFORE INSERT ON adult_trigger 
FOR EACH ROW 
    SET NEW.age = 19; -- @age_limit

INSERT INTO adult_trigger VALUES (0, 10);


-- To see the trigger:
SHOW TRIGGERS; 
-- To delete the trigger:
DROP TRIGGER trigger_age;


-- Create a trigger that changes the value of `age` to the age limit only if it is below the limit
DELIMITER $$ -- need to first change the delimiter to allow multiple statements in the terminal 

CREATE TRIGGER trigger_age
BEFORE INSERT ON adult_trigger 
FOR EACH ROW
    BEGIN
        IF NEW.age < @age_limit THEN
            SET NEW.age = @age_limit;
        END IF;
    END $$ 

DELIMITER ;

INSERT INTO adult_trigger VALUES (2, 10), (1,30);


-- 5.2. AFTER

-- Create a trigger that after updating `adult`, it will insert the same old values into `adult_trigger`

CREATE TRIGGER update_after2
AFTER UPDATE ON adult 
FOR EACH ROW
    INSERT INTO adult_trigger VALUES (OLD.id, OLD.age);
-- Note that if we change AFTER to BEFORE here, we have the same restult as the above trigger. When the UPDATE is firstly executed, the system creates a psudo table called NEW, which contains the new values of the updated tuples. The INSERT operation will then insert the new values from NEW into `adult_trigger`, which can be done before or after the actual UPDATE changes made. 

-- Test it by updating `adult`

UPDATE adult SET age = 40 WHERE id = 21;


-- Added notes on NEW and OLD, from MySQL documentation:
-- "In an INSERT trigger, only NEW.col_name can be used; there is no old row. In a DELETE trigger, only OLD.col_name can be used; there is no new row. In an UPDATE trigger, you can use OLD.col_name to refer to the columns of a row before it is updated and NEW.col_name to refer to the columns of the row after it is updated." 

-- Alternatively, think of it this way: 
-- keywords NEW and OLD simply refer to the new tuple / records being inserted or after an update, and the old tuple / records being deleted or before an update. OLD does not exist for insertion; NEW does not exist for deletion. They are not really related to the BEFORE and AFTER keywords. I proved myself wrong in class by demonstrating that updating in AFTER TRIGGER is not allowed.


-- BEFORE vs AFTER: 
-- BEFORE is usually used for logics checks or including timestamps; AFTER is usually used for updating related tables.



--> 6. Triggger vs constraint

ALTER TABLE adult_trigger ADD CHECK (age > 0); 

INSERT INTO adult_trigger VALUES (5, -1); -- why does this get passed? 

