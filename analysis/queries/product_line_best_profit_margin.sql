use [my_base]

-- which product line have the best profit margin --

WITH product_line_metrics AS (SELECT
	p.division AS product_line,
	COUNT(DISTINCT s.order_id) AS total_order,
	SUM(s.sales) AS total_revenue,
	SUM(s.units) AS units_sold,
	SUM(s.gross_profit) AS total_profit,
	ROUND((SUM(s.gross_profit) / SUM(s.sales)) * 100, 2) AS profit_margin_pct 
FROM gold.fact_sales s 
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.division
)
SELECT
product_line,
total_order,
total_revenue,
units_sold,
total_profit,
profit_margin_pct
FROM product_line_metrics
ORDER BY profit_margin_pct DESC, total_profit DESC;
