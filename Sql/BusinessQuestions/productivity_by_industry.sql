-- Analyze productivity increase by industry

SELECT 
    j.industry,
    AVG(productivity_change_percent) AS produtividade
FROM job_info j
JOIN ai_impact a 
    ON j.employee_id = a.employee_id
GROUP BY j.industry
ORDER BY produtividade DESC;