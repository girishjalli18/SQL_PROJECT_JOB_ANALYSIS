-- CREATE DATABASE sql_course;

-- DROP DATABASE IF EXISTS sql_course;

-- SELECT * FROM pg_stat_activity WHERE datname = 'sql_course';



-- SELECT pg_terminate_backend (pg_stat_activity.pid)
-- FROM pg_stat_activity
-- WHERE pg_stat_activity.datname = 'sql_course';


-- SELECT * 
-- FROM pg_stat_activity 
-- WHERE datname = 'sql_course';


-- SELECT job_posted_date 
-- FROM job_postings_fact
-- LIMIT 10;

-- SELECT 
--     job_title_short AS title,
--     job_location AS location,
--     job_posted_date::DATE AS date
-- FROM job_postings_fact;



-- SELECT 
--     job_title_short AS title,
--     job_location AS location,
--     job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
--     EXTRACT(MONTH FROM job_posted_date) AS date_month,
--     EXTRACT(YEAR FROM job_posted_date) AS date_year
-- FROM job_postings_fact LIMIT 5;


-- SELECT
--     COUNT(job_id),
--     EXTRACT(MONTH FROM job_posted_date) AS month
-- FROM job_postings_fact 
-- GROUP BY
--     month;



-- SELECT
--     COUNT(job_id) AS job_posted_count,
--     EXTRACT(MONTH FROM job_posted_date) AS month
    
-- FROM job_postings_fact 
--     WHERE job_title_short ='Data Analyst'
-- GROUP BY
--     month
-- ORDER BY
--     job_posted_count DESC;


-- SELECT 
--     AVG(salary_year_avg), 
--     AVG(salary_hour_avg)
    
-- FROM job_postings_fact
-- WHERE job_posted_date::DATE > DATE '2023-06-01
-- ' 
-- GROUP BY
--     job_schedule_type
-- LIMIT 50;

-- SELECT 
--     COUNT(job_id) AS job_count,
--     EXTRACT(MONTH FROM job_posted_date) AS month,
--     EXTRACT(YEAR FROM job_posted_date) AS year
-- FROM job_postings_fact
-- WHERE EXTRACT(YEAR FROM job_posted_date) = '2023'
-- GROUP BY
--     month, 
--     year
-- ORDER BY job_count DESC
-- LIMIT 10;


-- SELECT 
--     companies.name as company_name,
--    EXTRACT(QUARTER FROM job_postings.job_posted_date) AS quarter
-- FROM company_dim AS companies

-- LEFT JOIN job_postings_fact AS job_postings ON companies.company_id = job_postings.company_id AND
--     job_postings.job_health_insurance = true AND
--     EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2
-- WHERE job_posted_date IS NOT NULL
-- GROUP BY
--     company_name,
--     job_postings.job_posted_date
    
-- LIMIT 50;

-- SELECT 
--     COUNT(*),
--     job_title_short AS title
-- FROM job_postings_fact 
-- WHERE 
--     EXTRACT(MONTH FROM JOB_POSTED_DATE) =1 
-- GROUP BY
--     job_title_short
-- LIMIT 10;

-- CREATE TABLE january AS
--     SELECT * 
--     FROM job_postings_fact
--     WHERE EXTRACT( MONTH FROM  job_posted_date) =1


-- SELECT * FROM january LIMIT 10;

-- CREATE TABLE february AS
--     SELECT * 
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--     SELECT * FROM february LIMIT 10;

-- CREATE TABLE march AS
--     SELECT * 
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

    
--     SELECT * FROM march LIMIT 10;


-- SELECT 
--     job_title_short,
--     job_location,
--     CASE
--         WHEN job_location = 'Anywhere' THEN 'Remote'
--         WHEN job_location = 'New York, NY' THEN 'LOCAL'
--         ELSE 'Onsite'            
--     END AS location_category
-- FROM job_postings_fact;




-- SELECT 
--     COUNT(job_id),
--     CASE
--         WHEN job_location = 'Anywhere' THEN 'Remote'
--         WHEN job_location = 'New York, NY' THEN 'LOCAL'
--         ELSE 'Onsite'            
--     END AS location_category
-- FROM job_postings_fact
-- GROUP BY 
--     location_category;



-- SELECT 
--     COUNT(job_id),
--     CASE
--         WHEN job_location = 'Anywhere' THEN 'Remote'
--         WHEN job_location = 'New York, NY' THEN 'LOCAL'
--         ELSE 'Onsite'            
--     END AS location_category
-- FROM job_postings_fact
-- WHERE job_title_short ='Data Analyst'
-- GROUP BY 
--     location_category;



-- SELECT * 
-- FROM (
--     SELECT * 
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1



-- ) AS january_jobs LIMIT 10;

-- WITH january_jobs AS (
--     SELECT *
--     FROM 
--         job_postings_fact
--     WHERE 
--         EXTRACT(MONTH FROM job_posted_date) = 1
-- )

-- SELECT *
-- FROM
--     january_jobs;



-- SELECT 
--     company_id, 
--     name AS company_name
-- FROM company_dim
-- Where company_id IN (
--     SELECT 
--         company_id
--     FROM job_postings_fact
--     WHERE 
--         job_no_degree_mention = true
-- 




-- SELECT
--     company_id,
--     job_no_degree_mention
-- FROM 
--     job_postings_fact
-- WHERE 
--     job_no_degree_mention = true




-- WITH job_company_count AS (
--     SELECT 
--         company_id,
--         COUNT(*) AS total_jobs
--     FROM job_postings_fact
--     GROUP BY
--         company_id
-- )


-- SELECT 

--     company_dim.name AS company_name,
--     job_company_count.total_jobs

-- FROM company_dim 
-- LEFT JOIN job_company_count ON job_company_count.company_id = company_dim.company_id
-- ORDER BY
--     job_company_count.total_jobs
-- DESC


-- SELECT 
--     company_dim.name,
--     total_jobs
-- FROM (
--     SELECT
--         job_postings_fact.company_id,
--         COUNT(*) AS total_jobs
--     FROM
--         job_postings_fact
--     LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
--     GROUP BY
--         job_postings_fact.company_id
-- ) AS subquery_alias
-- LEFT JOIN company_dim ON company_dim.company_id = subquery_alias.company_id
-- ORDER BY
--     total_jobs
-- DESC


-- WITH skills_job_count AS (
-- SELECT
--     skills_job_dim.skill_id,
--     COUNT(job_postings_fact.job_id) as total_jobs
-- FROM
--     job_postings_fact 
--     LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
-- GROUP BY
--     skills_job_dim.skill_id
-- )

-- SELECT 
--     skills_dim.skill_id ,
--     skills_dim.skills,
--     skills_job_count.total_jobs
-- FROM skills_dim
-- LEFT JOIN skills_job_count ON skills_job_count.skill_id = skills_dim.skill_id
-- ORDER BY
--     skills_job_count.total_jobs
-- DESC
    


-- WITH remote_job_skills AS  (
-- SELECT 
--     skill_id,
--     COUNT(*) AS skill_count
-- FROM
--     skills_job_dim AS skills_to_job
-- INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
-- WHERE job_postings.job_work_from_home = true AND
-- job_postings.job_title_short='Data Engineer'
-- GROUP BY
--     skill_id
-- )

-- SELECT 
-- skills.skill_id, 
-- skills.skills,
-- skill_count
-- FROM remote_job_skills 
-- INNER JOIN skills_dim AS skills ON remote_job_skills.skill_id = skills.skill_id
-- ORDER BY
--     skill_count DESC
-- LIMIT 10


SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_hour_avg


FROM (
    SELECT
 * FROM 
    january AS january_jobs

UNION ALL

 SELECT
 * FROM 
     february AS february_jobs

UNION ALL

 SELECT
 * FROM 
    march AS march_jobs

) AS quarter1_job_postings;
    





