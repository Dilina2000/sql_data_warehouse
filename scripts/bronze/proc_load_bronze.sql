/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME;
BEGIN TRY
PRINT '======================================================================================';
PRINT 'loading bronze layer';
PRINT '======================================================================================';


PRINT '--------------------------------------------------------------------------------------';
PRINT 'Loading CRM tables';
PRINT '--------------------------------------------------------------------------------------';

SET @start_time = GETDATE();

TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_crm\cust_info'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);

TRUNCATE TABLE bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_crm\prd_info'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);

TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_crm\sales_details'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
SET @end_time = GETDATE();
PRINT '>> load duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR) + ' seconds';

SET @start_time = GETDATE();
PRINT '--------------------------------------------------------------------------------------';
PRINT 'Loading ERP tables';
PRINT '--------------------------------------------------------------------------------------';
TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_erp\CUST_AZ12'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);

TRUNCATE TABLE bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_erp\LOC_A101'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
)

TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'E:\Campus\other\Data Engineer\Project 1\datasets\source_erp\PX_CAT_G1V2'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
SET @end_time = GETDATE();
PRINT '>> load duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR) + ' seconds';

END TRY
BEGIN CATCH
PRINT'=========================================================='
PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
PRINT'erro Message' + ERROR_MESSAGE();
PRINT'erro Message' + CAST(ERROR_NUMBER() AS VARCHAR); 
PRINT'=========================================================='
END CATCH

END
