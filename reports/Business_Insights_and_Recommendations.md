# Telco Customer Churn Analysis
## Business Insights & Recommendations

### 1. Project Overview
This project analyzes customer churn using the IBM Telco Customer Churn public dataset. The objective is to identify customer groups with higher churn rates and recommend strategies to improve customer retention.

**Dataset:** IBM Telco Customer Churn  
**Total customers:** 7,043  
**Customers who churned:** 1,869  
**Customers retained:** 5,174  
**Overall churn rate:** 26.54%

### 2. Key Business Insights

**Insight 1: High overall customer churn**

The overall churn rate is 26.54%, meaning approximately 27 out of every 100 customers left the service.

**Business implication:** Customer retention should be a key business priority.

**Insight 2: Month-to-month contracts have the highest churn**

| Contract type | Churn rate |
|---|---:|
| Month-to-month | 42.71% |
| One year | 11.27% |
| Two year | 2.83% |

Customers with month-to-month contracts show substantially higher churn than customers with longer contracts.

**Business implication:** Customers without long-term commitments may need additional engagement and retention incentives.

**Insight 3: Fiber optic customers show higher churn**

| Internet service | Churn rate |
|---|---:|
| Fiber optic | 41.89% |
| DSL | 18.96% |
| No internet | 7.40% |

Fiber optic customers have the highest churn rate among the three internet service groups.

**Business implication:** The company could investigate pricing, service quality, customer expectations, and support experiences for fiber optic customers.

### 3. Business Recommendations

1. **Improve month-to-month customer retention:** Introduce loyalty rewards, personalized offers, and attractive longer-term contract options.
2. **Investigate fiber optic customer dissatisfaction:** Review service complaints, pricing, network reliability, and support response times.
3. **Identify at-risk customers early:** Monitor customer tenure, monthly charges, contract type, and service usage to identify customers who may need retention support.
4. **Strengthen customer engagement:** Use personalized communication and feedback surveys to understand customer concerns.
5. **Monitor churn regularly:** Track churn rate and customer retention KPIs through an interactive dashboard.

### 4. Tools and Technologies

- Python – Data cleaning and preprocessing
- Pandas – Data manipulation
- MySQL – SQL analysis and business queries
- Power BI – Interactive dashboard and visualization

### 5. Conclusion

The analysis identified important customer segments associated with higher churn, particularly month-to-month contract customers and fiber optic internet customers.

The findings can help a telecom business investigate customer dissatisfaction, prioritize retention efforts, and make data-driven decisions.

This project demonstrates an end-to-end data analytics workflow involving data cleaning, SQL analysis, business interpretation, and interactive dashboard development.

**Note:** This analysis uses a publicly available dataset. The observed relationships do not establish the causes of customer churn.