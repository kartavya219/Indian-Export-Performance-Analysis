# Indian Export Performance Analysis

End-to-end analytics pipeline on India's export data (FY2016–FY2026), built on DGCI&S trade data. Covers data cleaning, MySQL schema design, SQL analysis, a Power BI dashboard, an automated Excel reporting notebook, and supporting trade-intelligence reference material.

## Insights — Current Findings

**Overall trend**
- Exports grew from $262B (FY16) to $442B (FY26) — ~5.35% CAGR over the period.
- Growth was not steady: a sharp +44.6% jump in FY22 (likely post-COVID recovery + high oil prices) accounts for most of the gain.
- Last four years: +6.9%, -3.1%, +0.1%, +0.9% — essentially flat since FY22. Headline growth is real but concentrated in a single year, with a plateau since.

**Product concentration**
- Petroleum products is the single largest commodity: 14.6% of total exports ($579B over the period).
- Top 15 commodities together make up ~54% of all exports — a reasonably broad spread.
- The #1 category is driven by global oil prices rather than demand for Indian manufactured/processed goods.

**Country concentration**
- USA alone accounts for 17.5% of total exports ($694B).
- Top 10 countries account for just over 50% of all exports.
- US tariffs currently run 10–27% (110% on patented pharma). Pharma is India's 3rd-largest export commodity, with the US as its top buyer ($73B) — meaning the largest customer, the largest tariff risk, and a top-3 export category all overlap in one country.

**Growing vs. declining markets** (min. $100M export base in FY16)
- Fastest growing: Djibouti, Togo, Libya (~17% CAGR each); Austria, Romania, Netherlands (~14% CAGR).
- Declining: Pakistan (-19% CAGR), Korea DPR (-28% CAGR), Gibraltar (-49% CAGR).
- These shifts are largely geopolitical rather than commercially actionable.

## Pipeline

Raw data → Excel cleaning → MySQL schema → SQL analysis (30 queries across 3 layers) → Power BI dashboard → business insights → automated Excel reports (Python)

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
