-- Retrieve names of top 10 counties and 
-- their growth ratio in terms of population compared between the latest census year and the oldest census year, 
-- in an descending order by their growth ratio.

-- 1.05 marks: < 15 operators
-- 1.0 marks: < 17 operators
-- 0.9 marks: < 19 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT name, (t1.population/t2.population) as 'popGrowthRatio'
FROM  countyPopulation as t1 
    JOIN countyPopulation as t2 ON (t1.county = t2.county)
    JOIN county ON (t1.county = fips)
    JOIN state ON (state = id)
WHERE t1.year = 2019 AND  t2.year = 2010
ORDER by popGrowthRatio DESC LIMIT 10;
