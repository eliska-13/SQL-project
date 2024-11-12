
/* OTÁZKA 1:
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? */


CREATE TEMPORARY TABLE ek_temporary_payroll_comparison AS
SELECT
	branch_code
	, branch_name
	, year 
	, AVG(payroll_value) AS avg_payroll
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf
GROUP BY branch_code, branch_name, year;


SELECT
	a.branch_code
	, a.branch_name
	, a.year AS current_year
	, a.avg_payroll AS current_payroll_value
	, b.year AS previous_year
	, b.avg_payroll AS previous_payroll_value
	, CASE
		WHEN a.avg_payroll > b.avg_payroll THEN 'mzdy rostou'
		WHEN a.avg_payroll = b.avg_payroll THEN 'mzdy stagnují'
		WHEN a.avg_payroll < b.avg_payroll THEN 'mzdy klesají'
	END AS payroll_trend
FROM ek_temporary_payroll_comparison AS a
JOIN ek_temporary_payroll_comparison AS b
	ON a.branch_code = b.branch_code
	AND a.year = b.year + 1;




	