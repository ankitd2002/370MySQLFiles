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

SELECT s1.* , s2.v_number
FROM student as S1 JOIN student as S2 ON S1.major = S2.major
WHERE s1.v_number < s2.v_number


--> Retrieve all pairs of classes taught by the same instructor, in decending order of the instructors' v_number
SELECT t1.class , t2.instructor, t2.class
FROM teaches as t1 JOIN teaches as t2 ON t1.instructor = t2.instructor 
WHERE t1.class < t2.class
ORDER BY t1.instructor desc;



--> Retrieve every student not enrolled in CSC 370

-- 1. students enrolled in CSC 370
SELECT student 
FROM enrolledIn 
WHERE class = "CSC 370";
-- 2. all students not in 1. above.
SELECT v_number
FROM student WHERE 
v_number NOT IN (SELECT student FROM EnrolledIn WHERE class = "CSC 370") ;



--> Retrieve all CSC classes that Carol has never taught

-- 1. classes that Carol has taught

SELECT class FROM Person JOIN Teaches ON instructor = v_number WHERE name = "Carol"
-- 2. CSC Classes that are not in 1.
SELECT code FROM class 
WHERE code NOT IN (SELECT class FROM Person JOIN Teaches 
ON instructor = v_number WHERE name = "carol")


-- OR using correlated sub-queries

SELECT code FROM Class WHERE NOT EXISTS (
  SELECT class 
  FROM Person JOIN Teaches ON v_number = instructor 
  WHERE name = "Carol" AND class = code
) 
AND code LIKE "CSC%"; 

-- why is this bad? 


--> Find the people who are neither students nor instructors ( demonstrating UNION and UNION ALL )


