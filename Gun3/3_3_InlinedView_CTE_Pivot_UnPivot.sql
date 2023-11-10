/*
    Inline View 
     - y�ntemi ile karma??k bir sorguda sonucunu yeni bir tablo gibi sorgulayabiliriz.
*/

--Bikes kategorisindeki alt kategorilerde bulunan �r�nlerin en y�ksek fiyat? nedir?
SELECT
    sc.ProductSubCategoryId as ProductSubCategoryId,
    MAX(p.ListPrice) as MaxListPrice    
FROM Adv_Product p LEFT JOIN Adv_ProductSubCategory sc
    ON p.ProductSubCategoryId = sc.ProductSubCategoryId
        INNER JOIN adv_ProductCategory c
            ON sc.ProductCategoryId = c.ProductCategoryId
               AND c.Name = 'Bikes'
GROUP BY sc.ProductSubCategoryId;

--Bikes kategorisindeki alt kategoriler en y�ksek fiyata sahip �r�nler hangileri.
SELECT
    *
FROM ( --Yukar?daki sorgu sonucunu bir tablo gibi tekrar sorguluyoruz.
        SELECT
            sc.ProductSubCategoryId as ProductSubCategoryId,
            MAX(p.ListPrice) as MaxListPrice    
        FROM Adv_Product p LEFT JOIN Adv_ProductSubCategory sc
            ON p.ProductSubCategoryId = sc.ProductSubCategoryId
                INNER JOIN adv_ProductCategory c
                    ON sc.ProductCategoryId = c.ProductCategoryId
                       AND c.Name = 'Bikes'
        GROUP BY sc.ProductSubCategoryId
        ) T LEFT JOIN Adv_Product qp
            ON T.ProductSubCategoryId = qp.ProductSubCategoryId
                AND T.MaxListPrice = qp.ListPrice;
                

/*
    CTE (Common Table Expression)
    Sorgu sonu�lar? ile ge�ici tablolar olu?turmam?z? sa?layan bir y�ntemdir.
*/

--WITH cteSubCategoryMaxListPrice(ProductSubCategoryId, MaxListPrice)
WITH cteSubCategoryMaxListPrice
AS
(
    SELECT
        sc.ProductSubCategoryId as ProductSubCategoryId,
        MAX(p.ListPrice) as MaxListPrice    
    FROM Adv_Product p LEFT JOIN Adv_ProductSubCategory sc
        ON p.ProductSubCategoryId = sc.ProductSubCategoryId
            INNER JOIN adv_ProductCategory c
                ON sc.ProductCategoryId = c.ProductCategoryId
                   AND c.Name = 'Bikes'
    GROUP BY sc.ProductSubCategoryId
)
/*
,CTE_Tablom2
AS
(
    --Di?er sorgu
    -- alttaki CTE'ler �stteki CTE'leri kullanabilir.
    --Hatta kendi i�inde kendisini de �a??rabilir.
)
*/

SELECT
    *
FROM cteSubCategoryMaxListPrice T LEFT JOIN Adv_Product qp
            ON T.ProductSubCategoryId = qp.ProductSubCategoryId
                AND T.MaxListPrice = qp.ListPrice;

/*
    CTE Recursive olarak yani kendini s�relli �a??racak ?ekilde yaz?labilir.
    Derinli?i belli olmayan hiyerar?ilerde recursive sorgu yazman?z gerekebilir.
    En �st veya en alt hiyear?iye ula?mak isteyebilirsiniz.
    
    --
    Analitik sorgular olu?tururken veriambarlar?nda tan?mlanan tarih tablolar?ndan destek al?r
    tarihsel analizler yapar?z.
    Bu �zel tarih tablosunda bir tarihten di?erime kadar her sat?r bir g�n� temsil edecek ?ekilde kay?tlar i�erir.
*/

WITH cteDates(Tarih)
AS
(
    SELECT DATE '2005-07-01' as Tarih FROM dual -- ba?lang?� tarighi
    UNION ALL
    SELECT 
        Tarih +1
    FROM cteDates--kendisini �a??r?yoruz.
    WHERE Tarih +1 <= CURRENT_DATE -- Biti? tarihi
)
,cteDimTarih
AS
(
    SELECT 
        TO_NUMBER(TO_CHAR(Tarih,'yyyymmdd')) as TarihKey,
        Tarih,
        EXTRACT(year from Tarih) as Yil,
        TO_CHAR(Tarih,'yyyy')||'-Q'||TO_CHAR(Tarih,'Q') as Ceyrek,
        EXTRACT(month from Tarih) as Ay,
        EXTRACT(day from Tarih) as Gun,
        (
            CASE --char y�z�nden bo?luk sabit uzunluklu karekter �retiyor. Trim ile temizliyoruz.
                WHEN TRIM(To_CHAR(Tarih,'Day')) IN ('Saturday','Sunday') THEN 'Hafta Sonu'
                ELSE 'Hafta ?�i'
            END
        ) as HSHI
    FROM cteDates
)
--SELECT * FROM cteDimTarih;

SELECT
    t.HSHI,
    sum(f.SalesAmount)
FROM Adv_FactInternetSales f RIGHT JOIN cteDimTarih t
    ON f.OrderDateKey = t.TarihKey
GROUP BY t.HSHI
ORDER BY t.HSHI DESC;
--------------------------------------


/*
    Pivot - UnPivot
    Tablonun sat?r tekrarlanan bilgilerin de?erlerini bir araya getirip kolonlar ?eklinde g�stermemizi sa?lar.
    matris �retmi? oluruz. Normalde pivot zzaten raporun kendisidir.
*/
WITH CteSales
AS
(
    SELECT
        t.SalesTerritoryCountry as Ulke,
        EXTRACT(year from f.OrderDate) as Yil,
        SUM(f.SalesAmount) as ToplamSatis
    FROM adv_FactInternetSales f RIGHT JOIN adv_DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    GROUP BY  t.SalesTerritoryCountry, EXTRACT(year from f.OrderDate)
)
,cteSalesPivot
AS
(
    --Tablomuzu pivot yapal?m.
    SELECT * FROM CteSales
        PIVOT
            (
               SUM(ToplamSatis) --birden fazla value varsa nas?l bir araya getirsin.
               FOR Yil IN (2005,2006,2007,2008)--sat?rda bulunan kolona gelmesini istedi?imiz de?erler.
            ) pv
)
--SELECT * FROM cteSalesPivot;
,cteSalesPivotUnPivot
AS
(
    --Unpivot hale getirelim.
    SELECT *
    FROM cteSalesPivot
        UNPIVOT
            (
                SatisMiktari
                FOR Yillar IN ("2005","2006","2007","2008")
            ) unp
)

--T�m d�n�?�mler CTE olarak kay?tl? istedi?ime ula?abilirim.
--SELECT * FROM cteSales;
--SELECT * FROM cteSalesPivot;
SELECT * FROM cteSalesPivotUnPivot;

        
    
    