/*
    ORDER BY
    
    Sonuçlar? belirtilen alana göre s?ralayabiliriz.
    ORDER BY ?fadesi hep en sona yaz?l?r.
    ORDER BY expression ...
        DESC: z-a veya büyükten küçü?e s?ralar.
        ASC : a-z veya küçükten büyü?e s?ralar. Varsay?lan ayar budur.
    
    --Yaz?m kal?b?
    ORDER BY kolon|alias|KolonS?ranumarasi ASC|DESC
    NULLS Last|First 
*/
-- ListPrice alan?na göre s?ralauyal?m
SELECT
    Name,
    ListPrice
FROM adv_product
--ORDER BY ListPrice; küçükten büyü?e s?ralar.
--ORDER BY ListPrice ASC; --küçükten büyü?e s?ralar.
ORDER BY ListPrice DESC; --büyükten küçü?e s?ralar.

-- Renge göre z-a s?ralayal?m.
SELECT
    Name,  --1. kolon
    Color as Renk --alias verelim --2. kolon
FROM adv_Product
--ORDER BY Color DESC -- kolon verilebilir.
--ORDER BY Renk DESC --alias ile kolon tarif edilebilir
ORDER BY 2 DESC --kolon s?ra numars? vebilir. SELECT içerisindeki s?ra verilir. s?ra 1 den ba?lar.
--NULLS FIRST; --NULL de?erler en ba?ta görünsün
NULLS LAST; --varsay?lan FIRST olur. Last ise NULL de?erler sona gelir.

--Q&A: Fiyat? 100 ile 1000 aras?nda olan k?rm?z? renkli ürünleri pahal?dan ucuza s?ralayal?m.
--Color ve ListPrice
SELECT
    Name,
    --Color, --Where'de kulland???m?z SELECT de belirtmek zorunda de?iliz.
    ListPrice
FROM adv_Product
WHERE ListPrice BETWEEN 100 AND 1000 AND Color = 'Red'
ORDER BY ListPrice DESC;

/*
    En pahal? n ürün gelsin sorusu farkl? ürünlerde TOP veya LIMIT ile yap?labilyor.
    Fakat Oracle böyle pratik bir keyword yok. Onun yerine ROWNUM isimli psudo kolon kullan?l?r.
    
    ROWNUM her sat?r için bir s?ra numaras? üretir.
    s?ra numaras? ORDER BY çal??madan önce üretilir. Dikkat!!!
*/
SELECT
    Name,
    Color,
    ListPrice,
    ROWNUM as "SiraNumarasi" --S?ra numaras? üretir. ORDER BY'dan önce sat?r?n s?ra nuamras?n? atanm?? olur.
FROM adv_Product
WHERE Color IN ('Red','Black')
ORDER BY ListPrice DESC;


-- En pahal? 5 ürün gelsin.
--Inline View yöntemi ile sorgu sonucunu FROM (sorguSonucu)  ile tekrar sorgulayabiliriz.
SELECT
    Name,
    ListPrice,
    ROWNUM
FROM 
    (
        SELECT
            Name,
            Color,
            ListPrice
        FROM adv_Product
        WHERE Color IN ('Red','Black')
        ORDER BY ListPrice DESC
    )
WHERE ROWNUM<=5;

/*
    OFFSET - FETCH
    Oracle 12c  sonras?nda kullan?labilir.
    
    ORDER BY sonras?nda kullan?l?r ve devreye girer.
    n satir atla m satir getir dememizi sa?l?yor. web sitelerindeki paging özelli?i gibi.
    OFFSET n ROW: n satir atla
    FETCH FIRST|NEXT m ROWS : sonraki m satir gelsin.
*/

-- en pahal? ilk 5 ürün gelsin.
SELECT
    Name,
    ListPrice
FROM adv_Product
ORDER BY ListPrice DESC --büyükten küçü?e
    FETCH FIRST 5 ROWS ONLY; --FIRST yerine NEXT, ROW yerine ROWS yaz?labilir. 5 sat?r? getir.

-- En pahal? üçüncü 5 ürün gelsin. yani 10-15 aras?dakiler 10 sat?r atla sonraki 5 tanesini getir.
SELECT
    Name,
    ListPrice
FROM adv_Product
ORDER BY ListPrice DESC --büyükten küçü?e
    OFFSET 10 ROWS --10 sat?r atla
    FETCH FIRST 5 ROWS ONLY; --sonraki 5 sat?r? getir.
    
    
--Q&A: Sayfalama örne?i yapal?m. 
--Color alan? NULL olmayan en ucuz ürünler için sayfalama örne?i yapal?m.
--textbox(prompt ekran?) aç?ls?n. sayfa numaras?n? girelim. o sayfada olmas? gereken sat?rlar listelensin.
--her sayfada 3 ürün olsun.
--&sayfa ile gecici de?i?ken tan?mlan?r. Sorgu her çal??t???nda de?i?ken de?eri kullan?c?dan istenir.
-- +,*, /, - ile matematikteki dört i?lem ifade edilebilir.
SELECT
    Name,
    Color,
    ListPrice
FROM adv_Product
WHERE Color IS NOT NULL
ORDER BY ListPrice ASC
    OFFSET (&sayfa-1)*3 ROWS
    FETCH NEXT 3 ROWS ONLY;


--------------------------
DESC adv_product;

SELECT
    *
FROM adv_Product
WHERE Color IN ('Red','Black','Silver')
      AND ListPrice <=100
      AND (SafetyStockLevel BETWEEN 10 AND 100 OR ProductSubCategoryID IS NULL)
ORDER BY SafetyStockLevel DESC
