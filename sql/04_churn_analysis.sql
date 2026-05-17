USE BankChurnDB
GO

--- Churn Analizi

-- =======================================
-- 1. Cinsiyete Göre Churn
-- =======================================

SELECT 
gender,
COUNT(*) AS toplam,
SUM(CAST(churn AS INT)) AS churn_sayisi,
CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
FROM dbo.Customers
GROUP BY gender
ORDER BY churn_rate DESC;


-- =======================================
-- 2. Ülkeye Göre Churn
-- =======================================
	SELECT
	country,
	CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
	FROM dbo.Customers
	GROUP BY country
	ORDER BY churn_rate DESC


-- =======================================
-- 3. Aktiflik Durumuna Göre Churn
-- =======================================

SELECT
active_member,
COUNT(*) AS toplam,
SUM(CAST(churn AS INT)) AS churn_sayisi,
CAST(ROUND(100.0 * SUM (CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
FROM dbo.Customers
GROUP BY active_member
ORDER BY churn_rate DESC;

-- =======================================
-- 4. Ürün Sayısına Göre Churn
-- =======================================
SELECT
products_number,
COUNT(*) AS toplam,
SUM(CAST (churn AS INT)) AS churn_sayisi,
CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
FROM dbo.Customers
GROUP BY products_number
ORDER BY churn_sayisi DESC;




