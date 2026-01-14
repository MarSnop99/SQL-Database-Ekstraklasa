# SQL Relational Database Project - Football Statistics

A project developed as part of Economic Analytics studies, demonstrating the ability to design complex, normalized database schemas and execute advanced analytical SQL queries.

## ERD (Entity-Relationship Diagram)
The diagram below illustrates the database architecture, including tables, primary keys, foreign keys, and the relationships between them.

![Diagram Bazy Danych](https://github.com/MarSnop99/SQL-Database-Ekstraklasa/blob/main/Diagram%20bazy%20SQL.png?raw=true)

---

## 1. Project Objective
The goal of the project was to create a fully functional, normalized database for a fictional football league. The system was designed to enable efficient collection, management, and analysis of detailed match data, including scores, player statistics (goals, assists, cards), as well as team, referee, and stadium information.

---

## 2. Architecture and Schema Design
The database was designed with a focus on data integrity and performance, adhering to normalization principles.

*   **Normalization:** The schema was designed in **Third Normal Form (3NF)** to eliminate data redundancy and prevent modification anomalies. An example of this is the use of a single `Team` table instead of separate tables for home and away teams.
*   **Relationships:** The model utilizes complex relationships, including **one-to-many** (e.g., `Team` to `Player`) and **many-to-many**, as seen in the `Match` table, which connects multiple entities (teams, referee, stadium).
*   **Data Integrity:** Constraints such as `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `CHECK` were implemented to ensure the consistency, correctness, and business logic of the stored data.

---

## 3. Repository Structure
The repository contains three main SQL scripts that allow for the recreation and testing of the entire database:

*   **`1_schema.sql`**: Contains all `CREATE TABLE` and `ALTER TABLE` statements that build the complete, empty database structure with all relationships and constraints.
*   **`2_data_insertion.sql`**: Populates the created tables with sample data (`INSERT INTO`), enabling testing and analytical queries.
*   **`3_analytical_queries.sql`**: Contains a collection of sample `SELECT` queries demonstrating how the database can be used to derive valuable insights (e.g., top scorer rankings, referee statistics, match result analysis).

---

## 4. Technologies Used
*   **Language:** SQL (Dialect: T-SQL / MS SQL Server)
*   **Tools:** Microsoft SQL Server Management Studio
