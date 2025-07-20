
# Projekt Relacyjnej Bazy Danych SQL - Statystyki Piłkarskie

Projekt zrealizowany w ramach studiów na kierunku Analityka Gospodarcza, demonstrujący umiejętność projektowania złożonych, znormalizowanych schematów baz danych oraz pisania zaawansowanych zapytań analitycznych w języku SQL.

## Diagram ERD (Entity-Relationship Diagram)
Poniższy diagram przedstawia architekturę bazy danych, w tym tabele, klucze główne, klucze obce oraz relacje między nimi.

![Diagram Bazy Danych](https://github.com/MarSnop99/SQL-Database-Ekstraklasa/blob/main/Diagram%20bazy%20SQL.png?raw=true)

*(Uwaga: Aby wstawić diagram, musisz najpierw wgrać plik z obrazkiem do repozytorium i nazwać go `diagram_bazy_danych.png`)*

---

## 1. Cel Biznesowy Projektu
Celem projektu było stworzenie w pełni funkcjonalnej, znormalizowanej bazy danych dla fikcyjnej ligi piłkarskiej. System został zaprojektowany tak, aby umożliwiać efektywne gromadzenie, zarządzanie i analizowanie szczegółowych danych dotyczących meczów, w tym wyników, statystyk zawodników (bramki, asysty, kartki), informacji o drużynach, sędziach i stadionach.

---

## 2. Architektura i Projekt Schematu
Baza danych została zaprojektowana z naciskiem na integralność i wydajność, zgodnie z zasadami normalizacji.

*   **Normalizacja:** Schemat został zaprojektowany w **trzeciej formie normalnej (3NF)**, aby wyeliminować redundancję danych i zapobiec anomaliom podczas ich modyfikacji. Przykładem jest użycie jednej tabeli `Drużyna` zamiast oddzielnych tabel dla gospodarzy i gości.
*   **Relacje:** Model wykorzystuje złożone relacje, w tym **jeden-do-wielu** (np. `Drużyna` do `Zawodnik`) oraz **wiele-do-wielu**, co widać w tabeli `Mecz`, która łączy wiele encji (drużyny, sędzia, stadion).
*   **Integralność Danych:** Zastosowano ograniczenia (`constraints`) takie jak `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE` oraz `CHECK` w celu zapewnienia spójności, poprawności i logiki biznesowej przechowywanych danych.

---

## 3. Struktura Repozytorium
Repozytorium zawiera trzy główne skrypty SQL, które pozwalają na odtworzenie i przetestowanie całej bazy danych:

*   **`1_schema.sql`**: Skrypt zawiera wszystkie instrukcje `CREATE TABLE` oraz `ALTER TABLE`, które budują kompletną, pustą strukturę bazy danych z wszystkimi relacjami i ograniczeniami.
*   **`2_data_insertion.sql`**: Skrypt wypełnia stworzone tabele przykładowymi danymi (`INSERT INTO`), co umożliwia przeprowadzanie testów i zapytań analitycznych.
*   **`3_analytical_queries.sql`**: Skrypt zawiera kolekcję przykładowych zapytań `SELECT`, które demonstrują, jak można wykorzystać bazę do uzyskania wartościowych insightów (np. rankingi strzelców, statystyki sędziów, analiza wyników).

---

## 4. Użyte Technologie
*   **Język:** SQL (dialekt: T-SQL / MS SQL Server)
*   **Narzędzia:** Microsoft SQL Server Management Studio
