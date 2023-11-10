/*
    SubQuery:
        - Bazen problemleri tek bir select scripti ile çözemeyebiliriz.
        Alt scriptlere ay?r?p problemleri parça parça çözüp bir le?tirmek isteyebiliriz.
        Bu durumda SubQuery kullan?m? çok i?imize yarar.
        
        SubQuyerler ile JOINler hemen hemen ayn? sonucu almam?z? sa?lar.
        SubQueryler ile daha fazla esneklik kazanabiliriz.
        
        Alt sorgu sonucunu üst sorguya gönderebiliriz.
        Alt sorgu üst sogu ile birlite çal??abilr. 32 seviye sorgu olu?turulabilir.
*/

--Pumps alt kategorisindeki ürünleri getirelim.
--JOIN ile 
SELECT
    p.Name,
    p.Color,
    p.ListPrice
FROM Adv_Product p INNER JOIN Adv_ProductSubCategory sc
    ON p.ProductSubCategoryId = sc.ProductSubCategoryId
WHERE sc.Name = 'Pumps';

--SubQuery ile
/*
    Inner SubQuery
    içsel alt sorgu WHERE, HAVING veya FROM bölümde kullan?l?r.
*/
--2. problemin 2. basama?? o alt kategorideki ürün bilgilerini almak
SELECT
    Name,
    Color,
    ListPrice
FROM Adv_Product
WHERE ProductSubCategoryId = 
                            (
                                --1.Problemin ilk basama?? Pumps altgori Id sine ula?mak
                                SELECT
                                    ProductSubCategoryId
                                FROM Adv_ProductSubCategory
                                WHERE Name='Pumps'
                            );
                            
/*
    Scaler SubQuery
    Alt sorgudan tek bir de?er döner.
    SELECT bölümünde bir SubQuery ?eklinde görebiliriz.
*/
SELECT
    Name,
    ListPrice,
    (SELECT MAX(ListPrice) FROM Adv_Product) as "En Yüksek Fiyat"
FROM Adv_Product;

/*
    Multi-Row SubQuery
    Alt sorgudan birden fazla sat?r gelir.
    IN, ALL, ANY gibi operatorler kullan?l?r.
*/
--1 Id li categoryye ait ürünler gelsin
SELECT
    Name,
    ListPrice
FROM Adv_Product 
WHERE ProductSubCategoryId IN (
                                SELECT
                                    ProductSubCategoryId
                                FROM Adv_ProductSubCategory
                                WHERE ProductCategoryId=1
                               );--1,2,3

--Q&A: En son sipari? tarihinde verilern tüm sipari?ler gelsin.
--Adv_FactInternetSales
--OrderDate
SELECT
    *
FROM Adv_FactInternetSales
WHERE OrderDate = (
                    SELECT
                        MAX(OrderDate)
                    FROM Adv_FactInternetSales
                    );

--Q&A: En pahal? ürünle ayn? alt kategorideki di?er ürünleri listeleyelim.
SELECT
    *
FROM adv_Product
WHERE ProductSubCategoryId IN (
                                SELECT DISTINCT
                                    ProductSubCategoryId
                                FROM Adv_Product
                                WHERE Listprice = (
                                                    SELECT
                                                        MAX(ListPrice)
                                                    FROM Adv_Product
                                                  )
                                );
                                
/*
    IN ile üye kontrolü yap?l?yor.
    ANY ise herhangi birini ifade eder. >,< vs. operatorleriyle kullan?l?r. Mesela herhangi birinden büyük olan diyebiliriz.
    ALL tüm üyeleri ifade eder. ANY gibi operatorlerle kullan?l?r.
*/
--Bisiket kategorisine ait alt kategorilerden olmayan ürünleri getirelim.
--Alt sorgudan dönen tüm ProductSubCategoryId'den farkl? olanlar? getiriyoruz.
SELECT
    *
FROM Adv_Product
--!= ANY ile bunlardan herhangi birinden farkl? SubCategoryId'ye sahip olan gelsin.
--!= ALL ile hepsindne farkl? SubCategoryId'ye sahip olan gelsin.
WHERE ProductSubCategoryId != ALL (
                                    SELECT
                                        ProductSubCategoryId
                                    FROM Adv_ProductSubCategory
                                    WHERE ProductCategoryId=1 --Bikes kategorisine odaklan?k.
                                   );
                               
/*
    Correlated SubQuery
    Baglant?l? alt sorgu, ana sorgu ile ili?kilendirilerek çal???r.
    Alt sorgu üst sorgudan bilgi al?r her sat?r alt sorgu çal??t?r?l?r.
*/
SELECT
    Name,
    Color,
    ListPrice
FROM Adv_Product p
WHERE p.ProductSubCategoryId = (
                                SELECT
                                    ProductSubCategoryId
                                FROM Adv_ProductSubCategory sc
                                WHERE sc.ProductSubCategoryId = p.ProductSubCategoryId --ayn? alt kategoriye sahip mi
                                );
                                
/*
    EXISTS ile alt sorgudan sonuç dönüyorsa üst sorgudaki sat?r gelsin diyebiliriz.
*/
--Sipari?i olan mü?teriler gelsin.
SELECT
    c.FirstName,
    c.LastName,
    c.Gender
FROM Adv_DimCustomer c
WHERE EXISTS(
                SELECT
                    1 --sadece sat?r dönmesi önemli
                FROM adv_FactInternetSales f
                WHERE c.CustomerKey = f. CustomerKey
            );