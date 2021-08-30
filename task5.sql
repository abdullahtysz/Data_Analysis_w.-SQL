
--- TASK 5

SELECT  
count(distinct AD) 
FROM task5

--- Unique olan isimlerin sayısını yazdırdım

SELECT
count(distinct TCKN) count_tc 
FROM task5

--- Unique olan Kimlik Numaralarının sayısını yazdırdım

SELECT TCKN, 
count(TCKN) count_tc, 
count(distinct AD) count_ad
FROM task5
		group by TCKN
		having count(TCKN) > 1 AND
		count(distinct AD) >1


--- Şimdi bu bilgileri Group By ile grupladım
--- Toplu verilerde Kullanılan HAVING ile burada bir filtreleme yaptım
--- Sonuç olarak TCKN ve Ad kolonunda 1'den fazla olan değerleri yazdırdım
--- 71824829102 Kimlik numarasına sahip 2 farklı isim var.

SELECT distinct* FROM task5 WHERE TCKN = 71824829102

--- Kimlik numarası 71824829102 olanların isimlerini yazdırdım
