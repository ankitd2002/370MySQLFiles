-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Introduction to SQL 
-- Oct 17 2022
-- Instructor: Yichun Zhao
-------------------------------

--> Given the db schema:

-- Person(v_number, name)
-- Instructor(v_number, specialisation)
-- Student(v_number, major)
-- Class(code, name)
-- EnrolledIn(student, class, semester)
-- Teaches(instructor, class, semester)

--> Common commands in MySQL to start
SHOW DATABASES;
USE ______; -- (database name)
SHOW TABLES;

--> Retrieve all data from Person

SELECT * FROM Person; 

--> Retrieve all names from Person

SELECT name FROM Person;

--> Retrieve all unique names from Person

SELECT DISTINCT name FROM Person;

--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey' ( recall the corresponding relational operators: projection and selection )

SELECT DISTINCT name FROM Person WHERE name >="Joey"; 

--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey'and involved those with v# > 123456

SELECT DISTINCT name FROM Person WHERE name >= "Joey" AND v_number > 123456;

--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey' *or* involved those with v# > 123456

SELECT DISTINCT name FROM Person WHERE name >= "Joey" OR v_number > 123456;

--> Retrieve all unique names from Person that are alphabetically smaller than 'Joey' *or* not involved those with v# > 123456

SELECT DISTINCT name FROM Person WHERE name >= "Joey" OR NOT v_number > 123456 ;

-- To achieve the same result as "WHERE name >= "Joey" AND v_number <= 123456", you need to change the OR here to AND due to logics

--> Retrieve all instructors who teach a course in which they specialise ( demonstrating ,/CROSS JOIN, INNER JOIN/JOIN, and difference between WHERE and ON )

SELECT Instructor.* FROM Instructor, Class WHERE specialisation = name;

SELECT Instructor.* FROM Instructor, Class WHERE Instructor.specialisation = Class.name;

SELECT Instructor.* FROM Instructor CROSS JOIN Class WHERE Instructor.specialisation = Class.name;

SELECT Instructor.* FROM Instructor INNER JOIN Class ON Instructor.specialisation = Class.name; 

SELECT Instructor.* FROM Instructor JOIN Class ON Instructor.specialisation = Class.name; 

SELECT Instructor.* FROM Instructor JOIN Class WHERE Instructor.specialisation = Class.name; 

-- note that WHERE's filtering comes after JOIN, and ON's filtering happens before JOIN. They do not make a difference for INNER JOINs but they do for OUTER JOINs. 

--> Retrieve the instructors and their corresponding students ( demonstrating NATURAL JOIN, INNER JOIN )

SELECT * FROM Teaches NATURAL JOIN EnrolledIn;

SELECT * FROM Teaches INNER JOIN EnrolledIn ON Teaches.class = EnrolledIn.class AND Teaches.semester = EnrolledIn.semester;

--> Retrieve all Persons with information of being a student or not ( demonstrating OUTER JOIN )

SELECT * FROM Person LEFT OUTER JOIN Student ON Person.v_number = Student.v_number;

SELECT * FROM Person LEFT JOIN Student ON Person.v_number = Student.v_number;

SELECT * FROM Student RIGHT OUTER JOIN Person ON Person.v_number = Student.v_number;

-- note that MySQL does not have FULL OUTER JOIN but you can emulate it in MySQL
