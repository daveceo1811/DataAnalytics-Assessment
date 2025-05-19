


/* 
SCENERIO1 : The business wants to identify customers who have both a savings and investments plan(cross-selling opportunity
*/
WITH Saving_count as(
SELECT owner_id,count(*) as Savings_count, Sum(amount) as total_deposit
FROM savings_savingsaccount
Group by owner_id
having Count(*) >= 1
), Investment_count as(
select owner_id,count(*) As investment_count
from plans_plan
Group by owner_id
having Count(*) =1
)
Select sc.Owner_id,concat(First_name,' ',Last_name) as `Name`, sc.Savings_count,Ic.Investment_count,Sc.total_deposit
From Saving_count Sc JOIN Investment_count IC on Sc.Owner_id = IC.Owner_id
JOIN users_customuser UC on UC.id = SC.Owner_id AND UC.id = IC.Owner_id
Order by Sc.savings_count;