use [my_base]

-- which product line should be moved to a different factory to optimize profitability --

WITH factory_performance AS (
	-- metrics for every factory-product_line combination
	SELECT
	p.division AS product_line,
	p.factory AS factory,
	COUNT(DISTINCT s.order_id) AS total_order,
	SUM(s.sales) AS total_revenue,
	SUM(s.units) AS units_sold,
	SUM(s.gross_profit) AS total_profit,
	ROUND((SUM(s.gross_profit) / SUM(s.units)), 2) AS avg_profit_per_unit,
	ROUND((SUM(s.gross_profit) / SUM(s.units)) * SQRT (COUNT(DISTINCT s.order_id)), 2) AS weighted_score
FROM gold.fact_sales s 
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.division, p.factory
),
ranked_factories AS (
	-- Rank within each product line using weighted_score (highest = rank 1)
	SELECT
	product_line,
	factory,
	total_order,
	total_revenue,
	units_sold,
	total_profit,
	avg_profit_per_unit,
	weighted_score,
	RANK () OVER (PARTITION BY product_line ORDER BY weighted_score DESC) AS weighted_rank
FROM factory_performance
),
best_factory AS (
	-- Get the best factory for each product line (based on weighted score)
	SELECT 
	product_line,
	factory AS best_factory,
	total_order AS best_total_order,
	total_revenue AS best_total_revenue ,
	units_sold AS best_units_sold,
	total_profit AS best_total_profit,
	avg_profit_per_unit AS best_avg_profit_per_unit,
	weighted_score AS best_weighted_score
FROM ranked_factories
WHERE weighted_rank = 1
),
curent_factory_lookup AS (
	-- xtract the current factory for each product line from the product dimension
	SELECT DISTINCT
	division AS product_line,
	factory AS current_factory
FROM gold.dim_products
),
final_recommendation AS (
	-- join everything together
	SELECT
		c.product_line AS product_line,
		c.current_factory AS current_factory,
		b.best_factory AS recommended_factory,
		rf.total_profit AS current_total_profit,
		rf.avg_profit_per_unit AS current_avg_profit_per_unit,
		rf.total_order AS current_order_volume,
		rf.weighted_score AS current_weighted_score,
		b.best_total_profit AS recommended_total_profit,
		b.best_avg_profit_per_unit AS recommended_avg_profit_per_unit,
		b.best_total_order AS recommended_order_volume,
		b.best_weighted_score AS best_weighted_score,
		ROUND(b.best_avg_profit_per_unit - rf.avg_profit_per_unit, 2) AS profit_gap_per_unit,
		ROUND(b.best_weighted_score - rf.weighted_score, 2) AS weighted_score_gap,
    
		CASE   
			WHEN ROUND(b.best_weighted_score - rf.weighted_score, 2) > 40.0 
			THEN 'Move to ' + UPPER(b.best_factory)
			WHEN ROUND(b.best_weighted_score - rf.weighted_score, 2) < 20.0 
			THEN 'Move to ' + UPPER(b.best_factory)
			ELSE 'No Action Needed'
		END AS recommendation
FROM curent_factory_lookup c
JOIN best_factory b 
ON c.product_line = b.product_line
JOIN ranked_factories rf
ON c.product_line = rf.product_line
AND c.current_factory = rf.factory
WHERE c.current_factory != b.best_factory 
)
SELECT
	product_line,
	current_factory,
    current_avg_profit_per_unit,
    current_order_volume,
    current_weighted_score,
    best_weighted_score,
	weighted_score_gap,
	recommended_factory,
    recommendation
FROM 
final_recommendation
ORDER BY best_weighted_score DESC;

