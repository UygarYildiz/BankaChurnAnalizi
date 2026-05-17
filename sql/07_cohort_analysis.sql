USE BankChurnDB
GO
WITH kohort AS(
SELECT
customer_id,
churn,
CASE 
	WHEN tenure BETWEEN 0 AND 3 THEN 'Yeni'
	WHEN tenure BETWEEN 4 AND 6 THEN 'Orta'
	ELSE 'Köklü'
	END AS musteri_suresi

FROM dbo.Customers
)
SELECT
musteri_suresi,
COUNT(*) AS toplam_müsteri,
SUM(CAST(churn AS INT)) AS gercek_churn,
CAST(ROUND(100.0*SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS churn_rate

FROM kohort
GROUP BY musteri_suresi
ORDER BY churn_rate DESC	