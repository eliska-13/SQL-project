
/* OTÁZKA 4:
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? */

/* Využívám pohledy 'avg_price' a 'avg_payroll_value' vytvořené v otázce 2.*/

CREATE VIEW avg_percent_change_price AS 
SELECT
	a.year
	, ROUND(AVG((a.avg_food_price - b.avg_food_price) / b.avg_food_price * 100), 2) AS percent_change_price
FROM avg_price AS a
JOIN avg_price AS b
	ON a.category_name = b.category_name 
	AND a.year = b.year + 1
GROUP BY a.year;


CREATE VIEW avg_percent_change_payroll AS 
SELECT
	a.year
	, ROUND(AVG((a.avg_payroll - b.avg_payroll) / b.avg_payroll * 100), 2) AS percent_change_payroll
FROM avg_payroll_value AS a
JOIN avg_payroll_value AS b
	ON a.branch_name = b.branch_name 
	AND a.year = b.year + 1
GROUP BY a.year;


SELECT
	price.`year`  
	, price.percent_change_price
	, payroll.percent_change_payroll
	, CASE
		WHEN (price.percent_change_price - payroll.percent_change_payroll) > 10 THEN 'větší než 10 %'
		ELSE 'menší než 10 %'
	END AS payroll_price_comparison
FROM avg_percent_change_price AS price
JOIN avg_percent_change_payroll AS payroll
	ON price.year = payroll.year
ORDER BY year ASC;
