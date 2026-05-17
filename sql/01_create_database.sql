USE BankChurnDB
IF NOT EXISTS (SELECT * from sys.databases WHERE name = 'BankChurnDB')
BEGIN 
	PRINT 'Database oluşturuluyor...'
		
	CREATE DATABASE BankChurnDB

END
ELSE 
	PRINT 'Database zaten mevcut...'
GO

	IF OBJECT_ID('dbo.Customers','U') IS NULL
		BEGIN
			PRINT 'Customers tablosu oluşturuluyor...'

				CREATE TABLE dbo.Customers (
				customer_id INT PRIMARY KEY,
				credit_score INT,
				country VARCHAR(50),
				gender VARCHAR(10),
				age INT,
				tenure INT,
				balance DECIMAL(18,2),
				products_number INT,
				credit_card BIT,
				active_member BIT,
				estimated_salary DECIMAL(18,2),
				churn BIT
		
				)
				PRINT 'Customers Tablosu oluşturuldu'
		END
		GO







