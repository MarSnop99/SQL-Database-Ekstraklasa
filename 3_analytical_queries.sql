/*
Plik: 3_analytical_queries.sql

Ten skrypt zawiera kolekcję zapytań SELECT, które odpowiadają na typowe
 pytania biznesowe i analityczne dotyczące rozgrywek. Pokazują one, jak
 ze strukturyzowanych danych można uzyskać wartościowe insighty.
 Każde zapytanie jest poprzedzone komentarzem wyjaśniającym jego cel.

*/

-- Klasyfikacja najlepszych strzelców w lidze
-- Cel: Wygenerowanie rankingu zawodników na podstawie liczby zdobytych bramek.
--------------------------------------------------------------------------------
SELECT 
    z.Imie,
    z.Nazwisko,
    d.Nazwa AS NazwaDrużyny,
    SUM(sz.LiczbaGoli) AS SumaBramek
FROM 
    Zawodnik z
JOIN 
    StatystykiZawodnika sz ON z.ZawodnikID = sz.ZawodnikID
JOIN 
    Drużyna d ON z.DrużynaID = d.DrużynaID
WHERE 
    sz.LiczbaGoli > 0
GROUP BY 
    z.Imie, z.Nazwisko, d.Nazwa
ORDER BY 
    SumaBramek DESC;


