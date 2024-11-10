
/* OTÁZKA 1:
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? */

SELECT *
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf;

SELECT branch_code
	, branch_name
	, MIN(year) AS min_year
	, MAX(year)  AS max_year
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY branch_code, branch_name;



CREATE VIEW ek_payroll_comparison AS
SELECT
	a.branch_code
	, a.branch_name
	, a.year AS current_year
	, AVG(a.payroll_value) AS current_payroll_value
	, b.year AS previous_year
	, AVG(b.payroll_value) AS previous_payroll_value
FROM t_eliska_kerhartova_project_sql_primary_final AS a
JOIN t_eliska_kerhartova_project_sql_primary_final AS b
	ON a.branch_code = b.branch_code
	AND a.year = b.year + 1
GROUP BY a.branch_code, a.branch_name, a.year, b.year;



SELECT
	current_year
	, branch_code
	, branch_name
	, CASE 
		WHEN current_payroll_value > previous_payroll_value THEN 'mzdy rostou'
		WHEN current_payroll_value = previous_payroll_value THEN 'mzdy stagnují'
		WHEN current_payroll_value < previous_payroll_value THEN 'mzdy klesají'
	END AS payroll_trend
FROM ek_payroll_comparison
WHERE current_year = 2018;


-- dlouho se načítá, zkusit jinak
