CREATE TABLE customer_churn (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(25),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(25),
    OnlineBackup VARCHAR(25),
    DeviceProtection VARCHAR(25),
    TechSupport VARCHAR(25),
    StreamingTV VARCHAR(25),
    StreamingMovies VARCHAR(25),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(40),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn VARCHAR(5)
);

SELECT COUNT(*) AS Total_customers
FROM customer_churn;


SELECT * FROM customer_churn
LIMIT 10;

SELECT customerID, tenure, MonthlyCharges, Churn
FROM customer_churn
LIMIT 10;

------our Excel analysis where we counted 1,869 churned customers---
------IN SQL----

SELECT COUNT(*) AS churned_customers
FROM customer_churn
WHERE Churn = 'Yes';

SELECT COUNT(*) AS churned_customers
FROM customer_churn
WHERE Churn = 'No';


SELECT customerID, tenure, Contract, MonthlyCharges, Churn
FROM customer_churn
WHERE Churn = 'Yes'
LIMIT 10;


---Finding high-value churned customers: Among customers who churned, who was paying the highest monthly charges?--- (118.35)


SELECT customerID, tenure, contract, monthlycharges, churn
FROM customer_churn
WHERE churn = 'Yes'
ORDER BY monthlycharges DESC LIMIT 10;


---- Find the lowest-paying churned customers--- (lowest monthly charge 18.85)

SELECT customerID, tenure, contract, monthlycharges, churn
FROM customer_churn
WHERE churn = 'Yes'
ORDER BY monthlycharges ASC LIMIT 10;

---— Churn by Contract Type--- (one year = 1473, Month-to-month = 3875, Two year = 1695)

SELECT Contract, COUNT(*) AS total_customers
FROM customer_churn
GROUP BY Contract;


---— Add churned customers to each contract group---

SELECT * FROM customer_churn
LIMIT 10;

SELECT 
	contract, 
	COUNT(*) AS Total_customers,
	COUNT(*) FILTER (WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS
FROM  customer_churn
GROUP BY contract;
	


SELECT 
	contract,
	COUNT(*) AS Total_customers,
	COUNT(*) FILTER (WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	COUNT(*) FILTER(WHERE churn = 'No') AS NON_CHURNED_CUSTOMERS
FROM customer_churn
GROUP BY contract;


-- — Calculate Churn Rate--- The formula is:

--Churn Rate = Churned Customers ÷ Total Customers × 100--


SELECT 
	contract,
	COUNT(*) AS Total_customers,
	COUNT(*) FILTER (WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(
		COUNT(*) FILTER (WHERE Churn = 'Yes') * 100/COUNT(*),
		2) AS Churn_Rate
FROM customer_churn
GROUP BY contract;


--- — Churn by Internet Service-- which internet service has highest churn rate?--

SELECT 
	internetservice,
	COUNT(*) AS Total_customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS
FROM customer_churn
GROUP BY internetservice;


SELECT 
	internetservice,
	COUNT(*) AS Total_customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*)FILTER (WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY internetservice
ORDER BY CHURN_RATE DESC;


--- CUSTOMERS CLASSIFIED ON BASIS OF MONTHLY CHARGES USING CASE-WHEN---

SELECT * FROM customer_churn
LIMIT 10;

SELECT customerID, monthlycharges,
	CASE
		WHEN monthlycharges < 30 THEN 'LOW_VALUE'
		WHEN monthlycharges <= 70 THEN 'MEDIUM_VALUE'
		ELSE 'HIGH_VALUE'
	END AS customer_value
FROM customer_churn
LIMIT 20;


---- How many customers fall into each monthly-charge segment, and how many of them churned?---


SELECT 
	CASE
		WHEN monthlycharges < 30 THEN 'LOW_VALUE'
		WHEN monthlycharges <= 70 THEN 'MEDIUM VALUE'
		ELSE 'HIGH VALUE'
	END AS customer_value,
	COUNT(*) AS TOTAL_CUSTOMERS,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*)FILTER(WHERE Churn = 'Yes')*100.0 /COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY customer_value
ORDER BY CHURN_RATE DESC;



--- — Churn by Payment Method---

SELECT * FROM customer_churn
LIMIT 10;


SELECT paymentmethod,
	COUNT(*) AS TOTAL_CUSTOMERS,
	COUNT(*) FILTER(WHERE churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE churn = 'Yes') * 100.0/ COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY paymentmethod
ORDER BY CHURN_RATE DESC;




---- Churn rate for each tenure customer groups -----


SELECT 
	CASE
		WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
		WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
		WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
		ELSE '49-72 Months'
	END AS Tenure_group,

	COUNT(*) AS TOTAL_CUSTOMERS,
	COUNT(*) FILTER(WHERE churn = 'Yes') AS CHURNED_CUSTOMERS,

	ROUND (COUNT(*) FILTER(WHERE churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY Tenure_group
ORDER BY CHURN_RATE DESC;


---- CHURN BY TECH SUPPORT---



SELECT techsupport,
	COUNT(*) AS TOTAL_CUSTOMERS,
	COUNT(*) FILTER(WHERE churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND (COUNT (*) FILTER(WHERE churn = 'Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY techsupport
ORDER BY churn_rate DESC;

--- CHURN BY ONLINE SECURITY---

-- Churn by Online Security

SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY OnlineSecurity
ORDER BY churn_rate DESC;


-- Multi-factor Churn Analysis
-- Contract + Internet Service + Tenure Group

SELECT * FROM customer_churn
LIMIT 10;



SELECT 
	contract,
	internetservice,

	CASE
		WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
		WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
		WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
		ELSE '49-72 Months'
	END AS Tenure_group,

	COUNT(*) AS Total_customers,
	COUNT(*) FILTER(WHERE churn = 'Yes') AS CHURNED_CUSTOMERS,

	ROUND (COUNT(*)FILTER(WHERE churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn

GROUP BY 
	contract,
	internetservice,
	Tenure_group

HAVING COUNT(*) >=50

ORDER BY CHURN_RATE DESC LIMIT 10;



--- Customer Demographics---
SELECT * FROM customer_churn
LIMIT 10;

SELECT 
	seniorcitizen,
	COUNT(*) AS Total_Customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY seniorcitizen
ORDER BY churn_rate DESC;



-- PARTNER STATUS--

SELECT * FROM customer_churn
LIMIT 10;

SELECT partner,
	COUNT(*) AS Total_Customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY partner
ORDER BY CHURN_RATE DESC;


--- Churn by Dependents Status---


-- Churn by Dependents Status

SELECT
    Dependents,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY Dependents
ORDER BY churn_rate DESC;

--- by phone service---


SELECT phoneservice,
	COUNT(*) AS Total_Customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY phoneservice
ORDER BY CHURN_RATE DESC;

--- multiple lines---

SELECT multiplelines,
	COUNT(*) AS Total_Customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY multiplelines
ORDER BY CHURN_RATE DESC;



--- Paperlessbilling---

SELECT paperlessbilling,
	COUNT(*) AS Total_Customers,
	COUNT(*) FILTER(WHERE Churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE Churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY paperlessbilling
ORDER BY CHURN_RATE DESC;


----multidimensional analysis--- (payment + contract)

SELECT paymentmethod, contract,
	COUNT(*) AS TOTAL_CUSTOMERS,
	COUNT(*) FILTER(WHERE churn = 'Yes') AS CHURNED_CUSTOMERS,
	ROUND(COUNT(*) FILTER(WHERE churn = 'Yes')*100.0/COUNT(*),2) AS CHURN_RATE
FROM customer_churn
GROUP BY paymentmethod, contract
ORDER BY CHURN_RATE DESC;


---- REVENUE AT RISK---


SELECT * FROM customer_churn
LIMIT 10;

SELECT 
	SUM(monthlycharges) AS TOTAL_MONTHLY_REVENUE,
	SUM(monthlycharges) FILTER(WHERE churn = 'Yes') AS MONTHLY_REVENUE_CHURNED
FROM customer_churn;


--- CALCULATE REVENUE AT RISK %--

SELECT 
	SUM(monthlycharges) AS TOTAL_MONTHLY_REVENUE,
	SUM(monthlycharges) FILTER(WHERE churn = 'Yes') AS MONTHLY_REVENUE_CHURNED,
	ROUND(SUM(monthlycharges) FILTER(WHERE churn = 'Yes')*100.0/SUM(monthlycharges),2) AS MONTHLY_REVENUE_RISK
FROM customer_churn;

