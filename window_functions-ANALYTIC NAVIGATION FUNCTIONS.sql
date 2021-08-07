--------------------------- 2. ANALYTIC NAVIGATION FUNCTIONS ------------------------------------------------------------

-- FIRST_VALUE()  -- LAST_VALUE() -- LEAD() -- LAG()



-- SORU 1 : Order tablosuna asagıdaki gibi yeni bir sütun ekleyiniz:
	-- Her bir personelin bir önceki satısının sipariş tarihini yazdırınız (LAG Fonksiyonunu kullanýnýz)

SELECT *, 
LAG(order_date, 1) OVER (PARTITION BY staff_id ORDER BY order_date, order_id) prev_ord_date
-- Her bir personel dediği için  PARTITION BY a staff_id koyuyoruz. (staff_id lere göre grupluyoruz)
-- bir önceki sipariş tarihini sorduğu için ORDER BY da order date'e (ve order_id'ye) göre sýralama yaptırdım
FROM sales.orders

-- LAG, current row'dan belirtilen argümandaki rakam kadar önceki degeri getiriyor..
-- query sonucu incelediðinde LAG fonksiyonu, prev_ord_date sütununda her satıra o satırın bir önceki satırındaki tarihi yazdıgını görebilirsin.
-- yani her satır bir önceki order_date'i yazdırmıs olduk

--staff_id'nin 2 den 3'e geçtigi 165. satıra dikkat et. o satırdan itibaren yeni bir pencere açtı ve 
-- LAG() fonksiyonunu o pencereye ayrıca uyguladı. (165. satırda bir önceki tarih olmadıgı için NULL yazdırdı.)




-- SORU 2: Order tablosuna asagıdaki gibi yeni bir sütun ekleyiniz:
	--2. Herbir personelin bir sonraki satýþýnýn sipariþ tarihini yazdýrýnýz (LEAD fonksiyonunu kullanýnýz)

SELECT	*,
		LEAD(order_date, 1) OVER (PARTITION BY staff_id ORDER BY Order_date, order_id) next_ord_date
FROM	sales.orders

-- LEAD, current row'dan belirtilen argümandaki rakam kadar sonraki deðeri getiriyor
-- Niye iki sütunu order by yaptýk? çünkü ayın aynı gününde birden fazla siparis verilmis olabilir.
	-- o yüzden tarihe ilave olarak bir de order_id ye göre sıralama yaptırdık

--GENELLıKLE LEAD VE LAG FONKSiYONLARI SIRALANMIS BiR LiSTEYE UYGULANIR!!! O YÜZDEN ORDER BY KULLANILMALIDIR!!
