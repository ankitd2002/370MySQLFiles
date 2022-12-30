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


--> Retrieve all data from Person



--> Retrieve all names from Person



--> Retrieve all unique names from Person



--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey' ( recall the corresponding relational operators: projection and selection )

 

--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey'and involved those with v# > 123456

 

--> Retrieve all unique names from Person that are not alphabetically smaller than 'Joey' *or* involved those with v# > 123456



--> Retrieve all unique names from Person that are alphabetically smaller than 'Joey' *or* not involved those with v# > 123456



--> Retrieve all instructors who teach a course in which they specialise ( demonstrating ,/CROSS JOIN and INNER JOIN/JOIN )



--> Retrieve the instructors and their corresponding students ( demonstrating NATURAL JOIN, INNER JOIN, and difference between WHERE and ON )



--> Retrieve all Persons with information of being a student or not ( demonstrating OUTER JOIN )



