

EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.factories';
		TRUNCATE TABLE bronze.factories;

		PRINT '>> Inserting Data Into Table: bronze.factories';
		BULK INSERT bronze.factories
		FROM 'C:\Users\turningpointKS\Desktop\analysis\candy\Candy_Factories.csv'
		WITH (FORMAT = 'CSV',
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  ROWTERMINATOR = '\n',
			  FIELDQUOTE = '"',
			  TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ----------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.products';
		TRUNCATE TABLE bronze.products;

		PRINT '>> Inserting Data Into Table: bronze.products';
		BULK INSERT bronze.products
		FROM 'C:\Users\turningpointKS\Desktop\analysis\candy\Candy_Products.csv'
		WITH (FORMAT = 'CSV',
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  ROWTERMINATOR = '\n',
			  FIELDQUOTE = '"',
			  TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ----------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.sales';
		TRUNCATE TABLE bronze.sales;

		PRINT '>> Inserting Data Into Table: bronze.sales';
		BULK INSERT bronze.sales
		FROM 'C:\Users\turningpointKS\Desktop\analysis\candy\Candy_Sales.csv'
		WITH (FORMAT = 'CSV',
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  ROWTERMINATOR = '\n',
			  FIELDQUOTE = '"',
			  TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ----------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.targets';
		TRUNCATE TABLE bronze.targets;

		PRINT '>> Inserting Data Into Table: bronze.targets';
		BULK INSERT bronze.targets
		FROM 'C:\Users\turningpointKS\Desktop\analysis\candy\Candy_Targets.csv'
		WITH (FORMAT = 'CSV',
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  ROWTERMINATOR = '\n',
			  FIELDQUOTE = '"',
			  TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ----------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.uszips';
		TRUNCATE TABLE bronze.uszips;
		PRINT '>> Inserting Data Into Table: bronze.uszips';
		BULK INSERT bronze.uszips
		FROM 'C:\Users\turningpointKS\Desktop\analysis\candy\uszips.csv'
		WITH (FORMAT = 'CSV',
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  ROWTERMINATOR = '\n',
			  FIELDQUOTE = '"',
			  CODEPAGE = '65001',  -- for UTF-8 encoding
			  TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ----------------';

		SET @batch_end_time = GETDATE();
		PRINT '========================================'
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '========================================'
	END TRY	
	BEGIN CATCH
		PRINT '========================================'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '========================================'
	END CATCH
END	  
	