-- Retrieve the years that exist in CensusYear but not in LabourSurvey. 
-- The ordering should be in the existing physical order of the data.

-- 1.05 marks: < 4 operators
-- 1.0 marks: < 5 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query


SELECT year
FROM CENSUSYEAR
WHERE year NOT IN (
        SELECT year
        FROM LABOURSURVEY
    )
ORDER BY year;