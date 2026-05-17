USE BankChurnDB
GO
WITH yas_gruplari AS(
	SELECT
		customer_id,
		age,
		churn,
		CASE
			WHEN age BETWEEN 18 AND 30 THEN 'Genç'
			WHEN age BETWEEN 31 AND 45 THEN 'Orta Yaş'
			WHEN age BETWEEN 46 AND 60 THEN 'Olgun'
			WHEN age>60 THEN 'Yaşlı'
		
		END AS yas_grubu
	FROM dbo.Customers
)

SELECT
yas_grubu,
COUNT(*) AS toplam,
SUM(CAST(churn AS INT)) AS churn_sayisi,
CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS churn_rate
FROM yas_gruplari
GROUP BY yas_grubu
ORDER BY churn_rate DESC



