/*
    LIKE
    karekter bazl? arama yapmam?z? sa?lar.
    
    expression LIKE pattern [ ESCAPE 'escape_character' ]
    
    wildcard:
        % : s?f?r veya daha fazla karekter anlam?na gelir. adv_% adv_ ile ba?layan demektir.
        _ : tek karekter yerini tutar.
        
    örn:
    WHERE acikLama LIKE 'Kar yüzdesi !%20' ESCAPE '!';
    
    !% ile kaç?? karekteri !'nin sa??ndaki karekteri aynen metin olarak ara özel bir anlam yükleme demi? oluyoruz.
    'Kar yüzdesi %20' metnini ar?yoruz. Buradaki % wildcard olarak de?erlendirilmiyor metin içinde aran?yyor.
*/
DESC adv_Person;

-- ilk harfi s olan soyadlar (LastName) gelsin.
SELECT
    FirstName,
    LastName
FROM adv_Person
WHERE LastName LIKE 'S%'; --ilk harf S olsun geri kalan önemli de?il.

--Q&A:?lk iki harfi Sa olan son harfi z olan hangi soyadlar (LastName) var. Tekille?tirelim.
SELECT DISTINCT
    --FirstName,
    LastName
FROM adv_Person
WHERE LastName LIKE 'Sa%z'; --Sa ile ba?la z ile bit. aradakilerin önemi yok.

/*
    Q&A: FirstName alan?na bakal?m.
        1. harf keyfi olsun.
        2. harf i olsun.
        3. harf m olsun.
        
    Bu ?ekilde 3 harfli hangi adlar var. Tekille?tirelim.
*/
SELECT DISTINCT
    FirstName
FROM adv_Person
--WHERE FirstName LIKE '___'; --3 harfli isimler
WHERE FirstName LIKE '_im'; --3 karekterli olacak ilk karekterin ne oldu?u önemli de?il.

-- Q&A:FirstName alan?nda en az 2 tane a harfi olan adlar hangileri. Tekille?tirelim.
SELECT DISTINCT
  FirstName
FROM adv_Person
WHERE FirstName LIKE '%a%a%';

/*
   REGEXP_LIKE ( expression, pattern [, match_parameter ] )
   https://www.techonthenet.com/oracle/regexp_like.php
   https://regexr.com/3e48o
   
   Pattern:
   ^ : metnin ba??n? ifade eder.
   $ : metnin sonunu ifade eder.
   | : or anlam?na gelir.
   {}: karakterin tekrarlanma adedini belirtmemizi sa?lar. {2} ile 2 defa tekrar edilece?ini belirtiyoruz.
   []: alternatif karekterleri belirtmek için kullan?l?r.
        [a-z] : a ile z aras?ndaki harfler
        [0-9] : 0 ile 9 aras?daki say?lar
        [abml]: a,b,m,l harfleri
        [^a-z]: ^ ile not demi? oluyoruz. a-z aras?ndakiler olmas?n diyoruz.

    match_parameter:
    i: case insensitive
    c: case sensitive
*/
--LastName a olanlar:
SELECT DISTINCT
    LastName
FROM adv_Person
--WHERE REGEXP_LIKE(LastName,'a'); -- içerisinde a geçenler.
--WHERE REGEXP_LIKE(LastName,'ch|ba'); --ch veya ba geçenler
--WHERE REGEXP_LIKE(LastName,'Ch|Ba','c'); --Ch veya Ba geçenler, case sensitive
--WHERE REGEXP_LIKE(LastName,'^ch|^ba','i'); --ba?ta ch veya ba olanlar
--WHERE REGEXP_LIKE(LastName,'ch$|ba$','i'); --sonda ch veya ba olanlar
--WHERE REGEXP_LIKE(LastName,'^[c-e]','i'); --ilk harfi c ile e aras?nda olanlar
--WHERE REGEXP_LIKE(LastName,'^[c-e].a','i'); --ilk harfi c ile e aras?nda olanlar bir kaç karakter sonra a olanlar
--WHERE REGEXP_LIKE(LastName,'a{2}','i'); --yan yana 2 a olanlar gelsin.
--WHERE REGEXP_LIKE(LastName,'[ae]{2}','i'); --yan yana 2 defa a veya e olanlar gelsin.
WHERE REGEXP_LIKE(LastName,'a{2}','i') OR REGEXP_LIKE(LastName,'e{2}','i'); --2 tane aa veya ee olanlar gelsin

-- Q%A: FirstName alan?nda 1. harf k veya j olanlar gelsin. case insensitive (i)
SELECT DISTINCT
    FirstName
FROM adv_Person
WHERE REGEXP_LIKE(FirstName,'^[kj]','i');


/*
    Q&A: FirstName alan?na bakal?m
        - 1. karakter k veya j olsun
        - 2. karekter keyfi
        - 3. karekter m olsun
    
    geri kalanlar keyfi olsun.
*/
SELECT DISTINCT
    FirstName 
FROM adv_Person
WHERE REGEXP_LIKE(FirstName,'^[kj].{1}m','i');

/*
    Q&A: FirstName alan?na bakal?m
        - 1. karekter a olsun
        - 2. karekter keyfi
        - 3. a ile k aras?nda olmas?n
        - 4. keyfi
        - 5. karekter m olsun
        
        sonrakiler keyfi olsun
*/
SELECT DISTINCT
    FirstName 
FROM adv_Person
WHERE REGEXP_LIKE(FirstName,'^a.{1}[^a-k].{1}m','i');--Autumn