SHOW VARIABLES LIKE 'local_infile';

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW SESSION VARIABLES LIKE 'local_infile';


use telco_churn_db;
SELECT COUNT(*) AS total_rows
FROM telco_customers;

LOAD DATA LOCAL INFILE 'C:/Users/PRAJAKTA/Desktop/imarticus/telco_churn_mysql_ready.csv'
INTO TABLE telco_customers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    TenureGroup
);

SELECT COUNT(*) AS total_customers
FROM telco_customers;

SELECT *
FROM telco_customers
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    SUM(customerID IS NULL) AS missing_customer_ids,
    SUM(MonthlyCharges IS NULL) AS missing_monthly_charges,
    SUM(TotalCharges IS NULL) AS missing_total_charges
FROM telco_customers;

-- How many customers have churned, and how many have stayed
SELECT
    Churn,
    COUNT(*) AS customer_count
FROM telco_customers
GROUP BY Churn;

-- Calculate the churn rate
SELECT
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate_percentage
FROM telco_customers;

-- Churn by contract type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY Contract
ORDER BY churn_rate DESC;

-- Churn by Internet Service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- Churn by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- Churn by Tenure Group
SELECT
    TenureGroup,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY TenureGroup
ORDER BY churn_rate DESC;

-- Churn by Senior Citizen Status
SELECT
    CASE
        WHEN SeniorCitizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS customer_category,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;

-- Monthly Charges vs Churn
SELECT
    CASE
        WHEN MonthlyCharges < 30 THEN 'Low Charges'
        WHEN MonthlyCharges BETWEEN 30 AND 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charge_category,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customers
GROUP BY charge_category
ORDER BY churn_rate DESC;

-- Churn by Gender
SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(
        SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM telco_customers
GROUP BY gender
ORDER BY churn_rate DESC;

-- Average customer tenure
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(tenure), 2) AS average_tenure_months,
    MIN(tenure) AS minimum_tenure,
    MAX(tenure) AS maximum_tenure
FROM telco_customers
GROUP BY Churn;

-- Find high-churn contract types
WITH ContractChurn AS (
    SELECT
        Contract,
        COUNT(*) AS total_customers,
        SUM(Churn = 'Yes') AS churned_customers,
        ROUND(
            SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2
        ) AS churn_rate
    FROM telco_customers
    GROUP BY Contract
)

SELECT *
FROM ContractChurn
WHERE churn_rate > 10
ORDER BY churn_rate DESC;

-- Find customers paying more than the average monthly charge
SELECT
    customerID,
    gender,
    MonthlyCharges,
    Churn
FROM telco_customers
WHERE MonthlyCharges > (
    SELECT AVG(MonthlyCharges)
    FROM telco_customers
);

SELECT
    customerID,
    MonthlyCharges,
    Churn
FROM telco_customers
WHERE Churn = 'Yes'
AND MonthlyCharges > (
    SELECT AVG(MonthlyCharges)
    FROM telco_customers
);

-- rank customers based on their monthly charges.
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    ROW_NUMBER() OVER (
        ORDER BY MonthlyCharges DESC
    ) AS row_num
FROM telco_customers
LIMIT 10;

-- rank customers separately within each contract type.
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    RANK() OVER (
        PARTITION BY Contract
        ORDER BY MonthlyCharges DESC
    ) AS charge_rank
FROM telco_customers
LIMIT 20;

-- Find the top 5 highest-paying customers in each contract type
WITH CustomerRanking AS (
    SELECT
        customerID,
        Contract,
        MonthlyCharges,
        Churn,
        RANK() OVER (
            PARTITION BY Contract
            ORDER BY MonthlyCharges DESC
        ) AS customer_rank
    FROM telco_customers
)
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    Churn,
    customer_rank
FROM CustomerRanking
WHERE customer_rank <= 5
ORDER BY Contract, customer_rank;

-- How does each customer's monthly charge compare with the previous customer's charge
SELECT
    customerID,
    MonthlyCharges,
    LAG(MonthlyCharges) OVER (
        ORDER BY MonthlyCharges
    ) AS previous_charge
FROM telco_customers
LIMIT 10;

-- SQL retrieves the next customer's charge instead.
	SELECT
    customerID,
    MonthlyCharges,
    LEAD(MonthlyCharges) OVER (
        ORDER BY MonthlyCharges
    ) AS next_charge
FROM telco_customers
LIMIT 10;

-- compare average monthly charges across contract types using LAG()
WITH ContractCharges AS (
    SELECT
        Contract,
        ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
    FROM telco_customers
    GROUP BY Contract
)
SELECT
    Contract,
    avg_monthly_charge,
    LAG(avg_monthly_charge) OVER (
        ORDER BY avg_monthly_charge
    ) AS previous_contract_charge
FROM ContractCharges;

-- Revenue loss due to customer churn
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charge
FROM telco_customers
GROUP BY Churn;

-- Calculate monthly revenue at risk
SELECT
    COUNT(*) AS churned_customers,
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_at_risk,
    ROUND(AVG(MonthlyCharges), 2) AS avg_charge_per_churned_customer
FROM telco_customers
WHERE Churn = 'Yes';

SELECT
    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    SUM(CASE
        WHEN Churn = 'No' THEN 1
        ELSE 0
    END) AS retained_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS churn_rate,

    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes'
            THEN MonthlyCharges ELSE 0 END), 2
    ) AS monthly_revenue_at_risk

FROM telco_customers;