

-- create the factories table
IF OBJECT_ID('silver.factories', 'U') IS NOT NULL
DROP TABLE silver.factories;
GO 
CREATE TABLE silver.factories (
Factory			NVARCHAR(50),
Latitude		FLOAT,
Longitude		FLOAT,
dwh_create_date	DATETIME2 DEFAULT GETDATE());


-- create the products table
IF OBJECT_ID('silver.products', 'U') IS NOT NULL
DROP TABLE silver.products;
GO 
CREATE TABLE silver.products (
Division		NVARCHAR(50),
Product_Name	NVARCHAR(50),
Factory			NVARCHAR(50),
Product_ID		NVARCHAR(50),
Unit_Price		DECIMAL(8,2),
Unit_Cost		DECIMAL(8,2),
dwh_create_date	DATETIME2 DEFAULT GETDATE());


-- create the sales table
IF OBJECT_ID('silver.sales', 'U') IS NOT NULL
DROP TABLE silver.sales;
GO 
CREATE TABLE silver.sales (
Row_ID			INT,
Order_ID		NVARCHAR(50),
Order_Date		DATE,
Ship_Date		DATE,
Ship_Mode		NVARCHAR(50),
Customer_ID		INT,
Country			NVARCHAR(50),
City			NVARCHAR(50),
State_Province	NVARCHAR(50),
Postal_Code		NVARCHAR(50),
Division		NVARCHAR(50),
Region			NVARCHAR(50),
Product_ID		NVARCHAR(50),
Product_Name	NVARCHAR(50),
Sales			DECIMAL(8,2),
Units			INT,
Gross_Profit	DECIMAL(8,2),
Cost			DECIMAL(8,2),
dwh_create_date	DATETIME2 DEFAULT GETDATE());


-- create the targets table 
IF OBJECT_ID('silver.targets', 'U') IS NOT NULL
DROP TABLE silver.targets;
GO 
CREATE TABLE silver.targets (
Division		NVARCHAR(50),
Target			INT,
dwh_create_date	DATETIME2 DEFAULT GETDATE());


-- create the uszips table
IF OBJECT_ID('silver.uszips', 'U') IS NOT NULL
DROP TABLE silver.uszips;
GO 
CREATE TABLE silver.uszips (
zip					NVARCHAR(50),
lat					FLOAT,
lng					FLOAT,
city				NVARCHAR(50),
state_id			NVARCHAR(50),
state_name			NVARCHAR(50),
zcta				NVARCHAR(50),
parent_zcta			NVARCHAR(50),
population			INT,
density				FLOAT,
country_fips		INT,
country_name		NVARCHAR(50),
country_weights		NVARCHAR(100),
country_names_all	NVARCHAR(100),
country_fips_all	NVARCHAR(100),
imprecise			NVARCHAR(50),
military			NVARCHAR(50),
timezone			NVARCHAR(50),
dwh_create_date		DATETIME2 DEFAULT GETDATE());

 