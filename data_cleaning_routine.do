* ==============================================================================
* FILE: data_cleaning_routine.do
* AUTHOR: Tot Bath Thot
* DESCRIPTION: Data cleaning, outlier validation, and survey logic check routine 
*              for Gambella Refugee Camps Baseline Survey (Oxfam Fieldwork).
* ==============================================================================

clear all
macro drop _all
set more off

* 1. Load raw anonymized survey dataset
* (Anonymized to protect Personally Identifiable Information - PII)
capture import delimited "raw_household_survey_anonymized.csv", clear

* 2. Basic Data Inspection & Structure Checks
describe
codebook camp_id household_id

* 3. Standardize and Label Categorical Variables
label define camp_labels 1 "Jewi" 2 "Kule" 3 "Tierkidi" 4 "Pugnido" 5 "Luakdong" 6 "Nguenyyiel"
label values camp_id camp_labels

* 4. Run Logic Validation Checks (SurveyCTO Fallback Checks)
* Check: Household head must be >= 18 years old
gen error_underage_head = 0
replace error_underage_head = 1 if age_head < 18 & !missing(age_head)
tabulate error_underage_head if error_underage_head == 1

* Check: Water consumption logic (total daily liters vs household size)
* Flag households consuming > 100 liters per person per day as extreme outliers
gen liters_per_capita = total_water_liters / household_size
gen outlier_water = 0
replace outlier_water = 1 if liters_per_capita > 100 & !missing(liters_per_capita)

* 5. Address Outliers using Interquartile Range (IQR) Rule
* Filter extreme statistical anomalies in household income/consumption variables
egen q25_income = pctile(monthly_income), p(25)
egen q75_income = pctile(monthly_income), p(75)
gen iqr_income = q75_income - q25_income
gen upper_bound_income = q75_income + (3 * iqr_income)

* Flag extreme income values (potential enumerator entry errors)
gen extreme_income_flag = (monthly_income > upper_bound_income) & !missing(monthly_income)
tabulate extreme_income_flag

* 6. Export Cleaned Dataset for Secondary Data Analysis
drop error_underage_head outlier_water q25_income q75_income iqr_income upper_bound_income
export delimited using "cleaned_household_survey_dataset.csv", replace

di "=== STATA DATA CLEANING PIPELINE COMPLETED SUCCESSFULLY ==="
