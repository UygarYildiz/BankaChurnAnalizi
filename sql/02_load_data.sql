USE BankChurnDB
GO
BULK INSERT dbo.Customers
FROM 'C:\Users\uygar\OneDrive\Desktop\CV_Projesi\data\bank_churn.csv'
WITH (
	FORMAT='CSV',
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	CODEPAGE='65001',
	TABLOCK
);
GO

SELECT COUNT(*) FROM dbo.Customers
