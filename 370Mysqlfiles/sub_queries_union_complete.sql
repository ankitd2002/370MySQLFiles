-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Sub-queries and Union
-- Oct 20 2022
-- Instructor: Yichun Zhao
-------------------------------

--> Given the db schema:

-- Person(v_number, name)
-- Instructor(v_number, specialisation)
-- Student(v_number, major)
-- Class(code, name)
-- EnrolledIn(student, class, semester)
-- Teaches(instructor, class, semester)


--> Retrieve all pairs of different students who are in the same major

-- which table(s) do we need? do we need to join any tables?
-- which columns for projection (SELECT)?
-- what condition(s) for selection (WHERE)?

SELECT s1.*, s2.v_number
FROM student AS s1 JOIN student AS s2 ON s1.major = s2.major
WHERE s1.v_number < s2.v_number; -- why not use != ?

--> Retrieve all pairs of classes taught by the same instructor, in decending order of the instructors' v_number

SELECT DISTINCT t1.class, t2.class, t1.instructor
FROM Teaches AS t1 JOIN Teaches AS t2 ON t1.instructor = t2.instructor
WHERE t1.class < t2.class
ORDER BY t1.instructor DESC;

-- why duplicates:
SELECT * FROM teaches where instructor= 444555; 


--> Retrieve every student not enrolled in CSC 370

-- 1. students enrolled in CSC 370
SELECT student FROM EnrolledIn WHERE class = "CSC 370";

-- 2. all students not in 1. above.
SELECT v_number FROM student WHERE 
v_number NOT IN (SELECT student FROM EnrolledIn WHERE class = "CSC 370");


-- about the IN keyword: 
WHERE v_number != 123 OR v_number != 456
-- is equivalent to 
WHERE v_number NOT IN (123, 456 )


--> Retrieve all CSC classes that Carol has never taught

-- 1. classes that Carol has taught
SELECT class FROM Person JOIN Teaches ON instructor = v_number WHERE name = "carol"; 
-- 2. CSC Classes that are not in 1.
SELECT code FROM class 
WHERE code NOT IN ( SELECT class FROM Person JOIN Teaches ON instructor = v_number WHERE name = "carol" )
AND code LIKE "CSC%";



-- OR using correlated sub-queries

SELECT code FROM Class WHERE NOT EXISTS (
  SELECT class 
  FROM Person JOIN Teaches ON v_number = instructor 
  WHERE name = "Carol" AND class = code
) 
AND code LIKE "CSC%"; 

-- why is this bad? 


--> Find the people who are neither students nor instructors ( demonstrating UNION and UNION ALL )


SELECT * FROM Person WHERE v_number NOT IN (SELECT v_number FROM Student) AND v_number NOT IN (SELECT v_number FROM instructor); 



SELECT * FROM Person WHERE v_number NOT IN (SELECT v_number FROM Student UNION SELECT v_number FROM instructor); 


SELECT * FROM Person WHERE v_number NOT IN (SELECT v_number FROM Student UNION ALL SELECT v_number FROM instructor); -- no duplicates from the raw data