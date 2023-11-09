/*
    Veri Tipi:
        memory'de gecici, diskte kal?c? veri tutar?z.
        
    T�m i?lemler memoryde olur. log dosyas?na ne yap?ld???na dair �zet yaz?l?r. 
    Belli aral?klarla veri sonun hali diske yaz?l?r.
    
    Tablodakiler nihyetinde diske kal?c? olarak yaz?l?r.
    degiskenlerdeki veriler memoryde tutlur ve bu veri ge�icidir.
*/

/*
    De?i?ken tan?mlama:
    DECLARE ile PL/SQL i�inde de?i?ken tan?mlanabilir. Oracle'?n SQL d???nda bir yetene?idir.
    VAR veya &degiskeAd ?eklinde de?i?ken de tan?mlanabilir. Gecici de?i?ken. SQL Plus arac?nn �zelli?idir.
    
    De?i?kene de?er atamak i�in
    :=
*/
DECLARE
    v_renk nvarchar2(50); -- de?i?en uzunluk unicode karekter tutar. 50 karektere kadar.
    v_toplam NUMBER(12,4); -- 12 haneli, virg�lden 4 basamak olsun
    v_ortalama NUMBER(12,4);
    v_adet NUMBER(10); --int e tekab�l eder.
BEGIN
    v_renk := 'Red'; --de?i?kene de?er atad?k.
    
    SELECT
        SUM(ListPrice),
        AVG(ListPrice),
        COUNT(*)
    INTO --sonu�lar? ba?ka bir tablo veya de?i?kenelere g�nderebiliriz.
        v_toplam,
        v_ortalama,
        v_adet        
    FROM adv_Product
    WHERE Color = v_renk;
    
    --De?i?kendeki de?erleri kullanabiliriz.
    --Debug ama�l? olarak View/DBMS Output pencersinden a?a??daki komutla takip edebilrsiniz.
    DBMS_OUTPUT.PUT_LINE('Toplam Fiyat:' || v_toplam); 
END;


/*
    Var ile de?i?ken tan?mlama
    SQLPlus ve PL/SQL geli?tirme ortamlar?nda : ile bu de?i?kenler �a??r?labilir. := ile de?er atababilir.
    :degiskenAdi ile var ile tan?mlad???m?z de?i?kenlere at?fta bulunuyoruz.
*/
VAR v_mesaj NVARCHAR2(100);
BEGIN
    :v_mesaj := 'merhaba d�nyal?';
END;

--/ ile yukat?daki b�l�m� �nce �al??t?r sonra a?a??dakine ge�
/
PRINT v_mesaj;

/*
    & ile d??ar?ndan de?er isteyebiliriz.
    
    ACCEPT ve PROMPT ile �?kacak textbox?n mesaj?n? d�zenleyebiliriz.
*/
ACCEPT renk PROMPT 'L�tfen bir renk giriniz:'
SELECT *
FROM adv_product
WHERE Color = '&renk'; --ACCEPT kullanmadan da direk yazd???m?z de?er isteyecek.

/*
    Tablo Olu?turmak ve G�ncelleme
    CREAT ile tablo olu?turulur
    DROP ile tablo kald?r?l?r.
    
    INSERT ile kay?t gireriz
    UPDATE ile kay?tlar g�ncellenir
    DELETE ile kay?tlar silinir
    
    TRUNCATE ile tablo i�eri?i tek sefer bo?alt?l?r. Bu i?lem ROLLBACk ile geri al?namaz.
*/
--DROP TABLE Urunler
CREATE TABLE Urunler
(
    Ad nvarchar2(50),
    Fiyat number(12,2)
)

--Kay?t girmek i�in INSERT
INSERT INTO Urunler(Ad,Fiyat) VALUES('Elma',100);
INSERT INTO Urunler VALUES('Erik',200);

--
SELECT * FROM Urunler;

--G�ncellemek i�in UPDATE
UPDATE Urunler
SET Fiyat = Fiyat *10
    --,Ad = UPPER(Ad) --10 kat?na �?karal?m. birden fazla kolon virg�llerle belirtilebilir
WHERE Ad='Elma';

--
SELECT * FROM Urunler;

--Kay?t silmek i�in DELETE
DELETE Urunler
WHERE Ad='Elma'; -- ?art konmazsa t�m veriyi siler.

--
SELECT * FROM Urunler;

/*
    Auto Commit �zelli?i kapal? olan serverlarda 
    i?lemleri kal?c? hale gelmesi i�in a�?kca COMMIT yazmak gerekir.
    ??lemleri geri almak i�in ROLLBACK yazmak gerekir.
    
    �?karken SQL Developer uyar?yor.
*/

COMMIT; --Kal?c? hale gelir.
--ROLLBACK; -- i?lemleri geri al?r.

--T�m tabloyu geri d�n�lemez ?ekilde bo?altmak i�in TRUNCATE 
TRUNCATE TABLE Urunler;

--Truncate sonras? tablo bo?.
SELECT * FROM Urunler;

