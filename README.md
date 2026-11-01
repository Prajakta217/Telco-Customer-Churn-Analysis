# Telco Customer Churn Analysis & Retention Dashboard

## Project Overview
An end-to-end data analytics project that explores customer churn patterns in a telecommunications dataset. The goal is to identify customer segments with higher churn rates and provide data-driven recommendations to improve customer retention.

## Business Objectives
- Calculate the overall customer churn rate.
- Identify customer segments with higher churn.
- Analyze churn across contract types, internet services, payment methods, and tenure groups.
- Present insights through an interactive Power BI dashboard.
- Recommend strategies to support customer retention.

## Tools & Technologies
- **Python:** Data cleaning and preprocessing
- **Pandas:** Data manipulation
- **MySQL:** SQL queries and business analysis
- **Power BI:** Interactive dashboard and visualization
- **Jupyter Notebook:** Exploratory data analysis

## Project Workflow
1. Data cleaning and preprocessing using Python.
2. Exploratory data analysis.
3. Importing the cleaned dataset into MySQL.
4. Performing SQL analysis using aggregations, joins, CTEs, subqueries, and window functions.
5. Creating an interactive Power BI dashboard.
6. Interpreting findings and preparing business recommendations.

## Key Findings

| Metric | Result |
|---|---:|
| Total Customers | 7,043 |
| Churned Customers | 1,869 |
| Retained Customers | 5,174 |
| Overall Churn Rate | 26.54% |

### Churn by Contract Type

| Contract | Churn Rate |
|---|---:|
| Month-to-month | 42.71% |
| One year | 11.27% |
| Two year | 2.83% |

### Churn by Internet Service

| Internet Service | Churn Rate |
|---|---:|
| Fiber optic | 41.89% |
| DSL | 18.96% |
| No internet | 7.40% |

## Business Recommendations
- Explore loyalty incentives and longer-term contract options for month-to-month customers.
- Investigate pricing, service quality, and support experiences among fiber optic customers.
- Identify potentially at-risk customers early and offer targeted retention support.
- Monitor customer churn regularly using business KPIs.

## Dashboard Features
- Customer and churn KPIs
- Customer churn distribution
- Churn analysis by contract type
- Churn analysis by internet service
- Payment method and tenure analysis
- Senior citizen and monthly charge category analysis
- Interactive slicers for filtering dashboard results

## Repository Structure
```text
Telco-Customer-Churn-Analysis/
├── data/
├── notebooks/
├── sql/
├── powerbi/
├── reports/
└── README.md
```

## Dataset
This project uses the publicly available IBM Telco Customer Churn dataset.

## Conclusion
This project demonstrates an end-to-end data analytics workflow, from data preparation and SQL analysis to interactive dashboard development and business recommendations.

**Note:** The analysis identifies associations and patterns in a public dataset; it does not establish the causes of customer churn.