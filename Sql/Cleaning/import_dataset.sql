-- Import dataset into PostgreSQL

COPY ai_jobs_affected
FROM 'CDataSetsai_job_impact.csv'
DELIMITER ','
CSV HEADER;