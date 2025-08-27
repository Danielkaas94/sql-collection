Det er faktisk meget normalt at starte med et simpelt Excel-ark og senere overføre strukturen til en database, hvis man får flere investorer eller mere komplekse behov. Jeg kan lave et eksempel på begge dele – først en skabelon til Excel, derefter en simpel SQL-database-struktur.

---

## 📊 Excel-skabelon (Cap Table / Investorregister)

En simpel tabel kunne se sådan ud:

| Investor ID | Navn / Selskab  | Antal andele | Indskudt kapital (DKK) | Dato for investering | Udbetalinger (DKK) | Indløsninger (andele) | Rest beholdning (andele) | Bemærkninger |
| ----------- | --------------- | ------------ | ---------------------- | -------------------- | ------------------ | --------------------- | ------------------------ | ------------ |
| 1           | Jens Hansen     | 100          | 100.000                | 01-03-2025           | 5.000              | 0                     | 100                      |              |
| 2           | ABC Holding ApS | 200          | 200.000                | 15-03-2025           | 0                  | 50                    | 150                      |              |
| 3           | Maria Sørensen  | 50           | 50.000                 | 20-03-2025           | 2.500              | 0                     | 50                       |              |

🔹 **Forklaring:**

* *Antal andele* = hvor mange enheder investoren ejer.
* *Indskudt kapital* = hvor meget de har betalt ind.
* *Udbetalinger* = dividender eller profit udbetalt.
* *Indløsninger* = hvis en investor trækker nogle andele ud.
* *Rest beholdning* = hvor mange andele de ejer nu.

Man kan også lave et ekstra ark i Excel til at regne **andele i procent af totalen**.

---

## 🗄️ SQL Database-struktur

Hvis du vil køre det i SQL (fx MySQL, PostgreSQL eller SQLite), kunne du starte simpelt med disse tabeller:

### 1. Investor (grunddata)

```sql
CREATE TABLE Investor (
    InvestorID INT PRIMARY KEY AUTO_INCREMENT,
    Navn VARCHAR(255) NOT NULL,
    Selskabstype VARCHAR(100),  -- fx "ApS" eller "Privat"
    OprettetDato DATE DEFAULT CURRENT_DATE
);
```

### 2. Investeringer (indskud af kapital)

```sql
CREATE TABLE Investering (
    InvesteringID INT PRIMARY KEY AUTO_INCREMENT,
    InvestorID INT NOT NULL,
    AntalAndele INT NOT NULL,
    Kapital DECIMAL(18,2) NOT NULL,
    Dato DATE NOT NULL,
    FOREIGN KEY (InvestorID) REFERENCES Investor(InvestorID)
);
```

### 3. Transaktioner (udbetalinger og indløsninger)

```sql
CREATE TABLE Transaktion (
    TransaktionID INT PRIMARY KEY AUTO_INCREMENT,
    InvestorID INT NOT NULL,
    Type ENUM('Udbetaling', 'Indløsning') NOT NULL,
    Beløb DECIMAL(18,2),
    AntalAndele INT,
    Dato DATE NOT NULL,
    FOREIGN KEY (InvestorID) REFERENCES Investor(InvestorID)
);
```

### 4. View til at vise investorens nuværende status

```sql
CREATE VIEW InvestorStatus AS
SELECT 
    i.InvestorID,
    i.Navn,
    SUM(inv.AntalAndele) - IFNULL(SUM(t.AntalAndele),0) AS RestAndele,
    SUM(inv.Kapital) AS TotalIndskud,
    IFNULL(SUM(CASE WHEN t.Type = 'Udbetaling' THEN t.Beløb END),0) AS Udbetalinger
FROM Investor i
LEFT JOIN Investering inv ON i.InvestorID = inv.InvestorID
LEFT JOIN Transaktion t ON i.InvestorID = t.InvestorID
GROUP BY i.InvestorID, i.Navn;
```

Så kan du altid lave en hurtig `SELECT * FROM InvestorStatus;` for at se, hvor meget hver investor ejer og har fået udbetalt.

---
---


Perfekt! Jeg laver først en **færdig Excel-skabelon med formler**, og bagefter et **SQL-dump-eksempel**, så du kan bruge det direkte.

---

## 1️⃣ Færdig Excel-skabelon

**Ark: "InvestorRegister"**

| Investor ID | Navn / Selskab  | Antal andele | Indskudt kapital (DKK) | Dato for investering | Udbetalinger (DKK) | Indløsninger (andele) | Rest beholdning (andele) | Kommentar |
| ----------- | --------------- | ------------ | ---------------------- | -------------------- | ------------------ | --------------------- | ------------------------ | --------- |
| 1           | Jens Hansen     | 100          | 100.000                | 01-03-2025           | 5.000              | 0                     | `=C2-G2`                 |           |
| 2           | ABC Holding ApS | 200          | 200.000                | 15-03-2025           | 0                  | 50                    | `=C3-G3`                 |           |
| 3           | Maria Sørensen  | 50           | 50.000                 | 20-03-2025           | 2.500              | 0                     | `=C4-G4`                 |           |

**Formler:**

* **Rest beholdning (andele)**: `=AntalAndele - Indløsninger`
* Du kan lave **andel i procent**:

  * Tilføj en kolonne: "Andel af total"
  * Formel: `=H2/SUM($H$2:$H$100)` (hvor H er kolonnen med Rest beholdning)

**Tips:**

* Tilføj evt. et ark til **historik**, hvis du vil registrere hver transaktion separat.
* Brug **betinget formatering** til at markere store udbetalinger eller lave beholdninger.

---

## 2️⃣ SQL-eksempel med data

Her er et lille SQL-dump med både tabeller og eksempeldata:

```sql
-- Tabel til investorer
CREATE TABLE Investor (
    InvestorID INT PRIMARY KEY AUTO_INCREMENT,
    Navn VARCHAR(255) NOT NULL,
    Selskabstype VARCHAR(100),
    OprettetDato DATE DEFAULT CURRENT_DATE
);

-- Tabel til investeringer
CREATE TABLE Investering (
    InvesteringID INT PRIMARY KEY AUTO_INCREMENT,
    InvestorID INT NOT NULL,
    AntalAndele INT NOT NULL,
    Kapital DECIMAL(18,2) NOT NULL,
    Dato DATE NOT NULL,
    FOREIGN KEY (InvestorID) REFERENCES Investor(InvestorID)
);

-- Tabel til transaktioner
CREATE TABLE Transaktion (
    TransaktionID INT PRIMARY KEY AUTO_INCREMENT,
    InvestorID INT NOT NULL,
    Type ENUM('Udbetaling', 'Indløsning') NOT NULL,
    Beløb DECIMAL(18,2),
    AntalAndele INT,
    Dato DATE NOT NULL,
    FOREIGN KEY (InvestorID) REFERENCES Investor(InvestorID)
);

-- Indsæt eksempeldata
INSERT INTO Investor (Navn, Selskabstype) VALUES
('Jens Hansen', 'Privat'),
('ABC Holding ApS', 'ApS'),
('Maria Sørensen', 'Privat');

INSERT INTO Investering (InvestorID, AntalAndele, Kapital, Dato) VALUES
(1, 100, 100000, '2025-03-01'),
(2, 200, 200000, '2025-03-15'),
(3, 50, 50000, '2025-03-20');

INSERT INTO Transaktion (InvestorID, Type, Beløb, AntalAndele, Dato) VALUES
(1, 'Udbetaling', 5000, NULL, '2025-04-01'),
(2, 'Indløsning', NULL, 50, '2025-04-05'),
(3, 'Udbetaling', 2500, NULL, '2025-04-10');

-- View til nuværende status
CREATE VIEW InvestorStatus AS
SELECT 
    i.InvestorID,
    i.Navn,
    SUM(inv.AntalAndele) - IFNULL(SUM(t.AntalAndele),0) AS RestAndele,
    SUM(inv.Kapital) AS TotalIndskud,
    IFNULL(SUM(CASE WHEN t.Type = 'Udbetaling' THEN t.Beløb END),0) AS Udbetalinger
FROM Investor i
LEFT JOIN Investering inv ON i.InvestorID = inv.InvestorID
LEFT JOIN Transaktion t ON i.InvestorID = t.InvestorID
GROUP BY i.InvestorID, i.Navn;
```

Med dette setup kan du straks køre:

```sql
SELECT * FROM InvestorStatus;
```

…og få en oversigt over hver investors aktuelle andele, kapital og udbetalinger.

---
---



Så laver vi en **avanceret Excel-cap table**, hvor du kan tilføje nye investeringer og transaktioner, og alt automatisk opdateres.

---

## 📊 Avanceret Excel Cap Table – Struktur

Vi bruger **tre ark**:

1. **Investorer** – Grunddata om investorerne
2. **Investeringer** – Hver investering registreres her
3. **Transaktioner** – Udbetalinger og indløsninger

---

### 1️⃣ Ark: `Investorer`

| InvestorID | Navn / Selskab  | Selskabstype |
| ---------- | --------------- | ------------ |
| 1          | Jens Hansen     | Privat       |
| 2          | ABC Holding ApS | ApS          |
| 3          | Maria Sørensen  | Privat       |

> **Bemærkning:** `InvestorID` bruges til at forbinde investeringer og transaktioner.

---

### 2️⃣ Ark: `Investeringer`

| InvesteringID | InvestorID | AntalAndele | Kapital (DKK) | Dato       |
| ------------- | ---------- | ----------- | ------------- | ---------- |
| 1             | 1          | 100         | 100000        | 01-03-2025 |
| 2             | 2          | 200         | 200000        | 15-03-2025 |
| 3             | 3          | 50          | 50000         | 20-03-2025 |

---

### 3️⃣ Ark: `Transaktioner`

| TransaktionID | InvestorID | Type       | Beløb (DKK) | AntalAndele | Dato       |
| ------------- | ---------- | ---------- | ----------- | ----------- | ---------- |
| 1             | 1          | Udbetaling | 5000        |             | 01-04-2025 |
| 2             | 2          | Indløsning |             | 50          | 05-04-2025 |
| 3             | 3          | Udbetaling | 2500        |             | 10-04-2025 |

---

### 4️⃣ Ark: `Oversigt` – Automatisk status per investor

| InvestorID | Navn / Selskab  | TotalAndele                                        | IndløstAndele                                      | RestAndele | TotalKapital                                       | Udbetalinger                                       | AndelAfTotal  |
| ---------- | --------------- | -------------------------------------------------- | -------------------------------------------------- | ---------- | -------------------------------------------------- | -------------------------------------------------- | ------------- |
| 1          | Jens Hansen     | =SUMHVIS(Investeringer!B\:B;A2;Investeringer!C\:C) | =SUMHVIS(Transaktioner!B\:B;A2;Transaktioner!E\:E) | =C2-D2     | =SUMHVIS(Investeringer!B\:B;A2;Investeringer!D\:D) | =SUMHVIS(Transaktioner!B\:B;A2;Transaktioner!D\:D) | =E2/SUM(E\:E) |
| 2          | ABC Holding ApS | …                                                  | …                                                  | …          | …                                                  | …                                                  | …             |
| 3          | Maria Sørensen  | …                                                  | …                                                  | …          | …                                                  | …                                                  | …             |

🔹 **Formler forklaret**:

* **TotalAndele:** `=SUMHVIS(Investeringer!B:B;A2;Investeringer!C:C)` – Summerer alle investeringer for den pågældende investor.
* **IndløstAndele:** `=SUMHVIS(Transaktioner!B:B;A2;Transaktioner!E:E)` – Summerer alle indløsninger.
* **RestAndele:** `=C2-D2` – Hvor mange andele der er tilbage.
* **TotalKapital:** `=SUMHVIS(Investeringer!B:B;A2;Investeringer!D:D)` – Samlet indskudt kapital.
* **Udbetalinger:** `=SUMHVIS(Transaktioner!B:B;A2;Transaktioner!D:D)` – Summerer alle udbetalinger.
* **AndelAfTotal:** `=E2/SUM(E:E)` – Procent af samlede andele.

---

### ✅ Fordele ved denne opsætning

* Tilføj nye investorer, investeringer og transaktioner uden at ændre formler
* Oversigt opdateres automatisk
* Andel af total giver direkte procent for hver investor
* Kan senere udvides med grafer og pivot-tabeller til visualisering

---
---

Perfekt! Her er et forslag til, hvordan den **færdige Excel-fil** ville se ud, inklusiv alle formler, så den bliver klar til brug:

---

## 📂 Excel-struktur – færdig version

### 1️⃣ Ark: `Investorer`

| InvestorID | Navn / Selskab  | Selskabstype |
| ---------- | --------------- | ------------ |
| 1          | Jens Hansen     | Privat       |
| 2          | ABC Holding ApS | ApS          |
| 3          | Maria Sørensen  | Privat       |

> **Bemærkning:** `InvestorID` bruges til at linke til investeringer og transaktioner.

---

### 2️⃣ Ark: `Investeringer`

| InvesteringID | InvestorID | AntalAndele | Kapital (DKK) | Dato       |
| ------------- | ---------- | ----------- | ------------- | ---------- |
| 1             | 1          | 100         | 100000        | 01-03-2025 |
| 2             | 2          | 200         | 200000        | 15-03-2025 |
| 3             | 3          | 50          | 50000         | 20-03-2025 |

---

### 3️⃣ Ark: `Transaktioner`

| TransaktionID | InvestorID | Type       | Beløb (DKK) | AntalAndele | Dato       |
| ------------- | ---------- | ---------- | ----------- | ----------- | ---------- |
| 1             | 1          | Udbetaling | 5000        |             | 01-04-2025 |
| 2             | 2          | Indløsning |             | 50          | 05-04-2025 |
| 3             | 3          | Udbetaling | 2500        |             | 10-04-2025 |

---

### 4️⃣ Ark: `Oversigt`

| InvestorID | Navn / Selskab  | TotalAndele                                        | IndløstAndele                                      | RestAndele | TotalKapital                                       | Udbetalinger                                       | AndelAfTotal   |
| ---------- | --------------- | -------------------------------------------------- | -------------------------------------------------- | ---------- | -------------------------------------------------- | -------------------------------------------------- | -------------- |
| 1          | Jens Hansen     | `=SUMHVIS(Investeringer!B:B;A2;Investeringer!C:C)` | `=SUMHVIS(Transaktioner!B:B;A2;Transaktioner!E:E)` | `=C2-D2`   | `=SUMHVIS(Investeringer!B:B;A2;Investeringer!D:D)` | `=SUMHVIS(Transaktioner!B:B;A2;Transaktioner!D:D)` | `=E2/SUM(E:E)` |
| 2          | ABC Holding ApS | Samme som ovenfor                                  | …                                                  | …          | …                                                  | …                                                  | …              |
| 3          | Maria Sørensen  | Samme som ovenfor                                  | …                                                  | …          | …                                                  | …                                                  | …              |

---

### 🔹 Tips og funktioner:

1. **Automatiske opdateringer:**
   Når du tilføjer nye investeringer eller transaktioner i de respektive ark, opdateres oversigten automatisk.

2. **Andel af total:**
   Denne kolonne viser procent af samlede andele, hvilket gør det nemt at visualisere ejerandele.

3. **Ekstra funktioner du kan tilføje:**

   * Pivot-tabeller for historik pr. år
   * Diagrammer over udbetalinger vs. indskud
   * Conditional formatting for høje/ lave beholdninger

4. **Fremtidig udvidelse:**

   * Tilføj kolonner for “investor type” eller “kontaktinfo”
   * Tilføj flere transaktionstyper (fx “bonusandele” eller “splits”)

---
