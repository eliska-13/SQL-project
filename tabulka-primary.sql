SELECT payroll_year 
FROM czechia_payroll AS payroll;

SELECT date_from 
FROM czechia_price AS price;

SELECT year 
FROM economies AS eco;


CREATE TABLE t_eliska_kerhartova_project_SQL_primary_final AS
SELECT payroll.payroll_year
	, payroll.industry_branch_code 
	, branch.name AS branch_name
	, payroll.value AS payroll_value
	, YEAR(price.date_from) AS price_year
	, price.category_code
	, category.name AS category_name
	, price.value AS price_value
	, eco.year AS eco_year 
	, eco.country
	, eco.GDP
FROM czechia_payroll AS payroll
JOIN czechia_price AS price 
	ON payroll.payroll_year = YEAR(price.date_from)
JOIN czechia_price_category AS category 
	ON price.category_code = category.code 
JOIN economies AS eco 
	ON payroll.payroll_year = eco.YEAR
	AND eco.country = 'Czech Republic'
JOIN czechia_payroll_industry_branch AS branch
	ON payroll.industry_branch_code = branch.code;


SELECT *
FROM t_eliska_kerhartova_project_SQL_primary_final;