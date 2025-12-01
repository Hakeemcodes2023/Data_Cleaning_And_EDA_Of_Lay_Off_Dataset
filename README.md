Overview

This project demonstrates data cleaning and exploratory data analysis performed entirely in SQL. The goal was to prepare a reliable, analysis-ready table and surface key insights (monthly totals, rolling totals, top companies, and common data quality issues).

Dataset

Source: layoffs dataset (table name referenced as layoffs).

Delivered: cleaned staging table (layoffs_staging) created from the raw table.

Tools

Primary: SQL Server (script uses SQL Server syntax: SELECT TOP, FORMAT, SELECT ... INTO, ROW_NUMBER(), window functions).

Notes: script can be adapted for PostgreSQL/MySQL with small syntax changes.

Steps (what I did)

Created a staging copy of the raw table for safe cleaning (SELECT ... INTO layoffs_staging).

Duplicate removal using ROW_NUMBER() windowing to identify and remove duplicates.

Standardization and formatting (e.g., formatted date values with FORMAT([date], 'MM-dd-yyyy')).

Null / blank handling — identified NULL or empty fields (industry, totals, percentages) and updated values when possible.

Backfill from other rows — used self-joins to fill missing industry values where another row for the same company had the field populated.

Calculated aggregated metrics for EDA:

Monthly totals (FORMAT([date],'MM-yyyy') + SUM(total_laid_off))

Monthly grouping and MONTH()/YEAR() aggregations

Rolling totals (CTE with MonthKey and cumulative sums)

Top-N analysis (top companies by layoffs)

Results / Key Insights (example outputs)

Cleaned, analysis-ready layoffs_staging table with duplicates removed and key fields standardized.

Monthly layoff trends and rolling totals identify peak months.

Top companies by total layoffs (Top 5 listing) for quick business insights.

Identified rows with missing critical fields for manual review.

How to Run (quick)

Open the SQL script Data Cleaning and EDA Project.sql.

Run it in SQL Server Management Studio (SSMS) or another SQL Server client connected to the database containing the layoffs table.

Inspect the created table layoffs_staging and the output queries (aggregations, rolling totals, top-N).

If using PostgreSQL/MySQL, replace SELECT TOP, FORMAT, and any SQL Server-specific functions with the equivalent syntax (e.g., LIMIT, TO_CHAR, date functions) before running.

Files included

Data Cleaning and EDA Project.sql — full SQL script with cleaning logic, EDA queries and example aggregations.
