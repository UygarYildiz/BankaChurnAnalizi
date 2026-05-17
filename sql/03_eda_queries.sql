USE BankChurnDB
GO

-- =======================================
-- 1. Genel İstatistikler -
-- =======================================
SELECT
	
	COUNT(*) AS Toplam_Müsteri,
	AVG(age) AS Ortalama_Yas,
	MIN(age) AS En_Kucuk_Yas,
	MAX(age) AS En_Buyuk_Yas,
	AVG(balance) AS Ortalama_Bakiye,
	AVG(credit_score) AS Ortalama_Kredi_Skoru,
	MIN(credit_score) AS En_Kucuk_Kredi_Skoru,
	MAX(credit_score) AS En_Buyuk_Kredi_Skoru
FROM dbo.Customers;

-- =======================================
-- 2. Churn Oranı -
-- =======================================

SELECT
	SUM(CASE WHEN churn=1 THEN 1 ELSE 0 END) AS terk_eden,
	SUM(CASE WHEN churn=0 THEN 1 ELSE 0 END) AS kalan,
	CAST(ROUND(100.0 * SUM(CAST(churn AS INT))/COUNT(*),2) AS DECIMAL(5,2)) AS  churn_rate


FROM dbo.Customers;

-- =======================================
-- 3. Ülke Dağılımı -
-- =======================================

SELECT
	country,
	COUNT(*) AS müsteri_sayisi
FROM dbo.Customers
GROUP BY country
ORDER BY müsteri_sayisi DESC;


-- =======================================
-- 4. NULL Kontrolü -
-- =======================================


SELECT
	COUNT(*)-COUNT(customer_id) AS id_eksik,
	COUNT(*)-COUNT(credit_score) AS kredi_skor_eksik,
	COUNT(*) - COUNT(country) AS ulke_eksik,
	COUNT(*)- COUNT(gender) AS cinsiyet_eksik,
	COUNT(*)- COUNT(age) AS yas_eksik,
	COUNT(*)-COUNT(tenure) AS tenure_eksik,
	COUNT(*)-COUNT(balance) AS bakiye_eksik,
	COUNT(*)-COUNT(products_number) AS urun_sayisi_eksik,
	COUNT(*)- COUNT(credit_card) AS kredi_karti_eksik,
	COUNT(*)-COUNT(active_member) AS aktif_uye_eksik,
	COUNT(*)-COUNT(estimated_salary) AS tahmini_maas_eksik,
	COUNT(*)-COUNT(churn) AS churn_eksik

FROM dbo.Customers


