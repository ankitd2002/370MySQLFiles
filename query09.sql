-- Out of those counties with temperature of more than 60, 
-- retrieve the pair that had the largest absolute difference in temperature
-- and their corresponding temperatures.
-- The second county in the pair has a temperature larger than the first county's temperature. 
-- If multiple pairs exist, retrieve the pair with the smallest FIP of the first county in the pair.


-- 1.05 marks: < 10 operators
-- 1.0 marks: < 12 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT t1.name,t1.temp,t2.name,t2.temp
FROM county as t1 INNER JOIN county as t2
WHERE t1.temp > 60
    AND t2.temp > t1.temp
ORDER BY Abs(t1.temp - t2.temp)DESC,t1.fips ASC limit 1;

