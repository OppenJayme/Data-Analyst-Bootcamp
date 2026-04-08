# Layoffs Data Cleaning in MySQL Workbench

Performed end-to-end data cleaning in MySQL Workbench on a layoffs dataset by creating staging tables, removing duplicates with `ROW_NUMBER()`, standardizing inconsistent text values, converting dates, and resolving missing values. The result was a cleaner, more reliable dataset prepared for downstream analysis and visualization.

## Project Objective

The goal of this project was to transform raw layoffs data into a cleaner and more usable dataset for analysis.

The cleaning process focused on four core tasks:

1. Remove duplicates
2. Standardize the data
3. Handle null and blank values
4. Remove unnecessary rows while preserving the raw data through staging tables

## Tools Used

- MySQL Workbench
- MySQL
- SQL

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

### 1. Created staging tables

Instead of cleaning the raw `layoffs` table directly, I first created staging tables and copied the original data into them. This preserved the raw dataset and allowed the cleaning steps to be performed safely.

### 2. Removed duplicates

To identify duplicate records, I used `ROW_NUMBER()` with `PARTITION BY` across multiple columns, including:

- company
- location
- industry
- total_laid_off
- percentage_laid_off
- date
- stage
- country
- funds_raised_millions

Because deleting directly from a CTE was not practical in this workflow, I created a new staging table, inserted the data with row numbers, and removed records where the duplicate counter was greater than 1.

### 3. Standardized values

I cleaned and standardized inconsistent values across several columns:

- trimmed extra spaces from `company`
- grouped industry values such as `Crypto`, `Crypto Currency`, and similar variants into a single `Crypto` category
- removed trailing punctuation from `country`
- standardized `United States` entries
- converted the `date` column from text into a proper `DATE` type using `STR_TO_DATE`

### 4. Handled null and blank values

I reviewed records with missing values and handled them based on whether they could be reliably recovered.

For missing `industry` values:
- blank strings were converted to `NULL`
- a self-join was used to populate missing industries when the same company had a valid industry value elsewhere in the dataset

For records where both `total_laid_off` and `percentage_laid_off` were missing:
- those rows were removed because they did not provide useful analytical value

### 5. Final cleanup

After cleaning:
- duplicate-tracking helper columns were removed
- the cleaned dataset remained in the staging table
- the raw table was preserved

## Key SQL Techniques Used

- `CREATE TABLE ... LIKE`
- `INSERT INTO ... SELECT`
- `ROW_NUMBER() OVER (PARTITION BY ...)`
- `CTE`
- `TRIM()`
- `TRIM(TRAILING ...)`
- `LIKE`
- `STR_TO_DATE()`
- `ALTER TABLE`
- `UPDATE ... JOIN`
- `DELETE`

## Final Output

The final output is a cleaner layoffs dataset that is more consistent, more reliable, and better suited for exploratory analysis and visualization.

## Files

- `not so clean notes.pdf` - project notes and cleaning walkthrough
- SQL queries / script - full MySQL Workbench cleaning workflow
- `README.md` - project documentation
