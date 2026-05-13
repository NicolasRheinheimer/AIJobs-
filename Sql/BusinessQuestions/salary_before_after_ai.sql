-- Compare salaries before and after AI adoption

SELECT 
    AVG(salary_before_ai) AS antes,
    AVG(salary_after_ai) AS depois
FROM ai_impact;