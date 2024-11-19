
/* OTÁZKA 2:
 * Kolik je možné si koupit litrů mléka a kilogramů chleba 
 * za první a poslední srovnatelné období v dostupných datech cen a mezd? */

CREATE VIEW avg_payroll_value AS
SELECT 
	year
	, branch_name
	, ROUND(AVG(payroll_value)) AS avg_payroll
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year, branch_name;


CREATE VIEW avg_price AS
SELECT 
	year
	, category_name
	, ROUND(AVG(category_value)) AS avg_food_price
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year, category_name;



SELECT 
	avg_payroll.year 
	, avg_payroll.branch_name
	, avg_price.category_name
	, FLOOR(avg_payroll.avg_payroll / avg_price.avg_food_price) AS quantity
FROM avg_payroll_value AS avg_payroll
JOIN avg_price
	ON avg_payroll.year = avg_price.year
WHERE avg_payroll.year IN (2006, 2018)
	AND (avg_price.category_name LIKE 'Mléko%' 
		OR avg_price.category_name LIKE 'Chléb%')
GROUP BY avg_payroll.branch_name, avg_price.category_name, avg_payroll.year;



SELECT 
	avg_payroll.year
	, avg_price.category_name
	, ROUND(AVG(FLOOR(avg_payroll.avg_payroll / avg_price.avg_food_price))) AS average_quantity
FROM avg_payroll_value AS avg_payroll
JOIN avg_price
	ON avg_payroll.year = avg_price.year
WHERE avg_payroll.year IN (2006, 2018)
	AND (avg_price.category_name LIKE 'Mléko%' 
		OR avg_price.category_name LIKE 'Chléb%')
GROUP BY avg_price.category_name, avg_payroll.year;
    
   
   
