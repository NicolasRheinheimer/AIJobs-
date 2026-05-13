-- Analyze productivity growth according to years of experience

SELECT 
    j.years_experience,
    AVG(a.productivity_change_percent) AS produtividade
FROM job_info j
JOIN ai_impact a 
    ON j.employee_id = a.employee_id
GROUP BY j.years_experience
ORDER BY j.years_experience;