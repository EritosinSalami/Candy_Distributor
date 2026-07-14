
EXEC silver.load_silver;

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.factories';
        TRUNCATE TABLE silver.factories;

        PRINT '>> Inserting data into table: silver.factories';
        INSERT INTO silver.factories (
            Factory,
            Latitude,
            Longitude)
            SELECT 
            TRIM(Factory) AS Factory,
            Latitude,
            Longitude
            FROM bronze.factories;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.products';
        TRUNCATE TABLE silver.products;

        PRINT '>> Inserting data into table: silver.products';
        INSERT INTO silver.products (
            Division,
            Product_Name,
            Factory,
            Product_ID,
            Unit_Price,
            Unit_Cost)
            SELECT 
            TRIM(Division) AS Division,
            TRIM(Product_Name) AS Product_Name,
            TRIM(Factory) AS Factory,
            TRIM(Product_ID) AS Product_ID,
            Unit_Price,
            Unit_Cost
            FROM bronze.products;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.sales';
        TRUNCATE TABLE silver.sales;

        PRINT '>> Inserting data into table: silver.sales';
        INSERT INTO silver.sales (
            Row_ID,
            Order_ID,
            Order_Date,
            Ship_Date,
            Ship_Mode,
            Customer_ID,
            Country,
            City,
            State_Province,
            Postal_Code,
            Division,
            Region,
            Product_ID,
            Product_Name,
            Sales,
            Units,
            Gross_Profit,
            Cost)
            select 
            Row_ID,
            Order_ID,
            Order_Date,
            Ship_Date,
            TRIM(Ship_Mode) AS Ship_Mode,
            Customer_ID,
            TRIM(Country) AS Country,
            TRIM(City) AS City,
            TRIM(State_Province) AS State_Province,
            Postal_Code,
            TRIM(Division) AS Division,
            TRIM(Region) AS Region,
            TRIM(Product_ID) AS Product_ID,
            TRIM(Product_Name) AS Product_Name,
            Sales,
            Units,
            Gross_Profit,
            Cost 
            FROM bronze.sales;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.targets';
        TRUNCATE TABLE silver.targets;

        PRINT '>> Inserting data into table: silver.targets';
        INSERT INTO silver.targets (
            Division,
            Target)
            SELECT 
            TRIM(Division) AS Division,
            Target
            FROM bronze.targets;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.uszips';
        TRUNCATE TABLE silver.uszips;

        PRINT '>> Inserting data into table: silver.uszips';
        INSERT INTO silver.uszips (
            zip,
            lat,
            lng,
            city,
            state_id,
            state_name,
            zcta,
            parent_zcta,
            population,
            density,
            country_fips,
            country_name,
            country_weights,
            country_names_all,
            country_fips_all,
            imprecise,
            military,
            timezone)
            SELECT 
            zip,
            lat,
            lng,
            TRIM(city) AS city,
            TRIM(state_id) AS state_id,
            TRIM(state_name) AS state_name,
            TRIM(zcta) AS zcta,
            COALESCE(parent_zcta, 'n/a') AS parent_zcta,
            population,
            density,
            country_fips,
            TRIM(country_name) AS country_name,
            TRIM(country_weights) AS country_weights,
            TRIM(country_names_all) AS country_names_all,
            country_fips_all,
            TRIM(imprecise) AS imprecise,
            TRIM(military) AS military,
            TRIM(timezone) AS timezone
            FROM bronze.uszips;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END