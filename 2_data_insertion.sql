-- =================================================================
-- Plik 2: Wstawianie Przykładowych Danych (Sample Data)
-- Opis: Ten skrypt wypełnia stworzone tabele przykładowymi danymi,
--       aby umożliwić przeprowadzanie zapytań analitycznych.
-- =================================================================

-- Wstawianie danych do tabeli Druzyna
INSERT INTO Druzyna (Druzyna_ID, Akronim, Nazwa_Druzyny) VALUES
(1, 'LEG', 'Legia Warszawa'),
(2, 'WIS', 'Wisła Kraków'),
(3, 'LPO', 'Lech Poznań');
-- ... dodaj więcej drużyn

-- Wstawianie danych do tabeli Zawodnik
INSERT INTO Zawodnik (Zawodnik_ID, Imie_i_Nazwisko, Druzyna_ID, Data_Urodzenia, Nominalna_pozycja) VALUES
(101, 'Robert Lewandowski', 3, '1988-08-21', 'Napastnik'),
(102, 'Jakub Błaszczykowski', 2, '1985-12-14', 'Pomocnik'),
(103, 'Artur Boruc', 1, '1980-02-20', 'Bramkarz');
-- ... dodaj więcej zawodników

-- Wstawianie danych do tabeli Mecz
INSERT INTO Mecz (Mecz_ID, Gospodarze_ID, Goscie_ID, Wynik_Gospodarze, Wynik_Goscie, Stadion_ID, Sedzia_ID, Data_rozegrania) VALUES
(1001, 1, 2, '2', '1', 1, 1, '2023-05-20 20:00:00');
-- ... dodaj więcej meczów
