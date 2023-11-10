/*
    SubQuery:
        - Bazen problemleri tek bir select scripti ile ��zemeyebiliriz.
        Alt scriptlere ay?r?p problemleri par�a par�a ��z�p bir le?tirmek isteyebiliriz.
        Bu durumda SubQuery kullan?m? �ok i?imize yarar.
        
        SubQuyerler ile JOINler hemen hemen ayn? sonucu almam?z? sa?lar.
        SubQueryler ile daha fazla esneklik kazanabiliriz.
        
        Alt sorgu sonucunu �st sorguya g�nderebiliriz.
        Alt sorgu �st sogu ile birlite �al??abilr. 32 seviye sorgu olu?turulabilir.
*/

--Pumps alt kategorisindeki �r�nleri getirelim.
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
    i�sel alt sorgu WHERE, HAVING veya FROM b�l�mde kullan?l?r.
*/
--2. problemin 2. basama?? o alt kategorideki �r�n bilgilerini almak
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
    Alt sorgudan tek bir de?er d�ner.
    SELECT b�l�m�nde bir SubQuery ?eklinde g�rebiliriz.
*/
SELECT
    Name,
    ListPrice,
    (SELECT MAX(ListPrice) FROM Adv_Product) as "En Y�ksek Fiyat"
FROM Adv_Product;

/*
    Multi-Row SubQuery
    Alt sorgudan birden fazla sat?r gelir.
    IN, ALL, ANY gibi operatorler kullan?l?r.
*/
--1 Id li categoryye ait �r�nler gelsin
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

--Q&A: En son sipari? tarihinde verilern t�m sipari?ler gelsin.
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

--Q&A: En pahal? �r�nle ayn? alt kategorideki di?er �r�nleri listeleyelim.
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
    IN ile �ye kontrol� yap?l?yor.
    ANY ise herhangi birini ifade eder. >,< vs. operatorleriyle kullan?l?r. Mesela herhangi birinden b�y�k olan diyebiliriz.
    ALL t�m �yeleri ifade eder. ANY gibi operatorlerle kullan?l?r.
*/
--Bisiket kategorisine ait alt kategorilerden olmayan �r�nleri getirelim.
--Alt sorgudan d�nen t�m ProductSubCategoryId'den farkl? olanlar? getiriyoruz.
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
    Baglant?l? alt sorgu, ana sorgu ile ili?kilendirilerek �al???r.
    Alt sorgu �st sorgudan bilgi al?r her sat?r alt sorgu �al??t?r?l?r.
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
    EXISTS ile alt sorgudan sonu� d�n�yorsa �st sorgudaki sat?r gelsin diyebiliriz.
*/
--Sipari?i olan m�?teriler gelsin.
SELECT
    c.FirstName,
    c.LastName,
    c.Gender
FROM Adv_DimCustomer c
WHERE EXISTS(
                SELECT
                    1 --sadece sat?r d�nmesi �nemli
                FROM adv_FactInternetSales f
                WHERE c.CustomerKey = f. CustomerKey
            );