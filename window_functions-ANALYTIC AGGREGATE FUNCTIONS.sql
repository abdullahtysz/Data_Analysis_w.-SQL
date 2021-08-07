
-----------------------------1. ANALYTIC AGGREGATE FUNCTIONS -----------------------------------------------------------------

--MIN()  --MAX()   --AVG()  --SUM()  -- COUNT()




--SORU 1: Tüm bisikletler arasýnda en ucuz bisikletin fiyatý

-- Minimum list_price istiyor. herhangi bir gruplamaya yani PARTITION a gerek yok!
SELECT DISTINCT MIN (list_price) OVER ()
FROM production.products



--SORU 2: Her bir kategorideki en ucuz bisikletin fiyati?

-- kategoriye göre gruplama yapmak zorundayim yani PARTITION gerekli
SELECT DISTINCT category_id, MIN (list_price) OVER (PARTITION BY category_id)
FROM production.products



--SORU 3: product tablosunda toplam kaç farkli bisiklet var?

SELECT DISTINCT COUNT (product_id) OVER () NUM_OF_BIKE
FROM production.products
-- sadece product_id leri unique olarak saydırdım. PARTITION (gruplamaya gerek yok)
-- product tablosunda 321 adet farklı bisiklet oldugunu gördüm.



--SORU 4: Order_items tablosunda kaç farklý bisiklet var?
SELECT DISTINCT COUNT(product_id) OVER() order_num_of_bike
FROM sales.order_items
-- ürün sayısı : 4722

-- Bu hata verir!!
SELECT COUNT(DISTINCT product_id) OVER() order_num_of_bike
FROM sales.order_items
-- COUNT WINDOW fonksiyonunda yukarıdaki gibi içinde DISTINCT'e izin vermiyor! Onun yerine,

SELECT COUNT(DISTINCT product_id)
FROM sales.order_items
--307 product_id geldi. bunun üzerinden bir sayma islemi yaparsam

-- yukardaki query'i window fonksiyonunu kullandıgımm query'nin subquerysi yapacagım.
SELECT DISTINCT COUNT(product_id) OVER() order_num_of_bike
FROM (
		SELECT DISTINCT product_id  -- buradan 307 row deðer gelecek
		FROM sales.order_items
	) A


-- SORU 4: her bir kategoride toplam kaç farkli bisiklet var?

SELECT DISTINCT category_id, COUNT(product_id) OVER(PARTITION BY category_id)
FROM production.products
-- product_id zaten unique olduðu için ayrica bir distinct e gerek kalmadi.


--SORU 5: Herbir kategorideki herbir  markada kaç farklý bisikletin bulunduðu
SELECT DISTINCT category_id, brand_id, COUNT(product_id) OVER(PARTITION BY category_id, brand_id)
FROM production.products



--SORU 6 : WF ile tek select'te herbir kategoride kaç farklı marka olduðunu hesaplayabilir miyiz?

SELECT DISTINCT category_id, COUNT(brand_id) OVER (PARTITION BY category_id) 
FROM production.products
-- burada her bir kategorideki satýr sayýsýný getiriyor. bunu istemiyoruz!!

SELECT DISTINCT category_id, COUNT(brand_id) OVER (PARTITION BY category_id) 
FROM 
(
SELECT DISTINCT category_id, brand_id  -- ÖNCE DISTINCT iLE BRAND_ID'LERi GETiRDiM.
FROM production.products 
) A
-- görüldügü gibi WF  ile tek bir SELECT satırı ile bu soru yapýlamýyor.

SELECT	category_id, count (DISTINCT brand_id)
FROM	production.products
GROUP BY category_id

--Sonuç: isin içinde DISTINCT varsa GROUP BY ile daha kolayca çözüme ulasılıyor!!!


