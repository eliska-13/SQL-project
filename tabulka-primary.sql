
CREATE TABLE t_eliska_kerhartova_project_SQL_primary_final AS
SELECT payroll.payroll_year AS year
	, payroll.industry_branch_code AS branch_code 
	, branch.name AS branch_name
	, payroll.value AS payroll_value
	, price.category_code
	, category.name AS category_name
	, price.value AS category_value
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
	ON payroll.industry_branch_code = branch.code
JOIN czechia_payroll_value_type AS value_type
	ON payroll.value_type_code = value_type.code
	AND value_type.code = 5958
JOIN czechia_payroll_unit AS payroll_unit
	ON payroll.unit_code = payroll_unit.code
	AND payroll_unit.code = 200
JOIN czechia_payroll_calculation AS payroll_calc
	ON payroll.calculation_code = payroll_calc.code
	AND payroll_calc.code = 100;

