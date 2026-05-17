USE  BankChurnDB
GO
CREATE OR ALTER VIEW dbo.vw_ChurnByGender
AS
	SELECT
		gender,
		COUNT(*) AS toplam,
		SUM(CAST(churn AS INT)) AS churn_sayisi,
		CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
	FROM dbo.Customers
	GROUP BY gender
GO

CREATE OR ALTER VIEW dbo.vw_ChurnByCountry
AS
	SELECT
		country,
		COUNT(*) AS toplam_musteri,
		SUM(CAST(churn AS INT)) AS churn_sayisi,
		CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate
	FROM dbo.Customers
	GROUP BY country
GO


CREATE OR ALTER VIEW dbo.vw_ChurnByAge
AS
	WITH
		yas_gruplari
		AS

		(
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
		SUM(CAST(churn AS INT))	 AS churn_sayisi,
		CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS churn_rate
	FROM yas_gruplari
	GROUP BY yas_grubu
GO

CREATE OR ALTER VIEW dbo.vw_RiskProfile
AS
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
	
GO

CREATE OR ALTER VIEW dbo.vw_ExecutiveSummary
AS
	SELECT
		COUNT(*) AS toplam_musteri,
		SUM(CAST(churn AS INT)) AS toplam_churn,
		CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS genel_churn_rate,
		CAST(ROUND(AVG(balance),2) AS DECIMAL(18,2)) AS ortalama_bakiye,
		CAST(ROUND(AVG(credit_score),2) AS DECIMAL(5,2)) AS ortalama_kredi_puani,
		CAST(ROUND(100.0 * SUM(CAST(active_member AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS aktif_uye_orani

	FROM dbo.Customers
GO


	
	