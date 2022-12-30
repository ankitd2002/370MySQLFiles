-- Retrieve the top 5 industries 
-- in a decreasing order by number of employees, 
-- together with the corresponding number of employments 
-- and the average payroll. 

-- 1.05 marks: < 12 operators
-- 1.0 marks: < 14 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query

SELECT industry.name,SUM(employees) as 'totalEmployees',AVG(payroll) as 'avgPayroll'
FROM countyindustries JOIN county ON (county = fips)
    JOIN state ON (state = state.id)
    JOIN industry ON (industry = industry.id)
GROUP BY industry.name
ORDER by totalEmployees DESC, avgPayroll DESC limit 5;

