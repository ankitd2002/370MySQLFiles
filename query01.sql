-- Retrieve the abbreviations of states that have over 150 counties 
-- which have an employment rate of at least 90% for each county in 2008, 
-- ordered by the number of counties in each state in descending order.

-- 1.05 marks: <8 operators
-- 1.0 marks: <10 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT abbr
FROM countyLabourStats 
     JOIN county ON (county = fips) 
     JOIN state ON (state = id)
WHERE year = 2008
      AND  employed / labour_force > .9
GROUP BY id
HAVING COUNT(county.state) >= 150
ORDER BY COUNT(county.state) desc;
