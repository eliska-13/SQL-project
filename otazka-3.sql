
/* OTÁZKA 3:
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? */

/* Využívám pohled 'avg_price' vytvořený v otázce 2.*/

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


