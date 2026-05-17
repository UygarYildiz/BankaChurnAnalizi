USE BankChurnDB
GO
WITH
	risk_scores
	AS
	
	(
		SELECT
			customer_id,
			churn,
			(CASE WHEN age BETWEEN 46 AND 60 THEN 30 ELSE 0 END 
+ CASE WHEN active_member=0 THEN 25 ELSE 0 END
+CASE WHEN products_number>=3 THEN 25 ELSE 0 END
+ CASE WHEN country='Germany' THEN 10 ELSE 0 END 
+ CASE WHEN balance=0 THEN 10 ELSE 0 END
) AS risk

		FROM dbo.Customers
	),
	risk_segments
	AS
	
	(
		SELECT
			*,
			CASE 
	WHEN risk>=70 THEN 'Kritik Risk'
	WHEN risk>=40 THEN 'Yüksek Risk'
	WHEN risk>=20 THEN 'Orta Risk'
	ELSE 'Düşük Risk' END AS risk_segment

		FROM risk_scores
	)
SELECT risk_segment,
	COUNT(*) AS toplam_musteri,
	SUM(CAST(churn AS INT)) AS gercek_churn,
	CAST(ROUND(100.0* SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS churn_rate
FROM risk_segments
GROUP BY risk_segment
ORDER BY churn_rate DESC

	
