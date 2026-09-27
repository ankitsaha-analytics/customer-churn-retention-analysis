# Customer Churn & Retention Analysis

## Project Overview

This project presents an end-to-end analysis of customer churn for a telecommunications company. The objective is to identify customer segments associated with higher churn, quantify monthly revenue associated with churned customers, and provide data-driven recommendations to support customer retention.

The project demonstrates a complete data analytics workflow using **Excel, PostgreSQL, Python, and Power BI** — from data cleaning and exploratory analysis to SQL querying, customer segmentation, visualization, and business recommendations.

## Business Problem

Customer churn directly impacts recurring revenue and long-term customer value. The analysis focuses on answering the following business questions:

- What is the overall customer churn rate?
- Which contract types are associated with higher churn?
- How does customer tenure relate to churn?
- Which internet services and payment methods have higher churn rates?
- How are Tech Support and Online Security associated with churn?
- How much monthly revenue is associated with churned customers?
- Which customer segments should be prioritized for retention efforts?

## Tools & Technologies

- **Excel** — Data cleaning, validation, exploratory analysis, and pivot-based analysis
- **PostgreSQL** — SQL querying, aggregation, segmentation, and revenue analysis
- **Python (Pandas & Matplotlib)** — Exploratory data analysis, visualization, and high-risk customer identification
- **Power BI** — DAX measures, KPI tracking, interactive visualization, and dashboard development
- **GitHub** — Project documentation and portfolio presentation

## Dataset

The analysis uses the IBM Telco Customer Churn dataset containing **7,043 customer records** and **21 variables** covering:

- Customer demographics
- Account tenure
- Contract type
- Internet service
- Support services
- Payment method
- Monthly and total charges
- Customer churn status

During data-quality analysis, **11 blank TotalCharges records** were identified. These customers had a tenure of 0 months, indicating newly acquired customers with no accumulated charges. The records were retained rather than removed.

No duplicate customer IDs were identified.

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Customers | 7,043 |
| Churned Customers | 1,869 |
| Overall Churn Rate | 26.54% |
| Retention Rate | 73.46% |
| Monthly Revenue Associated with Churned Customers | 139,130.85 |

## Key Findings

### 1. Contract Type
Customers on **month-to-month contracts had a 42.71% churn rate**, compared with **11.27% for one-year contracts** and **2.83% for two-year contracts**.

### 2. Customer Tenure
Churn was highest among customers in their first 12 months:

- 0–12 months: **47.44%**
- 13–24 months: **28.71%**
- 25–48 months: **20.39%**
- 49–72 months: **9.51%**

This indicates that the early customer lifecycle is an important retention period.

### 3. Internet Service
Customers using **Fiber Optic service had a 41.89% churn rate**, compared with **18.96% for DSL** and **7.40% for customers without internet service**.

### 4. Payment Method
Customers using **Electronic Check had a 45.29% churn rate**, the highest among the analyzed payment methods.

### 5. Tech Support
Customers without Tech Support had a **41.64% churn rate**, compared with **15.17% among customers with Tech Support**.

### 6. Online Security
Customers without Online Security had a **41.77% churn rate**, compared with **14.61% among customers with Online Security**.

### 7. Monthly Charges
Average monthly charges were higher among churned customers:

- Churned customers: **74.44**
- Retained customers: **61.27**

### 8. High-Risk Customer Segment
A high-risk segment was defined as customers who:

- Have a **month-to-month contract**
- Have **12 months or less tenure**
- Have **MonthlyCharges greater than 80**

This segment contained **464 customers**, of whom **341 churned**, resulting in a **73.49% churn rate**.

## Business Recommendations

Based on the analysis:

1. Strengthen onboarding and proactive engagement during the first 12 months of the customer lifecycle.
2. Encourage eligible month-to-month customers to transition toward longer-term contracts through targeted incentives.
3. Investigate customer experience and service-quality factors associated with Fiber Optic customers.
4. Promote Tech Support and Online Security services to relevant customer segments.
5. Review the customer journey associated with Electronic Check payments and encourage convenient automatic payment options where appropriate.
6. Prioritize retention campaigns for customers matching the identified high-risk profile.
7. Monitor customers with relatively high monthly charges for signs of dissatisfaction and potential churn.

> **Note:** The analysis identifies associations within the dataset and does not establish that these factors directly cause customer churn.

## Power BI Dashboard

The interactive Power BI dashboard tracks:

- Total Customers
- Churned Customers
- Churn Rate
- Retention Rate
- Monthly Revenue at Risk
- Churn by Contract Type
- Churn by Tenure Group
- Churn by Internet Service
- Churn by Tech Support
- Churn by Payment Method
- Churned Customers by Paperless Billing
- Churned Customers by Online Security

The dashboard also includes an interactive **Contract Type slicer** for customer-segment analysis.

## Repository Structure

```text
customer-churn-retention-analysis/
│
├── data/       # Cleaned customer churn dataset
├── excel/      # Excel analysis workbook
├── sql/        # PostgreSQL analysis and queries
├── python/     # Python analysis notebook
├── powerbi/    # Power BI dashboard
└── README.md   # Project documentation
