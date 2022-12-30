-- Retrieve the list of counties sorted by the ratio 
-- between male and female population for each county 
-- in descending order or the aforementioned ratio, and then in the ascending order of county FIP.
-- Exclude tuples with ratio of 1:1 from returned result.

-- 1.05 marks: < 7 operators
-- 1.0 marks: < 8 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT countyPopulation.county, SUM(IF(genderbreakdown.gender = 'male', genderbreakdown.population,0))/SUM(IF(genderbreakdown.gender= 'female', genderbreakdown.population,0)) as 'ratio'
FROM CountyPopulation JOIN counties.genderbreakdown ON (countyPopulation.county = genderbreakdown.county)
GROUP BY countyPopulation.county
HAVING ratio <> 1
ORDER by ratio desc, countyPopulation.county asc;

