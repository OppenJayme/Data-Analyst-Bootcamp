# Layoffs Data Cleaning in MySQL

This project focuses on cleaning a layoffs dataset in MySQL to make it more reliable, analysis-ready, and easier to visualize. The workflow preserves the raw table, uses staging tables for transformations, and applies a structured cleaning process covering duplicates, standardization, null handling, and unnecessary records.

## Project Objective

The goal of this project was to take raw layoffs data and transform it into a cleaner and more usable dataset for downstream analysis and visualization.

The cleaning process focused on four core tasks:

1. Remove duplicates
2. Standardize the data
3. Handle null and blank values
4. Remove unnecessary rows and preserve raw data through staging

## Tools Used

- MySQL
- SQL window functions
- Common data cleaning techniques
- Staging tables for safe transformations

## Dataset Overview

The dataset contains company layoff information with fields such as:

- company
- location
- industry
- total_laid_off
- percentage_laid_off
- date
- stage
- country
- funds_raised_millions

## Cleaning Workflow

### 1. Created a staging table

Instead of cleaning the raw `layoffs` table directly, I first created a staging table and copied the original data into it. This follows a safer workflow and keeps the raw dataset intact.

### 2. Removed duplicates

To identify duplicate records, I used `ROW_NUMBER()` with `PARTITION BY` across multiple columns including:

- company
- location
- industry
- total_laid_off
- percentage_laid_off
- date
- stage
- country
- funds_raised_millions

Because MySQL does not allow deleting directly from a CTE in this workflow, I created a new staging table and inserted the data with row numbers, then removed rows where the duplicate counter was greater than 1.

### 3. Standardized values

I cleaned and standardized inconsistent values across several columns:

- trimmed extra spaces from `company`
- grouped industry values such as `Crypto`, `Crypto Currency`, and similar variants into a single `Crypto` category
- removed trailing punctuation from `country`
- standardized `United States` entries
- converted the `date` column from text into a proper `DATE` type using `STR_TO_DATE`

### 4. Handled null and blank values

I reviewed records with missing values and treated them based on whether they could be reliably recovered.

For missing `industry` values:
- blank strings were converted to `NULL`
- a self-join was used to populate missing industries when the same company had a valid industry value elsewhere in the dataset

For records where both `total_laid_off` and `percentage_laid_off` were missing:
- those rows were removed because they did not provide useful analytical value

### 5. Final cleanup

After cleaning:
- duplicate-tracking helper columns were removed
- the final cleaned dataset remained in the staging table
- the raw table was preserved

## Key SQL Techniques Used

- `CREATE TABLE ... LIKE`
- `INSERT INTO ... SELECT`
- `ROW_NUMBER() OVER (PARTITION BY ...)`
- `CTE` for duplicate inspection
- `TRIM()`
- `TRIM(TRAILING ...)`
- `LIKE`
- `STR_TO_DATE()`
- `ALTER TABLE`
- `UPDATE ... JOIN`
- `DELETE`
- staging-table workflow

## What I Learned

This project reinforced several important data cleaning principles:

- never clean the raw dataset directly if you can avoid it
- staging tables are useful for safe, repeatable transformations
- duplicates should be checked across the full business-relevant grain of the data
- standardizing text values is critical before analysis
- null values should only be filled when there is enough evidence to do so
- some rows should be removed when they do not contribute meaningful information

## Final Output

The final result is a cleaner layoffs dataset that is more suitable for exploratory analysis, reporting, and visualization.

## Files

- `not so clean notes.pdf` – project notes and cleaning process explanation
- SQL script / queries – full MySQL cleaning workflow
- `README.md` – project documentation
