---------------------------WINDOW FUNCTION----------------------------------------

--GROUP BY--> distinct kullanmıyoruz, distinct'i zaten kendi içinde yapıyor
--WF--> optioanal olarak yapabiliyoruz.

--GROUP BY -->  aggregate mutlaka gerekli, 
--WF--> aggregate optional

--GROUP BY --> Ordering invalid
--WF--> ordering valid

--GROUP BY --> performansı düsük
--WF --> performanslı



-- SYNTAX

SELECT {columns}
FUNCTION OVER (PARTITION BY...ORDER BY...WINDOW FRAME)
FROM table1

select *,
AVG(time) OVER(
				PARTITION BY id ORDER BY date
				ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
				) as avg_time
FROM time_of_sales


 
-- UNBOUNDED PRECEDING --> ÖNCEKi SATIRLARIN HEPSiNE BAK (kendi partition içinde)
-- UNBOUNDED FOLLOWING--> SONRAKi SATIRLARIN HEPSÝNE BAK (kendi partition içinde)

-- N PRECEDING --> BELÝRTÝLEN N DEÐERÝNE KADAR ÖNCESiNE GidiP BAK
-- M FOLLOWING --> BELÝRTÝLEN M DEÐERÝNE KADAR SONRASINA BAK


-------------------------------------------------------------------------------
-- SORU 1: ürünlerin stock sayýlarýný bulunuz

SELECT product_id, SUM(quantity)
FROM production.stocks
GROUP BY product_id


SELECT product_id
FROM production.stocks
GROUP BY product_id
ORDER BY 1

-- window function ile yazalým
SELECT SUM(quantity) OVER (PARTITION BY product_id)
FROM production.stocks
-- YENÝ BÝR SÜTUN OLARAK sonuç geldi ama tek sütun olduðu için anlamak zor. yanýna diger sütunları da getirelim

SELECT *, SUM(quantity) OVER (PARTITION BY product_id)
FROM production.stocks

--sadece product_id sütunu iþimizi görür
SELECT product_id, SUM(quantity) OVER (PARTITION BY product_id)
FROM production.stocks

-- Distinct atarak product_id leri teke düþürürüm
SELECT DISTINCT product_id, SUM(quantity) OVER (PARTITION BY product_id)
FROM production.stocks


-- SORU 2: Markalara göre ortalama bisiklet fiyatlarini hem GROUP BY hem de WINDOW Function ile hesaplayýnýz

-- GROUP BY ile :
SELECT brand_id, AVG(list_price) avg_price
FROM production.products
GROUP BY brand_id

-- window function ile:
SELECT brand_id, AVG(list_price) OVER (PARTITION BY brand_id) avg_price
FROM production.products
