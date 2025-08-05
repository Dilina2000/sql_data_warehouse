/*
===============================================================
Create Database Schemas
===============================================================
script purpose
  create a new database named 'DataWarehouse' after checking already exists.
  Additionally, the script sets up three schemas within the database: 'bronze', 'silver' and 'gold'
*/


USE master;
GO

-- DROP and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM  sys.database WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;
GO

-- create the 'datawarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse
GO

-- create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
Go

CREATE SCHEMA gold;
GO
