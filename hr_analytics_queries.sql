SELECT
    SUM(employee_count) AS employee_count,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(
        (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END)::NUMERIC / SUM(employee_count)) * 100,
        2
    ) AS attrition_rate_pct,
    SUM(employee_count) - COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS active_employees,
    ROUND(AVG(age), 0) AS average_age
FROM hrdata;

SELECT
    gender,
    COUNT(attrition) AS attrition_count,
    ROUND(
        (COUNT(attrition)::NUMERIC / (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')) * 100,
        2
    ) AS pct_of_total_attrition
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY gender
ORDER BY attrition_count DESC;

SELECT
    department,
    COUNT(attrition) AS attrition_count,
    ROUND(
        (COUNT(attrition)::NUMERIC / (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')) * 100,
        2
    ) AS pct_of_total_attrition
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;

SELECT
    age_band,
    SUM(employee_count) AS employee_count
FROM hrdata
GROUP BY age_band
ORDER BY age_band;

SELECT
    education_field,
    COUNT(attrition) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY attrition_count DESC;

SELECT
    age_band,
    gender,
    COUNT(attrition) AS attrition_count,
    ROUND(
        (COUNT(attrition)::NUMERIC / (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')) * 100,
        2
    ) AS pct_of_total_attrition
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;

SELECT
    job_role,
    SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS rating_1,
    SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS rating_2,
    SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS rating_3,
    SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS rating_4,
    SUM(employee_count) AS total_employees
FROM hrdata
GROUP BY job_role
ORDER BY job_role;