/*
    Windowing Functions
    - Tabloyu sorgularken tablo için pencereler (çerçeve) olu?turma ve bu çerçeveye özel bir tak?m i?lemler yapma imkan? verir.
    
    SUM,MAX,MIN gibi fonksiyonlar
    
    ROW_NUMBER() : o sat?r?n çerçeve içerisindeki s?ra numaras? nedir?
    RANK()       : ayn? de?ere sahip olanlar? ayn? s?ra numaras? verir. Sonraki s?ra numaras? önceki eleman say?s? dahil edilerek hesaplan?r.
    DENSE_RANK() : ayn? de?ere sahip olanlara ayn? s?ra numaras? verir.
    NTILE(n)      : n tane grup üretip sat?r?n hangi gruba dahil oldu?unu söyler
    
    FIRST_VALUE
    LAST_VALUE
    
    LEAD
    LAG 
    vs.
*/

SELECT
    Name,
    Color,
    ListPrice,
    
    --Over ile çerçeve olu?turduk. Herhangi bir parça (parittion) vermedi?imiz tüm tablo çerçevedir.
    ROW_NUMBER() OVER(ORDER BY ListPrice DESC) as RowNumber,
    RANK()  OVER(ORDER BY ListPrice DESC) as Rank, --ayn? de?erdekiler ayn? s?ra numaras?n? al?r.
    DENSE_RANK()  OVER(ORDER BY ListPrice DESC) as DenseRank,
    NTILE(2)  OVER(ORDER BY ListPrice DESC) as NTile, --n tane grup üretip sat?r?n hangi gruba dahil oldu?unu söyler
    
    --Çerçeveyi parçalara ay?ral?m (paritition yapal?m)
    --Color alan?na göre çerçeve ol??turduk çerçeveyi ListPrice a göre tersten s?ral?k. ROwn_Number s?ra numaras?n? al?yoruz.
    ROW_NUMBER() OVER(PARTITION BY Color ORDER BY ListPrice DESC) as Color_RN
    
FROM adv_Product
ORDER BY Color;-- parittion by ile çal??ken okumay? kolayla?t?racak.


--Q&A: Her alt kategorideki en pahal? ürün gelsin.
SELECT
    T.Name,
    T.ListPrice
FROM (
        SELECT
            Name,
            ListPrice,
            ProductSubCategoryId,
            ROW_NUMBER() OVER(PARTITION BY ProductSubCategoryId ORDER BY ListPrice DESC) as RN
        FROM Adv_Product
        )T
WHERE RN=1
ORDER BY T.ListPrice DESC;

/*
 LEAD, LAG Kullan?m?
    - Çerçeve içerisindeki Sat?rlarda ileri geri gitmemizi sa?lar.
*/
WITH cteOrders
AS
(
    SELECT
        t.SalesTerritoryCountry,
        EXTRACT(year from f.OrderDate) as OrderYear,
        SUM(f.SalesAmount) as TotalSalesAmount
    FROM adv_FactInternetSales f INNER JOIN adv_DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    GROUP BY t.SalesTerritoryCountry, EXTRACT(year from f.OrderDate)
    ORDER BY 1,2
)

--SELECT * FROM cteOrders;

--Q&A: Belirtilen y?l ve önceki y?l d?eerlerini çekelim. yanyana kolonlar olsun.
--Tabloyu kendisi ile joinleyerek önceki y?l?n de?erine ula?abiliriz.
--veya LEAD, LAG ile kolayca bu bilgileri alabiliriz.

,cteEskiYontemSelfJo?n
AS
(
    SELECT 
        mo.salesterritorycountry,
        MO.orderyear,
        mo.totalsalesamount as MO,
        
        oo.orderyear,
        oo.totalsalesamount as OO,
        
        ROUND((mo.totalsalesamount - oo.totalsalesamount)/oo.totalsalesamount,2) as BuyumeYuzdesi
    FROM cteOrders mo LEFT JOIN cteOrders oo
        ON mo.SalesTerritoryCountry = oo.SalesTerritoryCountry
           AND mo.OrderYear-1 = oo.OrderYear
)
       
 --SELECT * FROM cteOrders;      
---LEAD, LAG
--SELECT * FROM cteOrders;
SELECT
    SalesTerritoryCountry,
    OrderYear,
    TotalSalesAmount,
    
    --Bolgeye gore pencere ac?p hesap yapal?m
    SUM(TotalSalesAmount) OVER(PARTITION BY SalesTerritoryCountry) as BolgeToplami,    
    ROUND(TotalSalesAmount / SUM(TotalSalesAmount) OVER(PARTITION BY SalesTerritoryCountry),2) as BolgePayi,
    
    --
    FIRST_VALUE(TotalSalesAmount) OVER(PARTITION BY SalesTerritoryCountry ORDER BY OrderYear) as BolgeninIlkDegeri,
    LAST_VALUE(TotalSalesAmount) OVER(PARTITION BY SalesTerritoryCountry ORDER BY OrderYear) as BolgeninMevcutYilaKadarKiSonDegeri,
    LAST_VALUE(TotalSalesAmount) OVER(PARTITION BY SalesTerritoryCountry ORDER BY OrderYear 
                                                                         ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as SonYil,
    
    --
    --LEAD veya LAG (kolon, offset, BulunmazsaNeOlsun)
    --Lead ile ileri , Lag ile geri ama negatifi verilerek bir birinin yerine kullan?labilir.
    LEAD(TotalSalesAmount,1,NULL) OVER(PARTITION BY SalesTerritoryCountry ORDER BY OrderYear) as TakipEdenDeger,
    LAG(TotalSalesAmount,1,0) OVER(PARTITION BY SalesTerritoryCountry ORDER BY OrderYear) as OncekiDeger
FROM cteOrders;
/*
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
        - ?imdiki ile takip edenlerin en sonuna kadar
    ROWS BETWEEN UNBOUNDED PRECIDING AND CURRENT ROW
        - en ba?tan ?imdiki sat?ra kadar.
*/
