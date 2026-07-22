use [my_base]

-- what is the most efficient factory to customer shipping route --

WITH route_metrics AS (SELECT
	p.factory AS factory,
	s.region AS customer_region,
	s.city AS customer_city,
	COUNT(s.order_id) AS order_volume,
	SUM(s.units) AS units_ordered,
	SUM(s.gross_profit) AS total_profit,
	ROUND(SUM(s.gross_profit) / SUM(s.units), 2) AS avg_profit_per_unit,
	ROUND((SUM(s.gross_profit) / SUM(s.units)) * SQRT (COUNT(DISTINCT s.order_id)), 2) AS weighted_score
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.factory, s.region, s.city
)
SELECT 
	TOP 10
	factory,
	customer_region,
	customer_city,
	order_volume,
	units_ordered,
	total_profit,
	avg_profit_per_unit
FROM route_metrics
ORDER BY weighted_score DESC;



-- what is the least efficient factory to customer shipping route --

WITH route_metrics AS (SELECT
	p.factory AS factory,
	s.region AS customer_region,
	s.city AS customer_city,
	COUNT(s.order_id) AS order_volume,
	SUM(s.units) AS units_sold,
	SUM(s.gross_profit) AS total_profit,
	ROUND(SUM(s.gross_profit) / SUM(s.units), 2) AS avg_profit_per_unit,
	ROUND((SUM(s.gross_profit) / SUM(s.units)) * SQRT (COUNT(DISTINCT s.order_id)), 2) AS weighted_score
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.factory, s.region, s.city
)
SELECT
	TOP 10
	factory,
	customer_region,
	customer_city,
	order_volume,
	units_sold,
	total_profit,
	avg_profit_per_unit
FROM route_metrics
ORDER BY weighted_score;
