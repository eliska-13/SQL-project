
/* OTÁZKA 2:
 * Kolik je možné si koupit litrů mléka a kilogramů chleba 
 * za první a poslední srovnatelné období v dostupných datech cen a mezd? */


CREATE VIEW avg_payroll_value AS
SELECT 
	year
	, branch_code
	, branch_name
	, ROUND(AVG(payroll_value)) AS avg_payroll
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year, branch_code, branch_name;


CREATE VIEW avg_price AS
SELECT 
	year
	, category_code
	, category_name
	, ROUND(AVG(category_value)) AS avg_food_price
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year, category_code, category_name;



SELECT 
	apv.year 
	, apv.branch_name
	, ap.category_name
	, FLOOR(apv.avg_payroll / ap.avg_food_price) AS quantity
FROM avg_payroll_value AS apv
JOIN avg_price AS ap
	ON apv.year = ap.year
WHERE apv.year IN (2006, 2018)
	AND (ap.category_name LIKE 'Mléko%' OR ap.category_name LIKE 'Chléb%')
GROUP BY apv.branch_name, ap.category_name, apv.year;



SELECT 
	apv.year
	, ap.category_name
    , ROUND(AVG(FLOOR(apv.avg_payroll / ap.avg_food_price))) AS average_quantity
FROM avg_payroll_value AS apv
JOIN avg_price AS ap
    ON apv.year = ap.year
WHERE apv.year IN (2006, 2018)
    AND (ap.category_name LIKE 'Mléko%' OR ap.category_name LIKE 'Chléb%')
 GROUP BY ap.category_name, apv.year;
    
   
   