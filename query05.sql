-- Retrieve the list of abbreviations of states that have
-- a total precipitation of more than 1000 for each state,
-- ordered by the total precipitation in descending order.

-- 1.05 marks: < 7 operators
-- 1.0 marks: < 8 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT abbr, SUM(precip) as total
FROM state JOIN county ON (state = id)
GROUP by abbr
HAVING total > 1000
ORDER BY total desc;