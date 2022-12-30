-------------------------------
-- CSC 370 Fall 2022 Lecture
-- Aggregation and Equivalent classes
-- Oct 20 2022
-- Instructor: Yichun Zhao
-------------------------------

--> Given the County dataset

-- brief overview of the db ( in today's lecture, we will focus on 'County', 'CountyPopulation', and 'ElectionResult' tables )


--> 1. Simple (bag) projection query to retrieve the population information for each year



--> 2. Set projection query



--> 3. Group by query with same effect with the equivalence classes 

-- what are equivalent classes?


--> 4. With simple aggregation: count number of tuples in each group / equivalence class

-- what is aggregation? 


--> 5. Apply a function to all tuples in each group: sum the population for each year



--> 6. Try to include attribute(s) that is/are not used for "GROUP BY": 'county'

-- what is the condition for attributes to be successfully projected when there are equivalent classes? 
-- what is the simplest way for us to include such attributes to make our query to be execited successfully? 


--> 7. More meaningfully, retrieve the total population for each state 

-- now, instead of the attribute 'state' in table 'county', involve attribute 'abbr' in table 'state'. why does this work? 


--> 8. Retrieve only the tuples with year more than 2015
SELECT year,state,SUM(population)
FROM CountyPopulation JOIN county ON (county = fips) JOIN state ON  (state =id)
WHERE year > 2015
GROUP BY year,state;


--> 9. Retrieve only the equivalent classes with population sum more than 1000000

-- note the difference between WHERE and HAVING


--> 10. Now, we involve the table 'ElectionResult' to check out election information. Who won the votes each year? 

--> 11. Retrieve the number of counties won by each party ( by grouping on a computed field using SIGN() function )

-- how to make our query result more readable?


-- 12. Retrieve the number of states won by each party per year

-- 12.1 First, we determine the number of votes per state per year
-- 12.2 Then, we determine the number of states in which that number is higher for each party


