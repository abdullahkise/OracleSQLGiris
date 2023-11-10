--Tablo Olu?tural?m
CREATE TABLE adv_Sirket
(
    SirketId int, --NUMBER(10)
    SirketAd nvarchar2(50),
    SirketSlogan nvarchar2(100)
);

--DROP TABLE adv_Sirket;

--DROP TABLE adv_Sirket
--TRUNCATE TABLE adv_Sirket --tabloyu bo?alt?r. Geriye dönülemez bir i?lemdir.
--DELETE TABLE adv_Sirket -- içeri?ini siler.

--Tabloya veri giri?i için INSERT
--1. Tablodan sonra kolon adlar? belirtilir.
INSERT INTO adv_Sirket(SirketId,SirketAd, SirketSlogan) VALUES (1,'Devcosci','Development Coding Science');

--2. E?er kolonlar? tan?mlama s?ras?nda giri? yapacaksak kolonlar? belirmemize gerek yok.
INSERT INTO adv_Sirket VALUES (2,'EP?A?','Enerji bizim i?imiz');


--kay?tlara bakal?m
SELECT * FROM adv_Sirket;

--3. toplu halde kay?t girilebilir. Bulk Insert
INSERT ALL
    INTO adv_Sirket VALUES(3,'A','Sirket A')
    INTO adv_Sirket VALUES(4,'B','Sirket B')
    INTO adv_Sirket VALUES(-1,'???','Calisan? olmayan ?irket')
SELECT * FROM dual;


--içeri?e bakal?m
SELECT * FROM adv_Sirket;

---------------
--Kat?l?mc?lar tablosu
--DROP TABLE Adv_Katilimcilar;
CREATE TABLE Adv_Katilimcilar
(
    KatilimciId int,
    SirketId int,
    KatilimciAd nvarchar2(50)
);

--
INSERT INTO Adv_Katilimcilar VALUES(1,1,'Abdullah Kise');

INSERT INTO Adv_Katilimcilar VALUES(2,2,'Zeynep Özmen');
INSERT INTO Adv_Katilimcilar VALUES(3,2,'Ahmet ?im?ek');
INSERT INTO Adv_Katilimcilar VALUES(4,2,'Abdulmelik Bu?da');

INSERT INTO Adv_Katilimcilar VALUES(5,3,'A Calisan?');

INSERT INTO Adv_Katilimcilar VALUES(6,4,'B Calisan?');

INSERT INTO Adv_Katilimcilar VALUES(7,5,'?irketi Olmayan Calisan');

--
SELECT * FROM Adv_Katilimcilar;

--------------------------------------------------
SELECT * FROM Adv_Sirket;
SELECT * FROM Adv_Katilimcilar;

/*
    JOIN: En az iki tablodaki kolonlar? yeni bir tablo olu?turmak yanyana getirebiliyoruz.
    tablolar? yanyana birle?tirmek için kullan?l?yor diyebiliriz.
    
    1. INNER JOIN
        - INNER JOIN ?fadesinin sa??ndaki ve solundaki tablolardan sadece belirtilen ?arta uyanlar e?le?ir.
        - ?arta uymayanlar göz ard? edilir. tabloda görünmez.
    2. OUTER JOIN
        a. LEFT JOIN
            - LEFT JOIN ifadesinin solundaki tablo kay?tlar? aynen gelir. Sa??ndaki tabloda sadece ?arta uyanlar gelir. 
            - E?le?meyenler için soldaki tablo kar??s?na NULL atan?r.
        b. RIGHT JOIN
            - RIGHT JOIN ifadesinin sa??ndaki tablo kay?tlar? aynen gelir. Solundakinden sadece e?le?eneler gelir.
            - E?le?meyenler için sa?daki tablonun kar??na NULL atan?r.
        c. FULL JOIN
            - FULL JOIN ifadesinin her iki taraf?ndaki talo aynen gelir. e?le?en e?le?ir. e?le?meyen için kar??l??na NULL atarn?r.
    3. CROSS JOIN
        - CROSS JOIN ifadesinin sa??ndaki ve solundaki tablo kartez çarp?ma u?rar.
        - Yani bir tablodaki her kay?t di?er tablodaki tüm kay?tlarla e?le?ir.
        - Burada e?le?me ?art? belirtilmez. 
*/

--INNER JOIN
--Sadece e?le?enler gelir.
SELECT
    Adv_Katilimcilar.KatilimciAd,
    Adv_Sirket.SirketAd
FROM Adv_Sirket INNER JOIN Adv_Katilimcilar --JOIN türü
    ON Adv_Sirket.SirketId = Adv_Katilimcilar.SirketId; --e?le?tirme ?art? her sat?r kontrol edilir. True ise sat?r gelir.


-- Outer -- LEFT JOIN
-- ifadenin solndaki tablo aynen gelir. E?le?meyen kar??l?klar?na NULL bas?l?r.
SELECT
    Adv_Katilimcilar.KatilimciAd,
    Adv_Sirket.SirketAd
FROM Adv_Sirket LEFT JOIN Adv_Katilimcilar --JOIN türü
    ON Adv_Sirket.SirketId = Adv_Katilimcilar.SirketId;
    
-- Outer -- RIGHT JOIN
-- ifadenin sa??ndaki tablo aynen gelir. E?le?meyen kar??l?klar?na NULL bas?l?r.
SELECT
    Adv_Katilimcilar.KatilimciAd,
    Adv_Sirket.SirketAd
FROM Adv_Sirket RIGHT JOIN Adv_Katilimcilar --JOIN türü
    ON Adv_Sirket.SirketId = Adv_Katilimcilar.SirketId;
    
-- Outer -- FULL JOIN
-- ifadenin her iki taraf?ndaki tablo aynen gelir. E?le?meyen kar??l?klar?na NULL bas?l?r.
SELECT
    Adv_Katilimcilar.KatilimciAd,
    Adv_Sirket.SirketAd
FROM Adv_Sirket FULL JOIN Adv_Katilimcilar --JOIN türü
    ON Adv_Sirket.SirketId = Adv_Katilimcilar.SirketId;
    
    
--CROSS JOIN
--?art olmaz. kartezyen çarp?m yani bir tablodaki her eleman di?er tablodaki her eleman ile e?le?ir.
SELECT
    Adv_Katilimcilar.KatilimciAd,
    Adv_Sirket.SirketAd
FROM Adv_Sirket CROSS JOIN Adv_Katilimcilar; --JOIN türü
/*
    CROSS JOIN ne için kullan?labilir?
        - Veri türetmek için
        - Mesela tüm sat?? bölgelerinin bir birin elan uzakl???n? hesaplamak isteyebiliriz.
        - Tüm alternatif olas?l?klar? görmek için olu?turabiliriz.
*/
   
--Not koloayl?k olsun diye tablolara alias verilebilir.

-----ESK? Yöntemler
--CROSS JOIN
SELECT
    s.SirketAd,
    k.KatilimciAd
FROM adv_Sirket s, Adv_Katilimcilar k;


--INNER JOIN
SELECT
    s.SirketAd,
    k.KatilimciAd
FROM adv_Sirket s, Adv_Katilimcilar k
WHERE s.SirketId = k.SirketId;
--------------------------------------------
--Q&A: Hangi firmada kaç kat?l?mc? var?
SELECT
    s.SirketAd,
    count(k.katilimciid)
    --,count(*)
FROM Adv_Sirket s LEFT JOIN Adv_Katilimcilar k
    ON s.SirketId = k.SirketId
GROUP BY s.SirketAd
ORDER BY 2 DESC;


--Q&A: ProductId, Name,ListPrice, SubCategoryName,CategoryName bilgilerini getirelim.
--adv_Product, Adv_ProductSubCategory, Adv_Category
SELECT
    p.ProductId,
    p.Name as ProductName,
    p.ListPrice,
    NVL(sc.Name,'Bo?') as SubCategoryName,
    NVL(c.Name,'Bo?') as CategoryName
FROM Adv_Product p LEFT JOIN Adv_ProductSubCategory sc
    ON p.ProductSubCategoryId = sc.ProductSubCategoryId
        LEFT JOIN Adv_ProductCategory c
            ON sc.ProductCategoryId = c.ProductCategoryId;

--Q&A Hangi kategoride kaç ürün var.
SELECT
    NVL(c.Name,'Bo?') as CategoryName,
    count(DISTINCT sc.productsubcategoryid) as AltKategoriAdedi, --Urun yüzünden tekrar ediyor.
    count(p.ProductId) as UrunAdedi
FROM Adv_Product p LEFT JOIN Adv_ProductSubCategory sc
    ON p.ProductSubCategoryId = sc.ProductSubCategoryId
        LEFT JOIN Adv_ProductCategory c
            ON sc.ProductCategoryId = c.ProductCategoryId
GROUP BY NVL(c.Name,'Bo?');


--Q&A En çok mü?terinin oldu?u 5 bölge.
--Adv_SalesTerritory, Adv_Customer
SELECT
    t.Name as Bolge,
    count(c.CustomerId) as MusterAdedi
FROM Adv_SalesTerritory t FULL JOIN adv_Customer c
    ON t.TerritoryId = c.TerritoryId
GROUP BY t.Name
ORDER BY 2 DESC
    FETCH FIRST 5 ROWS ONLY;
    
    
    
    
    
    
 
