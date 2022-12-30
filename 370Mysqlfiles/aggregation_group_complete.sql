-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Aggregation and Equivalent classes
-- Oct 20 2022
-- Instructor: Yichun Zhao
-------------------------------

--> Given the County dataset

-- brief overview of the db ( in today's lecture, we will focus on 'County', 'CountyPopulation', and 'ElectionResult' tables )

show tables;

SELECT * FROM County LIMIT 2;

DESCRIBE County;
DESCRIBE State;

SHOW CREATE TABLE County;

--> 1. Simple (bag) projection query to retrieve the population information for each year

SELECT year, population FROM CountyPopulation;
SELECT year FROM CountyPopulation;

--> 2. Set projection query

SELECT DISTINCT year FROM CountyPopulation;

--> 3. Group by query with same effect with the equivalence classes 

-- what are equivalent classes?
-- GROUP BY specifies the equivalence relation 

SELECT year FROM CountyPopulation GROUP BY year; 

--> 4. With simple aggregation: count number of tuples in each group / equivalence class

-- what is aggregation? 
-- COUNT()
-- SUM()
-- AVG()
-- MAX()
-- MIN()

SELECT year, COUNT(*) FROM CountyPopulation GROUP BY year; 

SELECT year, population FROM CountyPopulation GROUP BY year; -- this fails! Look at question 6 for why. 


--> 5. Apply a function to all tuples in each group: sum the population for each year

SELECT year, SUM(population) FROM CountyPopulation GROUP BY year;

--> 6. Try to include attribute(s) that is/are not used for "GROUP BY": 'county' / 'population'

SELECT year, population FROM CountyPopulation GROUP BY year, population;

-- what is the condition for attributes to be successfully projected when there are equivalent classes? 
-- functionally dependent on the filed specified in GROUP BY 

-- what is the simplest way for us to include such attributes to make our query to be executed successfully? 
-- include field in GROUP BY 


--> 7. More meaningfully, retrieve the total population for each state 

SELECT year, state, SUM(population)
FROM CountyPopulation JOIN County ON (county = fips) 
GROUP BY year, state; 

-- now, instead of the attribute 'state' in table 'county', involve attribute 'abbr' in table 'state'. why does this work? 


SELECT year, abbr, SUM(population)
FROM CountyPopulation JOIN County ON (county = fips) 
    JOIN state ON (id = state)
GROUP BY year, state; 

--> 8. Retrieve only the tuples with year more than 2015

SELECT year, state, SUM(population)
FROM CountyPopulation JOIN County ON (county = fips) 
WHERE year > 2015
GROUP BY year, state; 

--> 9. Retrieve only the equivalent classes with population sum more than 1000000

-- note the difference between WHERE and HAVING
-- HAVING filters for the equivalent classes
-- WHERE filters the tuples in selection operation 

SELECT year, state, SUM(population)
FROM CountyPopulation JOIN County ON (county = fips) 
WHERE year > 2015
GROUP BY year, state
HAVING SUM(population) > 1000000; 


--> 10. Now, we involve the table 'ElectionResult' to check out election information. Who won the votes each year? 

SELECT SUM(dem), SUM(gop), year FROM ElectionResult GROUP BY year;

--> 11. Retrieve the number of counties won by each party ( by grouping on a computed field using SIGN() function )

SELECT year, SIGN(dem - gop), COUNT(*)
FROM ElectionResult
GROUP BY year, SIGN(dem - gop); 

-- how to make our query result more readable?

SELECT year, SIGN(dem - gop) AS "DemsWon", COUNT(*)
FROM ElectionResult
GROUP BY year, SIGN(dem - gop)
ORDER BY year;

-- why 2 tuples returned from each year? 
-- this is expected because the question asks for the number of countries won by each party (which is different from the previous question involving the sums). 
-- I made a mistake in the lecture as a result trying to rush through the question because I was running out of time, saying the count is for the number of election votes - this is wrong because COUNT(*) here is counting how many counties with dem winnning, and also how many counties with gop winnning. Some counties have positive value from SIGN(), and some have negative, and remember the equivalent relation here is to have the same sign, which could be both + and -, hence at most 2 tuples for each year. 


-- 12. Retrieve the number of states won by each party per year

-- 12.1 First, we determine the number of votes per state per year

SELECT SUM(dem), SUM(gop), year
FROM ElectionResult JOIN County ON fips = county JOIN State ON state = id
GROUP BY state, year ;

-- 12.2 Then, we determine the number of states in which that number is higher for each party

SELECT year, SIGN(dem - gop) AS "DemsWon", COUNT(*) 
FROM (
SELECT SUM(dem), SUM(gop), year
FROM ElectionResult JOIN County ON fips = county JOIN State ON state = id
GROUP BY state, year 
) GROUP BY year, SIGN(dem - gop); 
-- This fails because when subquery is used to dereive a table for FROM operator (as compared to used in for IN operator),  subquery needs to have a name / alias for itself, as if it is a table 

SELECT year, SIGN(SUM(dem) - SUM(gop)) AS "DemsWon", COUNT(*) 
FROM (
SELECT SUM(dem), SUM(gop), year
FROM ElectionResult JOIN County ON fips = county JOIN State ON state = id
GROUP BY state, year 
) AS s GROUP BY year, SIGN(SUM(dem) - SUM(gop)); 
-- This fails because the returned result from the subquery uses "SUM(dem)" and "SUM(gop)" as the column names, so in the outer query we have to make these as strings instead of being interpreted as aggregation functions

SELECT year, SIGN(`SUM(dem)` - `SUM(gop)`) AS "DemsWon", COUNT(*) 
FROM (
SELECT SUM(dem), SUM(gop), year
FROM ElectionResult JOIN County ON fips = county JOIN State ON state = id
GROUP BY state, year 
) AS s GROUP BY year, SIGN(`SUM(dem)` - `SUM(gop)`)
ORDER BY year, SIGN(`SUM(dem)` - `SUM(gop)`);
-- Yay! Alternatively you could use the renaming operator to rename the columns, which is better for readability anyways. 