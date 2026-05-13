-- Change productivity column type

ALTER TABLE ai_jobs_affected
ALTER COLUMN productivity_change_percent TYPE NUMERIC;