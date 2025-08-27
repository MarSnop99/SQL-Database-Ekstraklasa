/*
Plik: 3_analytical_queries.sql

Ten skrypt zawiera kolekcję zapytań SELECT, które odpowiadają na typowe
 pytania biznesowe i analityczne dotyczące rozgrywek. Pokazują one, jak
 ze strukturyzowanych danych można uzyskać wartościowe insighty.
 Każde zapytanie jest poprzedzone komentarzem wyjaśniającym jego cel.

*/


-- Zapytanie 1: Klasyfikacja najlepszych strzelców w lidze
-- Cel: Wygenerowanie rankingu zawodników na podstawie liczby zdobytych bramek.
--------------------------------------------------------------------------------
SELECT 
    z.Imie_i_Nazwisko AS Zawodnik,
    d.Nazwa_Druzyny,
    COUNT(b.Bramka_ID) AS SumaBramek
FROM 
    zawodnik z
JOIN 
    Bramka b ON z.zawodnik_ID = b.Zawodnik_ID
JOIN 
    Druzyna d ON z.Druzyna_ID = d.Druzyna_ID
GROUP BY 
    z.Imie_i_Nazwisko, d.Nazwa_Druzyny
ORDER BY 
    SumaBramek DESC;


-- Zapytanie 2: Pełna tabela ligowa
-- Cel: Obliczenie i wyświetlenie aktualnej tabeli ligowej z punktami, bilansem
--      zwycięstw, remisów, porażek oraz bilansem bramek.
-- Technika: Użycie CTE i UNION ALL do zsumowania wyników z perspektywy gospodarzy i gości.
--------------------------------------------------------------------------------
WITH WynikiMeczow AS (
    -- Wyniki z perspektywy gospodarzy
    SELECT
        gosp.Druzyna_ID,
        1 AS LiczbaMeczow,
        CASE 
            WHEN m.Wynik_Gospodarze > m.Wynik_Goscie THEN 3 
            WHEN m.Wynik_Gospodarze = m.Wynik_Goscie THEN 1 
            ELSE 0 
        END AS Punkty,
        CASE WHEN m.Wynik_Gospodarze > m.Wynik_Goscie THEN 1 ELSE 0 END AS Zwyciestwa,
        CASE WHEN m.Wynik_Gospodarze = m.Wynik_Goscie THEN 1 ELSE 0 END AS Remisy,
        CASE WHEN m.Wynik_Gospodarze < m.Wynik_Goscie THEN 1 ELSE 0 END AS Porazki,
        m.Wynik_Gospodarze AS BramkiZdobyte,
        m.Wynik_Goscie AS BramkiStracone
    FROM Mecz m
    JOIN Gospodarze gosp ON m.Gospodarze_ID = gosp.Gospodarze_ID

    UNION ALL
    
    -- Wyniki z perspektywy gości
    SELECT
        gosc.Druzyna_ID,
        1 AS LiczbaMeczow,
        CASE 
            WHEN m.Wynik_Goscie > m.Wynik_Gospodarze THEN 3 
            WHEN m.Wynik_Goscie = m.Wynik_Gospodarze THEN 1 
            ELSE 0 
        END AS Punkty,
        CASE WHEN m.Wynik_Goscie > m.Wynik_Gospodarze THEN 1 ELSE 0 END AS Zwyciestwa,
        CASE WHEN m.Wynik_Goscie = m.Wynik_Gospodarze THEN 1 ELSE 0 END AS Remisy,
        CASE WHEN m.Wynik_Goscie < m.Wynik_Gospodarze THEN 1 ELSE 0 END AS Porazki,
        m.Wynik_Goscie AS BramkiZdobyte,
        m.Wynik_Gospodarze AS BramkiStracone
    FROM Mecz m
    JOIN Goscie gosc ON m.Goscie_ID = gosc.Goscie_ID
)
SELECT 
    d.Nazwa_Druzyny AS Drużyna,
    SUM(wm.LiczbaMeczow) AS Mecze,
    SUM(wm.Punkty) AS Punkty,
    SUM(wm.Zwyciestwa) AS W,
    SUM(wm.Remisy) AS R,
    SUM(wm.Porazki) AS P,
    SUM(wm.BramkiZdobyte) AS BZ,
    SUM(wm.BramkiStracone) AS BS,
    SUM(wm.BramkiZdobyte) - SUM(wm.BramkiStracone) AS Bilans
FROM 
    WynikiMeczow wm
JOIN 
    Druzyna d ON wm.Druzyna_ID = d.Druzyna_ID
GROUP BY 
    d.Nazwa_Druzyny
ORDER BY 
    Punkty DESC, Bilans DESC;


-- Zapytanie 3: Najostrzejsi sędziowie w lidze
-- Cel: Ranking sędziów na podstawie łącznej liczby pokazanych kartek, z podziałem na kolory.
--------------------------------------------------------------------------------
SELECT
    s.Imie_i_Nazwisko AS Sędzia,
    COUNT(DISTINCT m.Mecz_ID) AS LiczbaSędziowanychMeczow,
    SUM(CASE WHEN k.Kolor_Kartki = 'Żółta' THEN 1 ELSE 0 END) AS SumaZoltychKartek,
    SUM(CASE WHEN k.Kolor_Kartki = 'Czerwona' THEN 1 ELSE 0 END) AS SumaCzerwonychKartek,
    COUNT(k.Kartka_ID) AS LacznaLiczbaKartek
FROM
    Sedzia s
JOIN
    Mecz m ON s.Sedzia_ID = m.Sedzia_ID
JOIN
    Kartka k ON m.Mecz_ID = k.Mecz_ID
GROUP BY
    s.Imie_i_Nazwisko
ORDER BY
    LacznaLiczbaKartek DESC;


-- Zapytanie 4: Stadiony z największą liczbą bramek
-- Cel: Analiza, na których stadionach pada najwięcej bramek, zarówno w sumie, jak i średnio na mecz.
--------------------------------------------------------------------------------
SELECT
    st.Nazwa_Stadionu AS NazwaStadionu,
    COUNT(m.Mecz_ID) AS LiczbaMeczow,
    SUM(m.Wynik_Gospodarze + m.Wynik_Goscie) AS LacznaLiczbaBramek,
    AVG(CAST(m.Wynik_Gospodarze + m.Wynik_Goscie AS decimal(5,2))) AS SrednioBramekNaMecz
FROM
    Stadion st
JOIN
    Mecz m ON st.Stadion_ID = m.Stadion_ID
GROUP BY
    st.Nazwa_Stadionu
ORDER BY
    SrednioBramekNaMecz DESC;


-- Zapytanie 5: Najlepsi asystenci w lidze
-- Cel: Wygenerowanie rankingu zawodników na podstawie liczby zanotowanych asyst.
--------------------------------------------------------------------------------
SELECT 
    z.Imie_i_Nazwisko AS Zawodnik,
    d.Nazwa_Druzyny,
    COUNT(a.Asysta_ID) AS SumaAsyst
FROM 
    zawodnik z
JOIN 
    Asysta a ON z.zawodnik_ID = a.Zawodnik_ID
JOIN 
    Druzyna d ON z.Druzyna_ID = d.Druzyna_ID
GROUP BY 
    z.Imie_i_Nazwisko, d.Nazwa_Druzyny
ORDER BY 
    SumaAsyst DESC;


