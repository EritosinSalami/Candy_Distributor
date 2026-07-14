/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/



-- ====================================================================
-- Checking 'silver.factories'
-- ====================================================================
-- check for duplicates or nulls in primary key
-- Expectation: No Results
SELECT 
Factory,
COUNT(*)
FROM silver.factories
GROUP BY Factory
HAVING COUNT(*) > 1 or Factory IS NULL

-- check for unwanted spaces 
-- Expectation: No Results
SELECT 
Factory 
FROM silver.factories
WHERE Factory != TRIM(Factory)


-- check for nulls in coordinates
-- Expectation: No Results
SELECT
Latitude
FROM silver.factories
WHERE Latitude IS NULL

SELECT
Longitude
FROM silver.factories
WHERE Latitude IS NULL


-- ====================================================================
-- Checking 'silver.products'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
Product_ID,
COUNT(*)
FROM silver.products
GROUP BY Product_ID
HAVING COUNT(*) > 1 or Product_ID IS NULL

-- check for unwanted spaces 
-- Expectation: No Results
SELECT 
Division 
FROM silver.products
WHERE Division != TRIM(Division);

SELECT 
Factory 
FROM silver.products
WHERE Factory != TRIM(Factory);

SELECT 
Product_ID 
FROM silver.products
WHERE Product_ID != TRIM(Product_ID);

-- check for nulls or negative values in unit_price and unit_cost
-- Expectation: No Results
SELECT 
Unit_Price
FROM silver.products
WHERE Unit_Price < 0 OR Unit_Price IS NULL;

SELECT 
Unit_Cost
FROM silver.products
WHERE Unit_Cost < 0 OR Unit_Cost IS NULL;


-- ====================================================================
-- Checking 'silver.sales'
-- ====================================================================
-- check for duplicates or nulls in primary key
-- Expectation: No Results
SELECT 
Row_ID,
COUNT(*)
FROM silver.sales
GROUP BY Row_ID
HAVING COUNT(*) > 1 or Row_ID IS NULL

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT  
Order_Date
FROM silver.sales
WHERE Order_Date IS NULL OR Order_Date > Ship_Date

-- check for nulls
-- Expectation: No Results
SELECT  
Customer_ID
FROM silver.sales
WHERE Customer_ID IS NULL 

SELECT  
Postal_Code
FROM silver.sales
WHERE Postal_Code IS NULL

SELECT  
Ship_Date
FROM silver.sales
WHERE Ship_Date IS NULL 

-- check for unwanted spaces 
-- Expectation: No Results
SELECT 
DISTINCT Ship_Mode 
FROM silver.sales
WHERE Ship_Mode != TRIM(Ship_Mode);

SELECT 
DISTINCT Country 
FROM silver.sales
WHERE Country != TRIM(Country);

SELECT 
DISTINCT City 
FROM silver.sales
WHERE City != TRIM(City);

SELECT 
DISTINCT State_Province 
FROM silver.sales
WHERE State_Province != TRIM(State_Province);

SELECT 
DISTINCT Division 
FROM silver.sales
WHERE Division != TRIM(Division);

SELECT 
DISTINCT Region 
FROM silver.sales
WHERE Region != TRIM(Region);

SELECT 
DISTINCT Product_ID 
FROM silver.sales
WHERE Product_ID != TRIM(Product_ID);

SELECT 
DISTINCT Product_Name 
FROM silver.sales
WHERE Product_Name != TRIM(Product_Name);


-- check for nulls or negative values in sales, units, unit_price, cost and gross_profit
-- Expectation: No Results
SELECT DISTINCT 
s.Sales,
s.Units,
s.Cost,
s.Gross_Profit,
p.Unit_Price
FROM silver.sales s
LEFT JOIN silver.products p
ON s.Product_ID = p.Product_ID
WHERE Sales != (s.Units * p.Unit_Price)
OR Gross_Profit != (Sales - Cost) 
OR Gross_Profit <= 0 OR Gross_Profit IS NULL
OR Sales IS NULL OR Units IS NULL OR Cost IS NULL OR Unit_Price IS NULL
OR Sales <= 0 OR Units <= 0 OR Cost <= 0 OR Unit_Price <= 0;



-- ====================================================================
-- Checking 'silver.targets'
-- ====================================================================
-- Check for NULLs or Duplicates in division
-- Expectation: No Results
SELECT 
Division,
COUNT(*)
FROM silver.targets
GROUP BY Division
HAVING COUNT(*) > 1 or Division IS NULL

-- check for unwanted spaces 
-- Expectation: No Results
SELECT 
Division 
FROM silver.targets
WHERE Division != TRIM(Division);

-- check for nulls or negative values in target
-- Expectation: No Results
SELECT 
Target
FROM silver.targets
WHERE Target < 0 OR Target IS NULL;


-- ====================================================================
-- Checking 'silver.uszips'
-- ====================================================================
-- Data Standardization & Consistency
SELECT 
DISTINCT 
city
FROM silver.uszips
ORDER BY city;

SELECT 
DISTINCT 
parent_zcta
FROM silver.uszips;

-- check for duplicates or nulls pk
SELECT 
zip,
COUNT(*)
FROM silver.uszips
GROUP BY zip
HAVING COUNT(*) > 1 or zip IS NULL;

-- check for unmated spaces 
SELECT
country_name,
country_weights,
country_names_all
FROM silver.uszips
WHERE country_name != TRIM(country_name)
OR country_weights != TRIM(country_weights)
OR country_names_all != TRIM(country_names_all);

SELECT 
DISTINCT 
city,
state_id,
state_name,
zcta
FROM silver.uszips
WHERE city != TRIM(city)
OR state_id != TRIM(state_id)
OR state_name != TRIM(state_name)
OR zcta != TRIM(zcta);
