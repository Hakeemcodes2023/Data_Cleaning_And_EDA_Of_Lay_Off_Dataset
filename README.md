📌 Overview

This project focuses on cleaning a layoffs dataset and performing exploratory data analysis using SQL. The goal was to transform messy raw data into a clean, reliable dataset and uncover trends such as monthly layoffs, rolling totals, and top companies.

📂 Dataset

Source: Layoffs dataset

Raw Table: layoffs

Cleaned Table: layoffs_staging

Work included fixing duplicates, formatting dates, filling missing values, and preparing fields for analysis.

🛠 Tools Used

SQL Server (script uses SQL Server functions like FORMAT, SELECT TOP, ROW_NUMBER())

Easily adaptable to PostgreSQL/MySQL with small syntax changes.

🔧 What I Did (Steps)
1️⃣ Create a Staging Table

Made a safe working copy of the raw data:
SELECT * INTO layoffs_staging FROM layoffs

2️⃣ Remove Duplicates

Used ROW_NUMBER() to identify and delete duplicate records.

3️⃣ Clean & Standardize Data

Formatted dates

Removed blank strings

Fixed inconsistent values

Handled NULLs and filled missing fields when possible

4️⃣ Backfill Missing Industry Values

Joined company data to fill in missing industry fields using other rows from the same company.

5️⃣ Exploratory Data Analysis (EDA)

Monthly totals (FORMAT([date], 'MM-yyyy'))

Layoffs by month/year

Rolling totals with window functions

Top 5 companies with highest layoffs

📊 Results

✔️ Clean, analysis-ready dataset

✔️ Duplicate-free staging table

✔️ Clear monthly layoff trends

✔️ Rolling totals showing long-term patterns

✔️ Quick insights into top companies impacted

✔️ Identified remaining missing data for further review

▶️ How to Run the Project

Open Data Cleaning and EDA Project.sql in SQL Server Management Studio (SSMS) or any SQL Server-compatible editor.

Ensure the raw table layoffs exists in your database.

Run the script top-to-bottom:

Staging table creation

Data cleaning

EDA queries

View results in the output grid for each analysis section.

(Optional) Modify syntax slightly to run in PostgreSQL or MySQL.

📁 Files Included

Data Cleaning and EDA Project.sql — full cleaning workflow + EDA queries.
