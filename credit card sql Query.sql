CREATE DATABASE credit_project;
USE credit_project;
-- show table status

SELECT * FROM final_credit_data LIMIT 10;

-- Avg Utilization

SELECT AVG(`Utilization_%`) AS Avg_Utilization
FROM final_credit_data;

-- Utilization Segment Count

SELECT
     Utilization_Segment,
     COUNT(*) AS Total_Customers
FROM final_credit_data
GROUP BY Utilization_Segment;

-- High Utilization Customers (Top spenders)

SELECT
    ID,
    `Utilization_%`,
    Total_Spend
FROM final_credit_data
ORDER BY `Utilization_%` DESC
LIMIT 10; 

-- Risk Customers 

SELECT
     Risk_Flag,
     COUNT(*) AS Total_Customers
FROM Final_credit_data
GROUP BY Risk_flag;  

-- High Risk Customers

SELECT
    ID,
    `Utilization_%`,
    Avg_Delay,
    Risk_Flag
FROM final_credit_data
WHERE `Utilization_%` > 0.7
AND Avg_Delay > 1
ORDER BY `Utilization_%` DESC
LIMIT 10;  

-- Revenue Opportunity (Low Utilization) 

SELECT
	COUNT(*) AS Low_Util_Customers,
    AVG(Total_Spend) AS Avg_Spend,
    AVG(LIMIT_BAL) AS Avg_Limit
FROM final_credit_data
WHERE Utilization_Segment = 'Low';

-- Decision Segmentation

SELECT
	Utilization_Segment,
    COUNT(*) AS Customers,
    AVG(`Utilization_%`) AS Avg_Utilization
FROM final_credit_data
GROUP BY Utilization_Segment; 

-- FINAL CASE Segmentation


SELECT 
    Utilization_Segment,
    CASE 
        WHEN Utilization_Segment = 'Low' THEN 'Increase Limit'
        WHEN Utilization_Segment = 'Medium' THEN 'Maintain'
        ELSE 'Reduce / Monitor'
    END AS Recommended_Action,
    COUNT(*) AS Customers
FROM final_credit_data
GROUP BY Utilization_Segment;