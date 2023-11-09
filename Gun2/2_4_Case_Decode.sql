/*
    herhangi bir ?arta göre de?er üretmek için CASE ve DECODE kullan?l?r?z.
    
    CASE
        WHEN ..?art... THEN ..deger..
        WHEN ..?art... THEN ..deger..
        ELSE ..diger.
    END
    
    ----
    DECODE(kolon,
                deger1Ise,sonuc1,
                deger2Ise,sonuc2,
                digerDurumlardakiSonuc)
*/

SELECT
    Name,
    ListPrice,
    
    --when ile ?art belirttik
    CASE
        WHEN ListPrice=0 THEN 'Ücretsiz'
        WHEN ListPrice>0 AND ListPrice <100 THEN 'Ucuz'
        WHEN ListPrice BETWEEN 100 AND 1000 THEN 'Pahal?'
        ELSE 'Ak?l d???'
    END as "Etiket",
    
    --Do?rudan de?erlerle kar??la??ld???nda yap?lacaklar? belirtmek için
    --ListPrice 0 ise ücretli geri kalan durumlarda ücretsiz yazs?n
    CASE ListPrice
        WHEN 0 THEN 'Ücretsiz'
        ELSE 'Ücretli'
    END as "Etiket 2",
    
    --DECODE ile
    DECODE(ListPrice,  
                    0,'Ücretsiz'
                    ,'Ücretli') as "Etiket 3"
FROM adv_Product;

/*
    Q&A:
        Erkekler için:
            Ya? 
                <50 ise Genç Erkek
                >=50 ise olgun Erkek
        Kad?nlar için:
            Kad?n
*/
--M erkek ve F kad?n
SELECT
    ROUND((CURRENT_DATE - BirthDate)/365),
    Gender,
    CASE
        WHEN Gender='M' AND ROUND((CURRENT_DATE - BirthDate)/365)<50 THEN 'Genç Erkek'
        WHEN Gender='M' AND ROUND((CURRENT_DATE - BirthDate)/365)>=50 THEN 'Olgun Erkek'
        WHEN Gender='F' THEN 'Kadin'
        ELSE 'Bilinmiyor'
    END as Etiket
FROM adv_Employee;

--Q&A: 0-24, 25-49, 50-70, 70+ ya? aral?klar?nda kaçar ki?i var.
SELECT
    CASE 
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 0 AND 24 THEN '0-24'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 25 AND 49 THEN '25-49'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 50 AND 70 THEN '50-70'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) >70 THEN '70+'
        ELSE 'Bilinmiyor'
    END as "Gruplar",
    COUNT(*)
FROM adv_Employee
GROUP BY 
    CASE 
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 0 AND 24 THEN '0-24'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 25 AND 49 THEN '25-49'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) BETWEEN 50 AND 70 THEN '50-70'
        WHEN ROUND((CURRENT_DATE - BirthDate)/365) >70 THEN '70+'
        ELSE 'Bilinmiyor'
    END;

