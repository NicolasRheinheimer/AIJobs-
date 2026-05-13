-- Create main table for AI job impact dataset

CREATE TABLE ai_jobs_affected (
    employee_id TEXT,
    age INT,
    gender TEXT,
    education_level TEXT,
    industry TEXT,
    job_role TEXT,
    years_experience INT,
    ai_adoption_level TEXT,
    automation_risk TEXT,
    upskilling_required TEXT,
    salary_before_ai INT,
    salary_after_ai INT,
    job_status TEXT,
    work_hours_per_week INT,
    remote_work TEXT,
    job_satisfaction INT,
    productivity_change_percent INT
);