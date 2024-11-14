
/* OTÁZKA 3:
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? */

/* využívám pohled z otázky 2:
CREATE VIEW avg_price AS
SELECT 
	year
	, category_code
	, category_name
	, ROUND(AVG(category_value)) AS avg_food_price
FROM t_eliska_kerhartova_project_sql_primary_final AS tekpspf 
GROUP BY year, category_code, category_name;
*/

SELECT
	a.category_name
	, ROUND(AVG((a.avg_food_price - b.avg_food_price) / b.avg_food_price * 100), 2) AS avg_percent_change
FROM avg_price AS a
JOIN avg_price AS b
	ON a.category_name = b.category_name 
	AND a.year = b.year + 1
GROUP BY a.category_name
ORDER BY avg_percent_change ASC
LIMIT 1;


