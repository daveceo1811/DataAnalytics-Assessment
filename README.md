# DataAnalytics-Assessment

##Assessment_Q1.sql

APPROACH I ADOPTED WHILE WRITING THE QUERIES

-- Using CTE to count the number of savings accounts and sums total deposit per user (owner_id)
-- Using CTE to count the number of investment plans per user (owner_id)
-- Joins the two CTEs on owner_id
-- Then joins with the users_customuser table to get the user’s name
-- Orders results by number of savings accounts

CHALLENGES AND RECOMMENDATIONS

Performance Issues

If tables like savings_savingsaccount and plans_plan are large:

--Aggregating them can be costly

-- Consider adding indexes on owner_id

Potential for Duplicate Rows

--If a user appears in both CTEs, but the base tables have duplicate rows or unexpected joins, you may see more than one row per user. 

--Debug with DISTINCT or GROUP BY in final select if needed.

Case Sensitivity or Naming Issues

--Table or column names like First_name, Last_name, and owner_id are case-sensitive in some systems (e.g., PostgreSQL)

-- If the query fails, check for correct casing.


##Assessment_Q2.sql

-- CTE - TRANSACTION COUNTS -Counts the number of transactions per customer per transaction date and extract the year and month.

-- 1ST SELECT STATEMENT - computes monthly averages per customer

-- 2ND SELECT STATEMENT - Segments each customer

-- 3RD SELECT STATEMENT - Groups to count customers in each segment









