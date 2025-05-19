

/*
SCENERIO2: The finance team wants to analyze how often customer transact to segment them
Calculate the average number of transaction per customer per month and categorize them into 
	High Frequency (>= 10 transactions/Month)
    Medium Frequency(3-9 transactions/month)
    low Frequency(=< 2 transations/month)
*/

WITH Transaction_count as (
select Owner_id, count(transaction_reference) As Total_Transaction,
 year(Transaction_date) As Transaction_Year, month(Transaction_date) As Transaction_month
From savings_savingsaccount
group by owner_id,transaction_date
)
SELECT Case when avg(Total_Transaction) >= 10 then 'High Frequency'
When avg(Total_Transaction) between 3 and 9 then 'Mediam Frequency'
when avg(Total_Transaction) <= 2 then 'low Frequency' End As `Frequency Category`,
Count(TC.Owner_id) AS Customer_count, avg(Total_Transaction) as Average_transaction_per_month  , Transaction_month
FROM Transaction_count TC join users_customuser UC on TC.Owner_id = UC.ID
-- WHERE Transaction_Year ='2022' AND Transaction_month = '4'
GROUP BY Transaction_month;

