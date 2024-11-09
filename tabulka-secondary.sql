
CREATE TABLE t_eliska_kerhartova_project_SQL_secondary_final AS
SELECT c.country
	, c.capital_city
	, c.continent
	, c.population
	, c.surface_area
	, e.year
	, e.GDP
FROM countries AS c 
JOIN economies AS e 
	ON e.country = c.country;