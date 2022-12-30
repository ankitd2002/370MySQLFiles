-- Retrieve the list of states (showing both the id and abbreviation) 
-- and their corresponding total area, 
-- not accounting for the counties that have more than 10000 population in the year of 2010, 
-- sorted by area in descending order.

-- 1.05 marks: < 11 operators
-- 1.0 marks: < 13 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT id,abbr,SUM(sq_km) as area
FROM  CountyPopulation JOIN county ON (county = fips)
      JOIN state ON (state = id)
WHERE CountyPopulation.population <= 10000 AND CountyPopulation.year = 2010
GROUP BY county.state
ORDER BY area desc;


