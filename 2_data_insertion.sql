-- =================================================================
-- Plik 2: Wstawianie Przykładowych Danych (Sample Data)
-- Opis: Skrypt DML wstawiający komplet danych testowych.
-- UWAGA: Zachowano kolejność wstawiania ze względu na klucze obce.
-- =================================================================

-- 1. SŁOWNIKI (Druzyna, Stadion, Sedzia)

INSERT INTO Druzyna (Druzyna_ID, Akronim, Nazwa_Druzyny) VALUES
(1, 'LEG', 'Legia Warszawa'),
(2, 'WIS', 'Wisła Kraków'),
(3, 'LPO', 'Lech Poznań'),
(4, 'RCZ', 'Raków Częstochowa');

INSERT INTO Stadion (Stadion_ID, Nazwa_Stadionu, Miasto) VALUES
(1, 'Stadion Wojska Polskiego', 'Warszawa'),
(2, 'Stadion Miejski im. Reymana', 'Kraków'),
(3, 'Stadion Poznań', 'Poznań'),
(4, 'Miejski Stadion Piłkarski', 'Częstochowa');

INSERT INTO Sedzia (Sedzia_ID, Imie_i_Nazwisko, Miasto_Pochodzenia) VALUES
(1, 'Szymon Marciniak', 'Płock'),
(2, 'Tomasz Kwiatkowski', 'Warszawa'),
(3, 'Daniel Stefański', 'Bydgoszcz');

-- 2. ZAWODNICY (Powiązani z Drużynami)

INSERT INTO Zawodnik (Zawodnik_ID, Imie_i_Nazwisko, Druzyna_ID, Data_Urodzenia, Nominalna_pozycja) VALUES
-- Legia
(101, 'Josué Pesqueira', 1, '1990-09-17', 'Pomocnik'),
(102, 'Tomáš Pekhart', 1, '1989-05-26', 'Napastnik'),
(103, 'Artur Jędrzejczyk', 1, '1987-11-04', 'Obrońca'),
-- Wisła
(201, 'Jakub Błaszczykowski', 2, '1985-12-14', 'Pomocnik'),
(202, 'Ángel Rodado', 2, '1997-05-20', 'Napastnik'),
-- Lech
(301, 'Mikael Ishak', 3, '1993-03-31', 'Napastnik'),
(302, 'Jesper Karlström', 3, '1995-06-21', 'Pomocnik'),
-- Raków
(401, 'Ivi López', 4, '1994-06-29', 'Pomocnik'),
(402, 'Fran Tudor', 4, '1995-09-27', 'Obrońca');

-- 3. MECZE (Powiązane z Drużynami, Sędziami i Stadionami)

INSERT INTO Mecz (Mecz_ID, Gospodarze_ID, Goscie_ID, Wynik_Gospodarze, Wynik_Goscie, Stadion_ID, Sedzia_ID, Data_rozegrania) VALUES
(1001, 1, 2, '2', '1', 1, 1, '2023-09-01 20:30:00'), -- Legia vs Wisła (2:1)
(1002, 3, 4, '0', '0', 3, 2, '2023-09-02 17:30:00'), -- Lech vs Raków (0:0)
(1003, 2, 4, '1', '3', 2, 3, '2023-09-15 18:00:00'), -- Wisła vs Raków (1:3)
(1004, 1, 3, '2', '2', 1, 1, '2023-09-16 20:00:00'); -- Legia vs Lech (2:2)

-- 4. ZDARZENIA (Bramki, Asysty, Kartki - powiązane z Meczami)

-- Mecz 1001: Legia 2-1 Wisła
INSERT INTO Bramka (Bramka_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_bramki, Uwagi) VALUES
(1, 1001, 102, 1, '15', 'Głową'),      -- Pekhart
(2, 1001, 202, 2, '40', 'Z akcji'),     -- Rodado
(3, 1001, 101, 1, '88', 'Rzut wolny');  -- Josue

INSERT INTO Asysta (Asysta_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_zanotowania_asysty) VALUES
(1, 1001, 101, 1, '15'); -- Josue asystuje Pekhartowi

INSERT INTO Kartki (Kartka_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_zdarzenia, Kolor_Kartki) VALUES
(1, 1001, 201, 2, '65', 'Żółta');

-- Mecz 1003: Wisła 1-3 Raków
INSERT INTO Bramka (Bramka_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_bramki) VALUES
(4, 1003, 401, 4, '10'), -- Ivi Lopez
(5, 1003, 401, 4, '35'), -- Ivi Lopez
(6, 1003, 202, 2, '55'), -- Rodado
(7, 1003, 402, 4, '80'); -- Tudor

-- Mecz 1004: Legia 2-2 Lech
INSERT INTO Bramka (Bramka_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_bramki) VALUES
(8, 1004, 301, 3, '5'),
(9, 1004, 102, 1, '45'),
(10, 1004, 301, 3, '70'),
(11, 1004, 101, 1, '90');

INSERT INTO Kartki (Kartka_ID, Mecz_ID, Zawodnik_ID, Druzyna_ID, Minuta_zdarzenia, Kolor_Kartki) VALUES
(2, 1004, 103, 1, '89', 'Czerwona'); -- Jędrzejczyk czerwona

