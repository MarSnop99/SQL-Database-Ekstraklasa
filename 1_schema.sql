-- =================================================================
-- Plik 1: Tworzenie Schematu Bazy Danych (Struktura Tabel)
-- Opis: Ten skrypt tworzy wszystkie tabele, definiuje klucze główne,
--       klucze obce oraz inne ograniczenia (constraints).
-- =================================================================

-- Tabela: Druzyna (Tabela główna dla drużyn)
CREATE TABLE Druzyna (
    Druzyna_ID INT PRIMARY KEY NOT NULL,
    Akronim VARCHAR(3) UNIQUE NOT NULL,
    Nazwa_Druzyny NVARCHAR(30) NOT NULL
);

-- Tabela: Zawodnik
CREATE TABLE Zawodnik (
    Zawodnik_ID INT PRIMARY KEY NOT NULL,
    Imie_i_Nazwisko VARCHAR(50) NOT NULL,
    Druzyna_ID INT NOT NULL,
    Data_Urodzenia DATETIME NOT NULL,
    Nominalna_pozycja NVARCHAR(30) NOT NULL,
    CONSTRAINT CK_Nominalna_Pozycja CHECK (Nominalna_pozycja IN ('Bramkarz', 'Obrońca', 'Pomocnik', 'Napastnik')),
    CONSTRAINT FK_zawodnik_Druzyna FOREIGN KEY (Druzyna_ID) REFERENCES Druzyna(Druzyna_ID)
);

-- Tabela: Stadion
CREATE TABLE Stadion (
    Stadion_ID INT PRIMARY KEY NOT NULL,
    Nazwa_Stadionu NVARCHAR(99) NOT NULL,
    Miasto NVARCHAR(30) NOT NULL
);

-- Tabela: Sedzia
CREATE TABLE Sedzia (
    Sedzia_ID INT PRIMARY KEY NOT NULL,
    Imie_i_Nazwisko NVARCHAR(50) NOT NULL,
    Miasto_Pochodzenia NVARCHAR(50) NOT NULL
);

-- Tabela: Mecz (Tabela centralna, łącząca wiele informacji)
CREATE TABLE Mecz (
    Mecz_ID INT PRIMARY KEY,
    Gospodarze_ID INT NOT NULL,
    Goscie_ID INT NOT NULL,
    Wynik_Gospodarze VARCHAR(2) NOT NULL,
    Wynik_Goscie VARCHAR(2) NOT NULL,
    Stadion_ID INT NOT NULL,
    Sedzia_ID INT NOT NULL,
    Data_rozegrania DATETIME NOT NULL,
    CONSTRAINT FK_Mecz_Gospodarze FOREIGN KEY (Gospodarze_ID) REFERENCES Druzyna(Druzyna_ID),
    CONSTRAINT FK_Mecz_Goscie FOREIGN KEY (Goscie_ID) REFERENCES Druzyna(Druzyna_ID),
    CONSTRAINT FK_Mecz_Stadion FOREIGN KEY (Stadion_ID) REFERENCES Stadion(Stadion_ID),
    CONSTRAINT FK_Mecz_Sedzia FOREIGN KEY (Sedzia_ID) REFERENCES Sedzia(Sedzia_ID)
);

-- Tabela: Bramka
CREATE TABLE Bramka (
    Bramka_ID INT PRIMARY KEY NOT NULL,
    Mecz_ID INT NOT NULL,
    Zawodnik_ID INT NOT NULL,
    Druzyna_ID INT NOT NULL,
    Minuta_bramki NVARCHAR(3) NOT NULL,
    Uwagi NVARCHAR(50),
    CONSTRAINT FK_Bramka_Mecz FOREIGN KEY (Mecz_ID) REFERENCES Mecz(Mecz_ID),
    CONSTRAINT FK_Bramka_zawodnik FOREIGN KEY (Zawodnik_ID) REFERENCES Zawodnik(Zawodnik_ID),
    CONSTRAINT FK_Bramka_Druzyna FOREIGN KEY (Druzyna_ID) REFERENCES Druzyna(Druzyna_ID)
);

-- Tabela: Asysta
CREATE TABLE Asysta (
    Asysta_ID INT PRIMARY KEY NOT NULL,
    Mecz_ID INT NOT NULL,
    Zawodnik_ID INT NOT NULL,
    Druzyna_ID INT NOT NULL,
    Minuta_zanotowania_asysty NVARCHAR(3) NOT NULL,
    CONSTRAINT FK_Asysta_Mecz FOREIGN KEY (Mecz_ID) REFERENCES Mecz(Mecz_ID),
    CONSTRAINT FK_Asysta_zawodnik FOREIGN KEY (Zawodnik_ID) REFERENCES Zawodnik(Zawodnik_ID),
    CONSTRAINT FK_Asysta_Druzyna FOREIGN KEY (Druzyna_ID) REFERENCES Druzyna(Druzyna_ID)
);

-- Tabela: Kartka
CREATE TABLE Kartka (
    Kartka_ID INT PRIMARY KEY NOT NULL,
    Mecz_ID INT NOT NULL,
    Zawodnik_ID INT NOT NULL,
    Druzyna_ID INT NOT NULL,
    Minuta_zdarzenia VARCHAR(3) NOT NULL,
    Kolor_Kartki NVARCHAR(15) NOT NULL,
    CONSTRAINT CK_Kolor_Kartki CHECK (Kolor_Kartki IN ('Żółta', 'Żółta/Czerwona', 'Czerwona')),
    CONSTRAINT FK_Kartka_Mecz FOREIGN KEY (Mecz_ID) REFERENCES Mecz(Mecz_ID),
    CONSTRAINT FK_Kartka_zawodnik FOREIGN KEY (Zawodnik_ID) REFERENCES Zawodnik(Zawodnik_ID),
    CONSTRAINT FK_Kartka_Druzyna FOREIGN KEY (Druzyna_ID) REFERENCES Druzyna(Druzyna_ID)
);

-- UWAGA: Tabele Gospodarze i Goscie zostały usunięte, ponieważ ich rolę
-- pełni tabela Druzyna. W tabeli Mecz odwołujemy się bezpośrednio do Druzyna_ID.
-- To jest zgodne z zasadami normalizacji i upraszcza schemat.