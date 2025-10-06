# 🧱 Secure SQL Examples

Denne mappe indeholder eksempler på **sikker SQL-kode**, designet til at beskytte mod SQL injection og andre almindelige sikkerhedsproblemer.  
Formålet er at vise, hvordan man skriver SQL på en måde, der er både **robust, vedligeholdelsesvenlig og sikker**.

---

## 🎯 Formål

Målet med denne samling er at:
- Demonstrere **parameterized queries** (prepared statements)
- Vise **sikre stored procedures**
- Forklare forskellen mellem **usikre og sikre** SQL-tilgange
- Give konkrete eksempler i forskellige SQL-dialekter (MySQL, PostgreSQL, MSSQL)
- Skabe et referencepunkt for udviklere, der ønsker at forbedre deres SQL-sikkerhed

---

## 📂 Struktur

```txt
secure-sql/
│
├── parameterized_queries/
│ ├── mysql_example.sql
│ ├── postgres_example.sql
│ └── mssql_example.sql
│
├── stored_procedures/
│ └── safe_user_lookup.sql
│
├── unsafe_vs_safe/
│ ├── unsafe_login_example.sql
│ └── safe_login_example.sql
│
└── README.md
```