-- tek sat?rl?k yorumlar için
/*
    Çok sat?rl?
    yorumlar
    için
*/
------SELECT - FROM - WHERE -------
/*
    Komutlar? çal??t?rmak için
    1. F5 veya yukar?daki sayfa+play butonu ile tüm sayfadaki kodlar? s?rayla çal??t?r?rken.
    2. Ctrl + Enter veya yukar?daki play butonu ile seçti?iniz kod bölümünü çal??t?rabilirsiniz.
    
    Ç?kt? Pencereleri:
    1. Script OUTPUT
        - kullan?c?ya bilgi vermek amaçl? için kullan?l?r. Prompt veya F5 ile çal??t?ranlar
    2. Query Result Set
        - Tablo görünümünde sonuç al?r?z. Ctrl + Enter veya Play ile tablo format?nda ç?kt? verir.
*/
--OUTPUT
PROMPT 'Merhaba dünyal?' 

--F5 ile çal??t???nda output penceresinden görünür.
SELECT * FROM dual;

--Table Result
--SELECT 'Merhaba dünyal?'  ---hatad?r. illa tablo from table yazmak gerek.
SELECT * FROM dual; --dual tablosu oracle da içerisinde X kayd? bulunan bir sistem tablosudur.
SELECT 'Merhaba dünyal?' FROM dual;

--Baz? fonksiyonlardan bilgi almak için ve tablo format?nda görüntülemek için dual tablosunu kullan?r?z.
SELECT CURRENT_DATE, SYSDATE, LOCALTIMESTAMP, CURRENT_TIMESTAMP FROM dual;

--Oracle metadatas?n? tutan baz? nesneler var.
--Oracle hakk?nda güzel bilgiler bulundurur.
SELECT * FROM USER_TABLES;
SELECT * FROM V$VERSION;
SELECT * FROM V$DATABASE;

--https://docs.oracle.com/cd/B28359_01/server.111/b28310/tables014.htm#ADMIN01508
--Tüm Dynamic Performance Views
/*
SELECT 
   NAME, 
    TYPE
FROM 
   V$FIXED_TABLE
WHERE 
    NAME LIKE 'V$%';
*/
----------------
DESC adv_product;
DESCRIBE adv_product;

/*
    FROM
    tablo vari veri kaynaklar?ndan vveri çekmek için kullan?l?r.
    tablo, view, func vs.
*/
--çal??aca??m?z baz? tablolar
-- * ile kaynaktaki tüm kolonlar? talep ediyoruz.
SELECT * FROM adv_Product; --tablounun ad? adv_Product, orjinali user.tabloAdi ?eklidendir.
SELECT * FROM adv_Person;
SELECT * FROM adv_Employee;

-- Belli kolonlar? çekmek için kolonlar? , ile belirtiyoruz.
--ctrl + space ile intellicene den yard?m alabilrisiniz.
SELECT Name,Color,ListPrice FROM adv_Product;

--Scripti birden fazla sat?rda da yazabiliriz.
--Sonunda ; olmas?na dikkat edellim. Bu anlaml? kod parças?n?n tamamland???n? gösterir.
SELECT
    Name,
    Color,
    ListPrice
FROM adv_Product;

/*
    WHERE
    Kaynaktan çekece?imz Sat?rlar? filtrelemek için kullan?l?r
    WHERE ifadesi FROM'dan sonra yaz?l?r.
    
    Where ?art ?eklinde yaz?l?r.
    ?art True/False üretmeli.
*/
--Color alan? Red olan ürünler gelsin.
SELECT
    Name,
    Color,
    ListPrice
FROM adv_Product
WHERE Color = 'Red'; -- metinler Shift + 2 ile olu?turulan '  içerisinde yaz?l?r.

/*
    Kar??la?t?rma Operatorleri
    =
    <, >, <=, >=
    
    # a?a??dakiler e?it de?ildir için
    <>, !=, ^=
*/

--ProductID alan? 4 olmayanlar? getirelim.
SELECT
    ProductID,
    Name,
    ListPrice
FROM adv_Product
WHERE ProductID != 4;

--Q&A: ListPrice alan? 400'den büyük olanlar gelsin.
Select
    ProductID,
    Name,
    ListPrice
from adv_Product
where ListPrice > 400;

--Q&A: 01-JUL-2005 sipari? tahindeki sipari?ler gelsin. adv_FactInternetSales
DESC adv_FactInternetSales;

--
SELECT 
    *
FROM adv_FactInternetSales
--WHERE OrderDate = '01-JUL-2005'; --metinsel veri otomatik tarihsel veriye dönü?ür.
--WHERE OrderDate = TO_DATE('01.07.2005','dd.mm.yyyy') --TO_DATE(tarihMetni, formatString) dd: day, mm: ay, yyyy: y?l
--WHERE OrderDate = DATE '2005-07-01'; --DATE ile iso format?ndaki tarihi tarih tipine çevirebilriiz. y?l-ay-gün
WHERE EXTRACT(year from OrderDate) = 2005; --Extract ile OrderDate kolonundan y?l? ald?k 2005 olanlar? listeledik.

/*
    BETWEEN ... AND ...
    ile Aral?k belritebiliriz.
    Oracle'da alt ve üst s?n?r dahildir.
*/
--Fiyat? 100 ile 400 aras?nda olan ürünler gelsin.
SELECT
    Name,
    ListPrice
FROM adv_Product
WHERE ListPrice BETWEEN 100 AND 400; --alt ve üst s?n?r dahil.

/*
    Mant?ksal Operatorler
    AND : ifadedenin her iki taraf? True üretirse sonuç True olur.
    OR  : ifadenin herhangi bir taraf? True üretirse sonuç True olur.
    NOT : ifadenin sa??ndaki mant?ksal ?art? tersine çevirir.
*/


