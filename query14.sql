-- Retrieve the distinct abbreviations of states which have a county that does NOT have the 
-- "Management of companies and enterprises" industry 
-- and also the corresponding total number of counties in each state
-- in descending order of the number of distinct counties in each state, then in alphebatical order of the abbreviations.
-- Your query need to use the name "Management of companies and enterprises" to filter the tuples, instead of just the industry id as prior knowledge.

-- 1.05 marks: < 13 operators
-- 1.0 marks: < 15 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query


SELECT DISTINCT abbr,Count(*) as 'numCounties'
FROM  county 
      JOIN state ON (county.state= state.id)   
WHERE "Management of companies and enterprises" NOT IN (
       SELECT name 
       FROM countyindustries  
       JOIN industry ON industry = id
       WHERE county = fips)
GROUP BY abbr
ORDER by numCounties DESC, abbr ASC;
