-- tek sat?rl?k yorumlar i�in
/*
    �ok sat?rl?
    yorumlar
    i�in
*/
------SELECT - FROM - WHERE -------
/*
    Komutlar? �al??t?rmak i�in
    1. F5 veya yukar?daki sayfa+play butonu ile t�m sayfadaki kodlar? s?rayla �al??t?r?rken.
    2. Ctrl + Enter veya yukar?daki play butonu ile se�ti?iniz kod b�l�m�n� �al??t?rabilirsiniz.
    
    �?kt? Pencereleri:
    1. Script OUTPUT
        - kullan?c?ya bilgi vermek ama�l? i�in kullan?l?r. Prompt veya F5 ile �al??t?ranlar
    2. Query Result Set
        - Tablo g�r�n�m�nde sonu� al?r?z. Ctrl + Enter veya Play ile tablo format?nda �?kt? verir.
*/
--OUTPUT
PROMPT 'Merhaba d�nyal?' 

--F5 ile �al??t???nda output penceresinden g�r�n�r.
SELECT * FROM dual;

--Table Result
--SELECT 'Merhaba d�nyal?'  ---hatad?r. illa tablo from table yazmak gerek.
SELECT * FROM dual; --dual tablosu oracle da i�erisinde X kayd? bulunan bir sistem tablosudur.
SELECT 'Merhaba d�nyal?' FROM dual;

--Baz? fonksiyonlardan bilgi almak i�in ve tablo format?nda g�r�nt�lemek i�in dual tablosunu kullan?r?z.
SELECT CURRENT_DATE, SYSDATE, LOCALTIMESTAMP, CURRENT_TIMESTAMP FROM dual;

--Oracle metadatas?n? tutan baz? nesneler var.
--Oracle hakk?nda g�zel bilgiler bulundurur.
SELECT * FROM USER_TABLES;
SELECT * FROM V$VERSION;
SELECT * FROM V$DATABASE;

--https://docs.oracle.com/cd/B28359_01/server.111/b28310/tables014.htm#ADMIN01508
--T�m Dynamic Performance Views
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
    tablo vari veri kaynaklar?ndan vveri �ekmek i�in kullan?l?r.
    tablo, view, func vs.
*/
--�al??aca??m?z baz? tablolar
-- * ile kaynaktaki t�m kolonlar? talep ediyoruz.
SELECT * FROM adv_Product; --tablounun ad? adv_Product, orjinali user.tabloAdi ?eklidendir.
SELECT * FROM adv_Person;
SELECT * FROM adv_Employee;

-- Belli kolonlar? �ekmek i�in kolonlar? , ile belirtiyoruz.
--ctrl + space ile intellicene den yard?m alabilrisiniz.
SELECT Name,Color,ListPrice FROM adv_Product;

--Scripti birden fazla sat?rda da yazabiliriz.
--Sonunda ; olmas?na dikkat edellim. Bu anlaml? kod par�as?n?n tamamland???n? g�sterir.
SELECT
    Name,
    Color,
    ListPrice
FROM adv_Product;

/*
    WHERE
    Kaynaktan �ekece?imz Sat?rlar? filtrelemek i�in kullan?l?r
    WHERE ifadesi FROM'dan sonra yaz?l?r.
    
    Where ?art ?eklinde yaz?l?r.
    ?art True/False �retmeli.
*/
--Color alan? Red olan �r�nler gelsin.
SELECT
    Name,
    Color,
    ListPrice
FROM adv_Product
WHERE Color = 'Red'; -- metinler Shift + 2 ile olu?turulan '  i�erisinde yaz?l?r.

/*
    Kar??la?t?rma Operatorleri
    =
    <, >, <=, >=
    
    # a?a??dakiler e?it de?ildir i�in
    <>, !=, ^=
*/

--ProductID alan? 4 olmayanlar? getirelim.
SELECT
    ProductID,
    Name,
    ListPrice
FROM adv_Product
WHERE ProductID != 4;

--Q&A: ListPrice alan? 400'den b�y�k olanlar gelsin.
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
--WHERE OrderDate = '01-JUL-2005'; --metinsel veri otomatik tarihsel veriye d�n�?�r.
--WHERE OrderDate = TO_DATE('01.07.2005','dd.mm.yyyy') --TO_DATE(tarihMetni, formatString) dd: day, mm: ay, yyyy: y?l
--WHERE OrderDate = DATE '2005-07-01'; --DATE ile iso format?ndaki tarihi tarih tipine �evirebilriiz. y?l-ay-g�n
WHERE EXTRACT(year from OrderDate) = 2005; --Extract ile OrderDate kolonundan y?l? ald?k 2005 olanlar? listeledik.

/*
    BETWEEN ... AND ...
    ile Aral?k belritebiliriz.
    Oracle'da alt ve �st s?n?r dahildir.
*/
--Fiyat? 100 ile 400 aras?nda olan �r�nler gelsin.
SELECT
    Name,
    ListPrice
FROM adv_Product
WHERE ListPrice BETWEEN 100 AND 400; --alt ve �st s?n?r dahil.

/*
    Mant?ksal Operatorler
    AND : ifadedenin her iki taraf? True �retirse sonu� True olur.
    OR  : ifadenin herhangi bir taraf? True �retirse sonu� True olur.
    NOT : ifadenin sa??ndaki mant?ksal ?art? tersine �evirir.
*/


