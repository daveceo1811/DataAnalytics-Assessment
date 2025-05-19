

/*
/scenerio 3: The ops team wants to flag account with no inflow transactions for over one year
Find all the active accounts (Savings or investment) with no transactions in the last 1 year
*/
SELECT 
    p.id AS plan_id, 
    p.owner_id, 
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS days_since_last_transaction
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    -- Active accounts (adjust status_id if needed)
    p.status_id = 1 
    -- Not deleted/archived
    AND p.is_deleted = 0 
    AND p.is_archived = 0
    -- Savings or investment accounts (adjust flags as needed)
    AND (p.is_regular_savings = 1 OR p.is_fixed_investment = 1)
GROUP BY 
    p.id, p.owner_id
HAVING 
    -- No transactions at all OR last transaction > 365 days ago
    MAX(s.transaction_date) IS NULL 
    OR DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) > 365
ORDER BY 
    days_since_last_transaction DESC;
