# Indian Export Performance Analysis

End-to-end analytics pipeline on India's export data (FY2016–FY2026), built on DGCI&S trade data. Covers data cleaning, MySQL schema design, SQL analysis, a Power BI dashboard, an automated Excel reporting notebook, and supporting trade-intelligence reference material.

## Pipeline

Raw data → Excel cleaning → MySQL schema → SQL analysis (30 queries across 3 layers) → Power BI dashboard → business insights → automated Excel reports (Python)

## Repository Structure

```
├── DATA SOURCE/                     # Raw input CSVs
│   ├── FY2016-FY2026.csv            # 10-year commodity × country trade data
│   └── state_exports.csv            # FY24-25 state-level export data
│
├── SQL Dump/                        # MySQL dumps (schema + data)
│   ├── export_fy16_26.sql           # Table: fy16_26 (10-year master table)
│   ├── export_fy25.sql              # Table: fy25 (FY24-25 snapshot)
│   └── export_state_exports_25.sql  # Table: state_exports_25 (statewise FY25)
│
├── SQL QUERIES FY16-26/             # 10-year trend analysis (15 queries)
├── SQL QUERIES FY24-25/             # Single-year snapshot analysis (8 queries)
├── SQL QUERIES STATEWISE FY25/      # State-level analysis (9 queries)
│
├── Automated Yearly Report/
│   └── Export_Performance_Report.ipynb   # Generates a formatted Excel KPI report for any year
│
├── TRADE INTELLIGENCE/               # Reference material
│   ├── COMPANY DATA.xlsx
│   ├── EXPORT ROUTES TOP 50 COUNTRIES.xlsx
│   ├── EXPORT TARRIFS TOP 50 COUNTRIES.xlsx
│   ├── Export Insights.docx
│   ├── India_Export_Compliance_Guide.docx
│   ├── Trade Agreements and Regional Economic Blocs.docx
│   └── PC_composition_HSN2012.pdf
│
├── Power BI Dashboard.pbix
└── India Export Performance Analysis Presentation.pdf
```

## Database Schema

| Table | Source | Key Columns |
|---|---|---|
| `fy16_26` | `export_fy16_26.sql` | Financial_Year, Commodity, Country, Unit, Quantity, Trade_Value_USD, PC_Code, Continent |
| `fy25` | `export_fy25.sql` | Same as above, FY2025 only |
| `state_exports_25` | `export_state_exports_25.sql` | PC_CODE, COMMODITY, STATE, Country, UNIT, Quantity, Trade_Value_USD, Continents |

## Setup

**1. Import the database**
```bash
mysql -u root -p -e "CREATE DATABASE export"
mysql -u root -p export < "SQL Dump/export_fy16_26.sql"
mysql -u root -p export < "SQL Dump/export_fy25.sql"
mysql -u root -p export < "SQL Dump/export_state_exports_25.sql"
```

**2. Run analysis queries**
Any `.sql` file under the three `SQL QUERIES */` folders can be run directly against the imported database.

**3. Generate a yearly Excel report**
```bash
pip install pandas mysql-connector-python matplotlib openpyxl
jupyter notebook "Automated Yearly Report/Export_Performance_Report.ipynb"
```

**4. Power BI Dashboard**
Open `Power BI Dashboard.pbix` in Power BI Desktop; point the data source connections at your local `export` database.

## Analysis Layers

- **10-year trend (`fy16_26`)** — CAGR, year-on-year growth, country/commodity/continent share, top-N rankings, per-continent leaders.
- **FY24-25 snapshot (`fy25`)** — Single-year top commodities/countries/continents, cumulative share of top commodities, per-group leaders.
- **Statewise FY25 (`state_exports_25`)** — Top exporting states, per-state top commodities and destinations, state-country trade pairs.

## Data Source

Directorate General of Commercial Intelligence and Statistics (DGCI&S), Government of India.
