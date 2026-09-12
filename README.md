# SQL Reports (iNFIGO)

A small MySQL sample database and reporting exercise built around instances
(`Instanz`) and the reports (`Report`) they produce, with example data and
queries for practising SQL joins and reporting.

## Contents

- `indigo.sql` — a full MySQL script that:
  - drops and recreates the `iNFIGO` database,
  - creates the `Instanz` and `Report` tables (one-to-many, linked by a foreign key),
  - inserts sample instances and reports,
  - includes example reporting/select queries.

## Schema

- **Instanz** — an instance with a `name` and a `use` (e.g. Produktion, Entwicklung, Test).
- **Report** — a report with a `name`, `report`, `entscheidungsdatum` (decision date),
  and a foreign key `fk_instanzId` referencing an instance.

## Usage

Load the script into a MySQL server:

```bash
mysql -u root -p < indigo.sql
```

Then query the `iNFIGO` database, for example:

```sql
USE iNFIGO;
SELECT * FROM Report;
```
