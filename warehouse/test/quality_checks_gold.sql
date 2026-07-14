


-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================
-- Check for Uniqueness of product id in gold.dim_produts
-- Expectation: No results 

SELECT
product_key,
COUNT(*) AS duplicates
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions

SELECT
*
FROM gold.fact_sales gs
LEFT JOIN gold.dim_products gp
ON gs.product_key = gp.product_key
LEFT JOIN gold.dim_location gl
ON gs.customer_id = gl.customer_id
WHERE  gp.product_key IS NULL OR gs.customer_id IS NULL;



