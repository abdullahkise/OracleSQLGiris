/*
    Aggregate (toplama, özetleme, gruplama vs.) fonksiyonlar mevcut
    COUNT, SUM, MAX, MIN, AVG, MEDIAN, STDDEV vs.
    
    COUNT'a özel:
    COUNT(KolonAdi) de?eri null olmayan sat?rlar say?l?r.
    COUNT(*) tüm sat?rlar? sayarlar.
    COUNT(DISINCT KolonAdi) Kaç farkl? de?er var.
*/
SELECT
    SUM(SalesAmount) as "Toplam Sipari? Tutar",
    AVG(SalesAmount) as "Ortalama Sipari? Tutar?",
    
    MAX(SalesAmount) as "En Fazla Sipari? Tutar?",
    MIN(SalesAmount) as "En Dü?ük Sipari? Tutar?",
    
    MEDIAN(SalesAmount) as "Ortanca Sipari? Tutar?",
    STDDEV(SalesAmount) as "En Dü?ük Sipari? Tutar?",

    COUNT(*) as "Sat?r adedi",
    COUNT(SalesOrderNumber) as "Null olmayan sat?rlar",
    COUNT(DISTINCT SalesOrderNumber) as "Null hariç kaç adet var"
FROM adv_FactInternetSales;

/*
    Matemaitksel Operatorler
    +, -, *, /, %
    5%2 = 1 mod alma i?lemi
*/
SELECT
    SUM(OrderQuantity * UnitPrice),
    SUM(SalesAmount)
FROM adv_FactInternetSales;

/*
    GROUP BY
    - Gruplama fonksiyonlar?yla birlikte ba?ka bir kolon (expression) göstermek istiyorsak
    Bu kolon GROUP BY ifadesi ile belirtilmeldir.
    
    Bu sayesde gruplama i?lemi GROUP BY da belirtilen kolona göre yap?lacak.
*/
SELECT
    SalesOrderNumber,
    SUM(SalesAmount) as "Toplam",
    AVG(SalesAmount) as "Ortalama",
    MAX(SalesAmount) as "Max",
    MIN(SalesAmount) as "Min",
    COUNT(*) as Adet
FROM adv_FactInternetSales
GROUP BY SalesOrderNumber --SalesOrderNumber alan?a göre grupla, gruplama fonksiyonlar?n? çal??t?r.
--ORDER BY COUNT(*) DESC
--ORDER BY Adet DESC;
ORDER BY 6 DESC;

--Q&A: 1980 y?l?ndan sonra do?an kaç bekar (S) erkek(M) kaç bekar kad?n(F) vard?r.
DESC adv_Employee;
--
SELECT
    MaritalStatus,
    Gender,
    BirthDate
FROM adv_Employee;

--
SELECT
    Gender,
    COUNT(*)
FROM adv_Employee
WHERE MaritalStatus = 'S' 
      --AND BirthDate > TO_DATE('1980-12-31','yyyy-mm-dd')
      AND EXTRACT(year from BirthDate) > 1980
GROUP BY Gender;

/*
    HAVING
    Gruplanm?? sonuçlar? filtrelemek için kullan?l?r.
    GROUP BY'?n filtresidir.
    GROUP BY'dan sonra kullan?lmal?d?r.
*/
--1980'dan büyük do?um tariine sahip Çal??anlar? 
--Gender ve MaritalStatus'a göre gruplayal?m. 
--20'den küçük olan gruplar? getirelim.
SELECT
    Gender,
    MaritalStatus,
    COUNT(*)
FROM adv_Employee
WHERE EXTRACT(year from BirthDate) > 1980
GROUP BY Gender, MaritalStatus
HAVING COUNT(*)<=20
ORDER BY Gender DESC, 
         MaritalStatus ASC, 
         COUNT(*) DESC; -- birden fazla kolona göre s?ralama yap?labilir.
