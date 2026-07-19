use [my_base]

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID ('gold.dim_products', 'V') IS NOT NULL
DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER () OVER (ORDER BY product_id, product_name) AS product_key,
	p.Product_ID AS product_id,
	p.Product_Name AS product_name,
	p.Division AS division,
	p.Unit_Price AS unit_price,
	p.Unit_Cost AS unit_cost,
	t.Target AS target,
	f.Factory AS factory,
	f.Latitude AS latitude,
	f.Longitude AS longitude
FROM silver.products p
LEFT JOIN silver.factories f
ON p.Factory = f.Factory
LEFT JOIN silver.targets t
ON p.Division = t.Division
WHERE Product_ID IS NOT NULL;
GO


-- =============================================================================
-- Create Dimension: gold.fact_sales
-- =============================================================================
IF OBJECT_ID ('gold.fact_sales', 'V') IS NOT NULL
DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT
	s.Order_ID AS order_id,
	s.Customer_ID AS customer_id,
	s.Order_Date AS order_date,
	s.Ship_Date AS ship_date,
	s.Ship_Mode AS ship_mode,
	s.City AS city,
	s.Region AS region,
	s.State_Province AS state_name,
	pr.product_key,
	s.Sales AS sales,
	s.Units AS units,
	s.Gross_Profit AS gross_profit,
	s.Cost AS cost
FROM silver.sales s
LEFT JOIN gold.dim_products pr
ON s.Product_ID = pr.Product_ID
WHERE pr.product_key IS NOT NULL 
AND s.order_id IS NOT NULL;
GO


-- =============================================================================
-- Create Dimension: gold.dim_location
-- =============================================================================

IF OBJECT_ID ('gold.dim_location', 'V') IS NOT NULL
DROP VIEW gold.dim_location;
GO
CREATE VIEW gold.dim_location AS
SELECT * FROM (
SELECT 
	ROW_NUMBER () OVER (PARTITION BY s.Customer_ID ORDER BY u.zip) AS rn,
	u.zip AS zip,
	s.Customer_ID AS customer_id,
	u.lat AS latitude,
	u.lng AS longitude,
	u.city AS city,
	u.state_name AS state_name,
	u.zcta AS zcta,
	u.population AS population,
	u.density AS density,
	u.country_fips AS country_fips,
	u.country_name AS country_name,
	s.region AS region,
	s.country AS country,
	u.imprecise AS imprecise,
	u.military AS military,
	u.timezone AS timezone
FROM silver.uszips u
LEFT JOIN silver.sales s
ON u.zip = s.Postal_Code
WHERE s.Customer_ID IS NOT NULL
AND u.zip IS NOT NULL)t
WHERE rn = 1;
GO



