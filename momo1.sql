-- Add a column 'Loyalty Points' in 'Transactions' table
ALTER  TABLE dbo.[data.-transaction_1] ADD Loyalty_Points INT;
-- Update 'Loyalty_Points' column in 'dbo.[data.-transaction_1]' table based on the given rules
UPDATE dbo.[data.-transaction_1] SET Loyalty_Points =
CASE
WHEN NEWVERTICAL_Merchant = 'supermarket' THEN
CASE
WHEN GMV / 1000 > 500 THEN 500
ELSE GMV / 1000  
END
WHEN NEWVERTICAL_Merchant = 'data' THEN
CASE
WHEN GMV / 1000 > 1000 THEN 1000
ELSE GMV / 1000
END
WHEN NEWVERTICAL_Merchant = 'cvs' THEN
CASE
WHEN GMV / 1000 > 500 THEN 500
ELSE GMV / 1000
END
WHEN NEWVERTICAL_Merchant = 'marketplace' THEN
CASE
WHEN GMV / 1000 > 500 THEN 500
ELSE GMV / 1000
END
WHEN NEWVERTICAL_Merchant = 'Coffee chains and Milk tea' THEN
CASE
WHEN GMV / 1000 > 500 THEN 500
ELSE GMV / 1000
END
WHEN NEWVERTICAL_Merchant = 'Offline Beverage' THEN
CASE
WHEN GMV / 1000 > 300 THEN 300
ELSE GMV / 1000
END
ELSE 0
END
WHERE DATE >= DATEADD(day, -30, GETDATE());

-- Create 'Loyalty Ranking' table
CREATE TABLE Loyalty_Ranking (
    User_id INT,
    Date DATE,
    Total_Loyalty_Points INT,
    Rank_name VARCHAR(10),
);

-- Calculate total loyalty points for each user on a daily basis

INSERT INTO Loyalty_Ranking (User_id, Date, Total_Loyalty_Points)
SELECT 
User_id,
DATE,
SUM(Loyalty_Points) AS Total_Loyalty_Points
FROM [data.-transaction_1]
GROUP BY User_id, DATE ;

-- Assign rank to each user based on their total loyalty points

UPDATE Loyalty_Ranking SET
    Rank_name = CASE 
        WHEN Total_Loyalty_Points BETWEEN 1 AND 999 THEN 'STANDARD'
        WHEN Total_Loyalty_Points BETWEEN 1000 AND 1999 THEN 'SILVER'
        WHEN Total_Loyalty_Points BETWEEN 2000 AND 4999 THEN 'GOLD'
        WHEN Total_Loyalty_Points >= 5000 THEN 'DIAMOND'
    END 
---
ALTER TABLE dbo.[data.-transaction_1] ADD ClassID INT;
---

UPDATE dbo.[data.-transaction_1] SET ClassID = 
    CASE 
        WHEN Rank_name = 'STANDARD' THEN 1
        WHEN Rank_name = 'SILVER' THEN 2
        WHEN Rank_name = 'GOLD' THEN 3
        WHEN Rank_name = 'DIAMOND' THEN 4
    END;

---

SELECT  Count (distinct User_id)  as number_id_gold
FROM Loyalty_Ranking
WHERE Rank_name = 'GOLD';

-- Count the number of users who achieved Gold rank at the end of March 2022 = 164

-- Add Rank_name column to dbo.[data.-transaction_1] table

ALTER TABLE dbo.[data.-transaction_1] ADD Rank_name VARCHAR(10);

-- Update Rank_name column in dbo.[data.-transaction_1] table using data from Loyalty_Ranking table

UPDATE dbo.[data.-transaction_1] 
SET Rank_name = (
    SELECT TOP 1 Rank_name 
    FROM Loyalty_Ranking 
    WHERE Loyalty_Ranking.User_id = dbo.[data.-transaction_1].User_id 
    AND Loyalty_Ranking.Date = dbo.[data.-transaction_1].DATE
);
-- 
ALTER TABLE dbo.[data.-transaction_1] 
ADD [%cash_back] INT;
--
UPDATE dbo.[data.-transaction_1] 
SET [%cash_back] = 
    CASE 
        WHEN [ClassID] = 2 AND [NEWVERTICAL_Merchant] = 'cvs' THEN 5
        WHEN [ClassID] = 2 AND [NEWVERTICAL_Merchant] = 'Offline Beverage' THEN 5
        WHEN [ClassID] = 2 AND [NEWVERTICAL_Merchant] = 'data' THEN 5
        WHEN [ClassID] = 3 AND [NEWVERTICAL_Merchant] = 'cvs' THEN 7
        WHEN [ClassID] = 3 AND [NEWVERTICAL_Merchant] = 'Offline Beverage' THEN 7
        WHEN [ClassID] = 3 AND [NEWVERTICAL_Merchant] = 'cvs' THEN 7
        WHEN [ClassID] = 3 AND [NEWVERTICAL_Merchant] = 'marketplace' THEN 2
        WHEN [ClassID] = 3 AND [NEWVERTICAL_Merchant] = 'supermarket' THEN 2
        WHEN [ClassID] = 4 AND [NEWVERTICAL_Merchant] = 'cvs' THEN 12
        WHEN [ClassID] = 4 AND [NEWVERTICAL_Merchant] = 'Offline Beverage' THEN 12
        WHEN [ClassID] = 4 AND [NEWVERTICAL_Merchant] = 'data' THEN 12
        WHEN [ClassID] = 4 AND [NEWVERTICAL_Merchant] = 'marketplace' THEN 5
        WHEN [ClassID] = 4 AND [NEWVERTICAL_Merchant] = 'supermarket' THEN 5
        ELSE 0 
    END;
 ---
 ALTER TABLE dbo.[data.-transaction_1] 
 ADD [cash_back] INT;
--
UPDATE dbo.[data.-transaction_1] 
SET [cash_back] = 
    case 
    when [%cash_back] * [GMV] > 10000 then 10000
    end ;
---
SELECT SUM(cash_back) as total_refund
FROM dbo.[data.-transaction_1]
WHERE MONTH(date) = 2 AND YEAR(date) = 2022
--Total cashback cost in Feb 2022 = 610000

---
SELECT 
    DATEADD(WEEK, DATEDIFF(WEEK, 0, date), 0) AS week_start_date, 
    ISNULL(SUM(cash_back),0) as total_refund ,
    COUNT(Order_id) as Order_time,
    COUNT(distinct User_id) as new_customer,
    COUNT(CASE WHEN Rank_name = 'Silver' THEN User_id END) as silver_customers,
    COUNT(CASE WHEN Rank_name = 'Gold' THEN User_id END) as gold_customers,
    COUNT(CASE WHEN Rank_name = 'Diamond' THEN User_id END) as diamond_customers
FROM dbo.[data.-transaction_1]
GROUP BY DATEADD(WEEK, DATEDIFF(WEEK, 0, date), 0) 
ORDER by week_start_date


-- ALTER TABLE dbo.[data.-transaction_1]
-- ADD week_start_date DATE, total_refund DECIMAL(18, 2)
-- ---
-- UPDATE dbo.[data.-transaction_1]
-- SET week_start_date = DATEADD(WEEK, DATEDIFF(WEEK, 0, date), 0),
--     total_refund = (SELECT SUM(cash_back) 
--                     FROM dbo.[data.-transaction_1] AS t 
--                     WHERE DATEADD(WEEK, DATEDIFF(WEEK, 0, t.date), 0) = DATEADD(WEEK, DATEDIFF(WEEK, 0, dbo.[data.-transaction_1].date), 0)
--                    )
-- FROM dbo.[data.-transaction_1]
---
