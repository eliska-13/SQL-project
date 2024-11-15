
/* OTÁZKA 5:
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to 
 * na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?*/

/* Využívám pohledy 'avg_percent_change_price' a 'avg_percent_change_payroll' vytvořené v otázce 4.*/

CREATE VIEW avg_yearly_gdp AS
SELECT
	year
	, ROUND(AVG(GDP),2) AS avg_gdp
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year;

CREATE VIEW avg_percent_change_gdp AS 
SELECT
	a.year
	, ROUND(AVG((a.avg_gdp - b.avg_gdp) / b.avg_gdp * 100), 2) AS percent_change_gdp
FROM avg_yearly_gdp AS a
JOIN avg_yearly_gdp AS b
	ON a.year = b.year + 1
GROUP BY a.year;


-- za výraznější nárůst HDP v ČR bereme v potaz více než 5 %

SELECT 
	gdp.year AS gdp_year
	, gdp.percent_change_gdp
	, price_same_year.percent_change_price
	, payroll_same_year.percent_change_payroll
	, CASE 
		WHEN price_same_year.percent_change_price > 5 THEN 'Ceny potravin vzrostly o více než 5 %'
		WHEN price_same_year.percent_change_price BETWEEN 0 AND 5 THEN 'Ceny potravin vzrostly do 5 %'
		ELSE 'Ceny potravin klesly'
	END AS price_change_same_year
	, CASE 
		WHEN payroll_same_year.percent_change_payroll > 5 THEN 'Mzdy vzrostly o více než 5 %'
		WHEN payroll_same_year.percent_change_payroll BETWEEN 0 AND 5 THEN 'Mzdy vzrostly do 5 %'
		ELSE 'Mzdy klesly'
	END AS payroll_change_same_year
	, CASE 
		WHEN price_next_year.percent_change_price > 5 THEN 'Ceny potravin vzrostly o více než 5 %'
		WHEN price_next_year.percent_change_price BETWEEN 0 AND 5 THEN 'Ceny potravin vzrostly do 5 %'
		ELSE 'Ceny potravin klesly'
	END AS price_change_next_year
	, CASE 
		WHEN payroll_next_year.percent_change_payroll > 5 THEN 'Mzdy vzrostly o více než 5 %'
		WHEN payroll_next_year.percent_change_payroll BETWEEN 0 AND 5 THEN 'Mzdy vzrostly do 5 %'
		ELSE 'Mzdy klesly'
	END AS payroll_change_next_year
FROM avg_percent_change_gdp AS gdp
JOIN avg_percent_change_price AS price_same_year
	ON gdp.year = price_same_year.year
JOIN avg_percent_change_payroll AS payroll_same_year
	ON gdp.year = payroll_same_year.year
JOIN avg_percent_change_price AS price_next_year
	ON gdp.year + 1 = price_next_year.year
JOIN avg_percent_change_payroll AS payroll_next_year
	ON gdp.year + 1 = payroll_next_year.year
WHERE gdp.percent_change_gdp > 5;	
