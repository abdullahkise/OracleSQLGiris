/*
    Builtin yani Oracle kurulumuyla gelen sistemdeki fonksiyonlar
    https://www.techonthenet.com/oracle/functions/index.php
*/
--listesi
SELECT DISTINCT
    object_name
FROM all_arguments
WHERE package_name='STANDARD';

-- 
/*
    String/Char Functions
*/
SELECT
    ASCII('A'), -- 65 A harfinin ASCII kodu
    CHR(65), --65 ASCII kodun kar??l???
    
    CONCAT('Abdullah','Kise'),
    'Abdullah'||'Kise',
    
    RTRIM('Nas?ls?n?','?'), --LTRIM, RTRIM, TRIM
    
    UPPER('Merhaba'),
    LOWER('MeRHaba'),
    
    SUBSTR('Merhaba',2,3), --2. karekterden ba?la 3 karekter getir
    
    TRANSLATE('merhaba','a','x'), --a'lar? x'e �evir
    
    --3.paremtre zorunlu de?il
    REPLACE('merhaba','a','x'), --a yerine x yaz?l?r
    REPLACE('merhaba','a') --a temizlenir
FROM dual;

/*
    Numeric/Math Functions
*/
SELECT
    ROWNUM, --gelen sat?rlara numara atar
    
    POWER(3,2), --�s almamz? sa?lar. 3'�n karesi
    SQRT(4),--karek�k
    
    ABS(-3), --i?aretsiz hali, mutlak de?eri
    
    CEIL(3.2), --bir �st tam say?ya yuvarlar.
    ROUND(3.2), -- 0.5 �zerinde ise yukar? al?nda ise a?a?? yuvarlar.
    ROUND(3.27,1), --1 basamak kalacak ?ekilde yuvarlar
    
    TRUNC(3.2), --tam k?sm?
    TRUNC(3.23,1) --virg�lden sonra 1 basamak olsun
FROM dual;

/*
    Date/Time Functions
*/
SELECT
    CURRENT_DATE, --?imdinin tarihi
    SYSDATE, --?imdinin tarihi
    
    EXTRACT(year from CURRENT_DATE), --tarihn y?l?n? ver.
    EXTRACT(month from CURRENT_DATE), --ay?n? veri
    EXTRACT(day from CURRENT_DATE), --g�n�n� ver.
    
    TRUNC(CURRENT_DATE, 'MONTH'), --Aya g�re yuvarlad?. Ay?n ilk g�n�n� verdi.
    
    LAST_DAY(CURRENT_DATE), --Ay?n son g�n�ne ait tarih
    
    NEXT_DAY(CURRENT_DATE,'FRIDAY'), --�n�m�zdeki cuma hangi tarihe denk geliyor.
    NEXT_DAY('09-NOV-23','FRIDAY'), --'09-NOV-23' metnini oracle otomatik tarih olarak alg?lar.
    
    MONTHS_BETWEEN(CURRENT_DATE, '01-JAN-2023') --iki tarih aras?nda ka� ay var.
FROM dual;

/*
    Conversion Function
*/

SELECT
    CAST('12' as int), --'12' metnini int tipine �evir. iso standard?
    TO_NUMBER('12'), --metni say?ya �evir.
    
    CAST(12 as nvarchar2(2)), --12 say?s?n? 2 karekterli metne �evirdik nvarchar2 bir metinsel tiptir.
    TO_CHAR(12),
    
    TO_DATE('2023-11-09', 'yyyy-mm-dd'), --metni tarihe �evirdik
    DATE '2023-11-09' --iso format?ndaki metinleri tarihe �evirir.
FROM dual;

/*
    Advanced Function
    DECODE ve CASE ayr?ca inlenecek
*/

SELECT
    NVL(NULL, 'alternatif de?er'), --birinci parametre null ise ikinci paremtredeki de?er gelir.
    
    --ilk null olmayan? getir
    COALESCE(NULL,10,20),
    COALESCE(NULL,NULL,20,NULL),
    
    --iki de?er e?itse null �retsin de?ilse ikinci de?er gelsin.
    NULLIF(1,1),
    NULLIF(12,10)
FROM dual;