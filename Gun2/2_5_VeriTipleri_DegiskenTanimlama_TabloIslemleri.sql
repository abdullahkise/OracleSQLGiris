/*
    Veri Tipi:
        memory'de gecici, diskte kal?c? veri tutar?z.
        
    Tüm i?lemler memoryde olur. log dosyas?na ne yap?ld???na dair özet yaz?l?r. 
    Belli aral?klarla veri sonun hali diske yaz?l?r.
    
    Tablodakiler nihyetinde diske kal?c? olarak yaz?l?r.
    degiskenlerdeki veriler memoryde tutlur ve bu veri geçicidir.
*/

/*
    De?i?ken tan?mlama:
    DECLARE ile PL/SQL içinde de?i?ken tan?mlanabilir. Oracle'?n SQL d???nda bir yetene?idir.
    VAR veya &degiskeAd ?eklinde de?i?ken de tan?mlanabilir. Gecici de?i?ken. SQL Plus arac?nn özelli?idir.
    
    De?i?kene de?er atamak için
    :=
*/
DECLARE
    v_renk nvarchar2(50); -- de?i?en uzunluk unicode karekter tutar. 50 karektere kadar.
    v_toplam NUMBER(12,4); -- 12 haneli, virgülden 4 basamak olsun
    v_ortalama NUMBER(12,4);
    v_adet NUMBER(10); --int e tekabül eder.
BEGIN
    v_renk := 'Red'; --de?i?kene de?er atad?k.
    
    SELECT
        SUM(ListPrice),
        AVG(ListPrice),
        COUNT(*)
    INTO --sonuçlar? ba?ka bir tablo veya de?i?kenelere gönderebiliriz.
        v_toplam,
        v_ortalama,
        v_adet        
    FROM adv_Product
    WHERE Color = v_renk;
    
    --De?i?kendeki de?erleri kullanabiliriz.
    --Debug amaçl? olarak View/DBMS Output pencersinden a?a??daki komutla takip edebilrsiniz.
    DBMS_OUTPUT.PUT_LINE('Toplam Fiyat:' || v_toplam); 
END;


/*
    Var ile de?i?ken tan?mlama
    SQLPlus ve PL/SQL geli?tirme ortamlar?nda : ile bu de?i?kenler ça??r?labilir. := ile de?er atababilir.
    :degiskenAdi ile var ile tan?mlad???m?z de?i?kenlere at?fta bulunuyoruz.
*/
VAR v_mesaj NVARCHAR2(100);
BEGIN
    :v_mesaj := 'merhaba dünyal?';
END;

--/ ile yukat?daki bölümü önce çal??t?r sonra a?a??dakine geç
/
PRINT v_mesaj;

/*
    & ile d??ar?ndan de?er isteyebiliriz.
    
    ACCEPT ve PROMPT ile ç?kacak textbox?n mesaj?n? düzenleyebiliriz.
*/
ACCEPT renk PROMPT 'Lütfen bir renk giriniz:'
SELECT *
FROM adv_product
WHERE Color = '&renk'; --ACCEPT kullanmadan da direk yazd???m?z de?er isteyecek.

/*
    Tablo Olu?turmak ve Güncelleme
    CREAT ile tablo olu?turulur
    DROP ile tablo kald?r?l?r.
    
    INSERT ile kay?t gireriz
    UPDATE ile kay?tlar güncellenir
    DELETE ile kay?tlar silinir
    
    TRUNCATE ile tablo içeri?i tek sefer bo?alt?l?r. Bu i?lem ROLLBACk ile geri al?namaz.
*/
--DROP TABLE Urunler
CREATE TABLE Urunler
(
    Ad nvarchar2(50),
    Fiyat number(12,2)
)

--Kay?t girmek için INSERT
INSERT INTO Urunler(Ad,Fiyat) VALUES('Elma',100);
INSERT INTO Urunler VALUES('Erik',200);

--
SELECT * FROM Urunler;

--Güncellemek için UPDATE
UPDATE Urunler
SET Fiyat = Fiyat *10
    --,Ad = UPPER(Ad) --10 kat?na ç?karal?m. birden fazla kolon virgüllerle belirtilebilir
WHERE Ad='Elma';

--
SELECT * FROM Urunler;

--Kay?t silmek için DELETE
DELETE Urunler
WHERE Ad='Elma'; -- ?art konmazsa tüm veriyi siler.

--
SELECT * FROM Urunler;

/*
    Auto Commit özelli?i kapal? olan serverlarda 
    i?lemleri kal?c? hale gelmesi için aç?kca COMMIT yazmak gerekir.
    ??lemleri geri almak için ROLLBACK yazmak gerekir.
    
    Ç?karken SQL Developer uyar?yor.
*/

COMMIT; --Kal?c? hale gelir.
--ROLLBACK; -- i?lemleri geri al?r.

--TÜm tabloyu geri dönülemez ?ekilde bo?altmak için TRUNCATE 
TRUNCATE TABLE Urunler;

--Truncate sonras? tablo bo?.
SELECT * FROM Urunler;

