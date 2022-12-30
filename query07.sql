-- Retrieve counties that have the life expectancy more than the average value of all life expectancies, 
-- and also have the average income less than the avaerge of all average incomes, 
-- order by county names alphabetically, then by life expectancy increasingly.

-- 1.05 marks: < 11 operators
-- 1.0 marks: < 13 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query


SELECT name,life_expectancy,avg_income
FROM county 
WHERE life_expectancy >
(SELECT AVG(life_expectancy)
 FROM county)
AND avg_income <
(SELECT AVG(avg_income)
 FROM county)
ORDER BY name, life_expectancy asc;

