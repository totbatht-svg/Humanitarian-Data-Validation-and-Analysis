# Humanitarian Data Validation & Statistical Analysis Framework

## Project Overview
This repository documents practical data validation pipelines, mobile survey scripting methodologies, and statistical data-cleaning workflows developed for humanitarian field research. The framework addresses data collection and analysis challenges in low-connectivity, crisis-affected environments—specifically across refugee settlement contexts in the Gambella region of Ethiopia (including Jewi, Kule, Tierkidi, Pugnido, Luakdong, and Nguenyyiel camps).

---

## Technical Stack & Tooling
* **Mobile Data Collection & Scripting:** SurveyCTO / ODK (XLSForm design, constraint logic, regex validation)
* **Statistical Computing & Data Cleaning:** STATA V17 (`summarize`, `codebook`, `tabulate`, outlier detection, batch `.do` script automation)
* **Database & Spreadsheets:** SQL (relational schema integrity), Advanced Microsoft Excel (Pivot tables, cross-tabulation dashboards)
* **Data Security & Ethics:** Personally Identifiable Information (PII) hashing, anonymization protocols, role-based access restrictions

---

## Key Methodologies Implemented

### 1. Client-Side Mobile Survey Logic (SurveyCTO / ODK)
* **Pre-Entry Validation Constraints:** Implemented real-time boundary checks directly on Android mobile collection terminals to prevent illogical numeric entries (e.g., verifying `age >= 18` for household heads; constraining family size metrics).
* **Dynamic Skip Logic & Relevance:** Configured cascaded select menus and dynamic relevance conditions (`relevant` expressions) to eliminate redundant questions and reduce enumerator fatigue.
* **Offline Resiliency:** Optimized form media and caching to allow multi-day offline survey enumeration in remote camp zones without data loss.

### 2. Statistical Data Cleaning & Quality Control (STATA V17)
* **Outlier & Anomaly Detection:** Automated standard deviation and interquartile range (IQR) thresholding to flag suspicious field entries before aggregation.
* **Duplicate Resolution:** Built uniqueness verification scripts matching composite keys (Camp ID + Zone + Household Number) to eliminate duplicate records.
* **Missing Data Diagnostics:** Executed missingness pattern checks to distinguish between structural skips and non-response errors.

### 3. Data Protection & Humanitarian Ethics
* Strictly enforced anonymization protocols removing direct identifiers before secondary statistical analysis.
* Protected vulnerable community records through secure local encryption and hashed respondent identifiers.

---

## Author & Academic Background
* **Lead Researcher / Developer:** Tot Bath Thot
* **Academic Background:** B.Sc. in Computer Science (First Class with Distinction, CGPA: 3.22/4.00), Mizan-Tepi University
* **Field Roles:** IT Teacher (Kule Secondary School) | Field Data Collector (Oxfam) | IT Support (Save the Children)
