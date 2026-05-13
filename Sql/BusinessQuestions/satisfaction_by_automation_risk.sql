-- Analyze employee satisfaction according to automation risk

SELECT 
    automation_risk,
    AVG(job_satisfaction) AS satisfacao
FROM ai_impact
GROUP BY automation_risk;