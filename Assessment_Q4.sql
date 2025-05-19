

/*
SCENERIO 4: Marketing wants to evaluate Customer Livetime Value based on account tenure and transaction volume
*/

WITH 
-- Get customer information
customer_data AS (
    SELECT 
        id,
        COALESCE(name, CONCAT(first_name, ' ', last_name)) AS customer_name,
        date_joined
    FROM 
        users_customuser
),
-- Calculate transaction metrics per customer
transaction_stats AS (
    SELECT 
        owner_id,
        COUNT(*) AS transaction_count,
        AVG(amount) AS avg_transaction_amount
    FROM 
        savings_savingsaccount
    WHERE 
        -- Filter for successful transactions only (adjust condition as needed)
        transaction_status = 'success'
    GROUP BY 
        owner_id
),
-- Combine customer data with transaction metrics
customer_activity AS (
    SELECT 
        cd.id AS customer_id,
        cd.customer_name AS name,
        cd.date_joined,
        COALESCE(ts.transaction_count, 0) AS total_transactions,
        COALESCE(ts.avg_transaction_amount, 0) AS avg_transaction_amount,
        TIMESTAMPDIFF(MONTH, cd.date_joined, CURRENT_DATE()) AS tenure_months
    FROM 
        customer_data cd
    LEFT JOIN 
        transaction_stats ts ON cd.id = ts.owner_id
)
-- Final calculation with CLV
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        CASE 
            WHEN tenure_months = 0 THEN 0  -- Handle division by zero for new customers
            ELSE (total_transactions / tenure_months) * 12 * (0.001 * avg_transaction_amount)
        END,
        2
    ) AS estimated_clv
FROM 
    customer_activity
WHERE 
    tenure_months > 0  -- Exclude customers who joined this month
ORDER BY 
    estimated_clv DESC;