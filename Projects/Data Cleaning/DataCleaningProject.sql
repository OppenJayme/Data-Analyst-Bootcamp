-- Data Cleaning Project
-- data cleaning,
-- make it into a more usable format, fix issues in the raw data
-- data is useful and no issues,problems easier to visualize.

-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null/BLank values
-- 4. remove columns and rows/ staging


SELECT *
FROM layoffs;

-- staging
CREATE table layoffs_stage
LIKE layoffs;

-- inserting values into the stage
INSERT layoffs_stage
SELECT *
FROM layoffs;

-- this filters ev
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_stage;

-- display the duplicates 
WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stage
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- making sure
SELECT *
FROM layoffs_stage
WHERE company = 'Casper';

-- creating nanother layoff table because we cannot delete through CTE
CREATE TABLE `layoffs_stage2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- DELETION
SELECT *
FROM layoffs_stage2
WHERE row_num > 1;

INSERT INTO layoffs_stage2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stage;

-- STANDARDIZING DATA

SELECT company, TRIM(company)
FROM layoffs_stage2;

UPDATE layoffs_stage2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_stage2
;

UPDATE layoffs_stage2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_stage2
ORDER BY 1;

UPDATE layoffs_stage2
SET country =  TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_stage2
;

UPDATE layoffs_stage2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

ALTER TABLE layoffs_stage2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_stage2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *	
FROM layoffs_stage2
WHERE industry IS NULL
OR industry = '';

-- RESTART BECAUSE I MADE A MISTAKE AT STAGE2!!!
CREATE TABLE `layoffs_stage3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` date DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int,
  `row_num2` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- display
SELECT *
FROM layoffs_stage3;

-- insertion of values into staged 
INSERT INTO layoffs_stage3
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stage2;

-- deltion
DELETE
FROM layoffs_stage3
WHERE row_num > 1 OR row_num2 > 1;

-- COMEBACK!
UPDATE layoffs_stage3
SET industry = NULL
WHERE industry = '';

SELECT *	
FROM layoffs_stage3
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_stage3
WHERE company = 'Bally';

-- self join to compare its missing industry so we can accurately update that industry to be popoulated to the correct industry
SELECT t1.company, t2.company, t1.industry, t2.industry
FROM layoffs_stage3 t1
JOIN layoffs_stage3 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '') AND t2.industry IS NOT NULL;

UPDATE layoffs_stage3 t1
JOIN layoffs_stage3 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_stage3
WHERE total_laid_off IS NULL AND 
	percentage_laid_off IS NULL;

-- DEletion because we cant get anything from it
DELETE 
FROM layoffs_stage3
WHERE total_laid_off IS NULL AND 
	percentage_laid_off IS NULL;
    
-- display
	SELECT *
	FROM layoffs_stage3;

ALTER TABLE layoffs_stage3
DROP COLUMN row_num;


