----DATA CLEANING
select top 10 * from layoffs
---1. REMOVE DUPLICATES
---2. STANDARDIZE THE DATA
---3. NULL VALUES OR BLANK VALUES
---4. REMOVE ANY COLUMNS


---DUPLICATE TABLE IN DATABASE
SELECT *
INTO layoffs_staging
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions
    ORDER BY (SELECT NULL)
) AS row_num
FROM layoffs_staging;

WITH duplicate_cte as
(
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions
    ORDER BY (SELECT NULL)
) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging
WHERE company = 'CASPER';

---Deleting Duplicates
WITH duplicate_cte as
(
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions
    ORDER BY (SELECT NULL)
) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;

--- Standardizing data
SELECT company, TRIM(company)
FROM layoffs_staging;

UPDATE layoffs_staging
SET company = TRIM(company);

SELECT DISTINCT(industry)
FROM layoffs_staging
ORDER BY 1;

SELECT *
FROM layoffs_staging
WHERE industry LIKE '%Crypto%';

UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging
WHERE country LIKE 'United States%'
ORDER BY 1;

SELECT DISTINCT(country), TRIM(TRAILING '.' FROM country)
FROM layoffs_staging
ORDER BY 1;

UPDATE layoffs_staging
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT [date]
FROM layoffs_staging

SELECT [date], FORMAT([date], 'MM-dd-yyyy') AS formatted_date
from layoffs_staging;

SELECT * 
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging
WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging t1
JOIN layoffs_staging t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging t1
JOIN layoffs_staging t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL
  AND t2.industry <> '';

SELECT * 
FROM layoffs_staging

SELECT * 
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

--- Exploratory Data Analysis

SELECT *
FROM layoffs_staging

-- Max laid off in one day
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging

SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY company
ORDER BY 2 desc

SELECT MIN([date]), MAX([date])
FROM layoffs_staging; 

SELECT industry, SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 desc

SELECT *
FROM layoffs_staging

SELECT country, SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY country
ORDER BY 2 desc

SELECT YEAR([date]), SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY YEAR([date])
ORDER BY 1 desc

SELECT stage, SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY stage
ORDER BY 2 desc

SELECT company, SUM(percentage_laid_off) 
FROM layoffs_staging
GROUP BY company
ORDER BY 2 desc


SELECT MONTH([date]) AS Month,
YEAR([date]) AS Year,
SUM(total_laid_off)
FROM layoffs_staging
WHERE MONTH([date]) IS NOT NULL AND YEAR([date]) IS NOT NULL
GROUP BY MONTH([date]),YEAR([date]);

SELECT 
    FORMAT([date], 'MM-yyyy') AS Month,
    SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging
WHERE [date] IS NOT NULL
GROUP BY FORMAT([date], 'MM-yyyy')
ORDER BY Month ASC;

WITH Rolling_Total AS
(
    SELECT 
        -- small numeric ordering key
        YEAR([date]) * 100 + MONTH([date]) AS MonthKey,
        -- display Month text as you like
        FORMAT([date], 'MM-yyyy') AS MonthText,
        SUM(total_laid_off) AS Total_Laid_Off
    FROM layoffs_staging
    WHERE [date] IS NOT NULL
    GROUP BY YEAR([date]) * 100 + MONTH([date]),
             FORMAT([date], 'MM-yyyy')
)
SELECT 
    MonthText,
    Total_Laid_Off,
    SUM(Total_Laid_Off) OVER(ORDER BY MonthKey ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling_total
FROM Rolling_Total
ORDER BY MonthKey;




SELECT company, SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY company
ORDER BY 2 desc;

SELECT company, 
YEAR([date]),
SUM(total_laid_off) as sum_laid_off
FROM layoffs_staging
GROUP BY company, YEAR([date])
ORDER BY 3 desc;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, 
YEAR([date]) AS Year,
SUM(total_laid_off) as total_laid_off
FROM layoffs_staging
GROUP BY company, YEAR([date])
), Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS RANKING
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5; 













