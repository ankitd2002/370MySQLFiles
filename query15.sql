-- Retrieve abbreviations for the states which contain at least 5 counties, 
-- and their population in year 2010 to area ratio 
-- in decreasing order of the aforementioned ratio. 
-- Round the ratio to 2 decimal places.

-- 1.05 marks: < 17 operators
-- 1.0 marks: < 19 operators
-- 0.9 marks: < 21 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT abbr,ROUND(sum(countyPopulation.population)/sum(county.sq_km),2) as 'popPerSqKm'
FROM county
     JOIN state ON (state = id)
     JOIN countyPopulation ON (county.fips = countyPopulation.county)
WHERE countyPopulation.year = 2010
GROUP BY state.abbr
HAVING COUNT(county.state)>= 5
ORDER BY popPerSqKm DESC;
