# personal-finance-transaction-analysis
### Tools: Excel, SQL, Tableau
Author: Gabriel Stalley
## Project Overview
This projects simulates the role of a data analyst working for a fictional personal finance platform similar to Mint or YNAB. Given raw export of 1,800 user transactions, the goal was to clean the data, uncover inefficiencies in user spending behavior, and build an interactive dashboard that a product team could sue to make evidence-based feature decisions.

## Business Questions Answered
- Are lower income users overspending in the same categories as higher income users?
- Which spending categories are the most volatile month over month?
- Which subscription services are users most likely paying for without realizing?
- When during the week do users make the most impulse purchases?
- Which merchants are capturing the largest share of total user spend?

## Dataset
- Source: Synthetic dataset generated to simulate a real personal finance platform export
- Size: 1,800 transactions across 50 users, spanning January-December 2023
- Fields: transaction_id, user_id, income_bracket, monthly_income, date, merchant, category, amount, transaction_type

### Phase 1: Data Cleaning (Excel)
The raw dataset contained 8 categories of issues that required cleaning before analysis. All changes were documented in a cleaning_change_log tab within the workbook.

### Phase 2: SQL Analysis 
Five queries were written to answer each core business question
Query 1 — Spending vs Income by Bracket
Calculates total spend, average transaction size, and spend as a percentage of monthly income per category and income bracket. Identifies whether spending behavior differs meaningfully across Low, Mid, and High income users.
Query 2 — Month over Month Category Volatility
Uses a subquery to calculate monthly spend per category, then surfaces each category's peak month, lowest month, and volatility score (the difference between the two). Identifies which categories carry the most budgeting risk.
Query 3 — Forgotten Subscriptions
Filters for subscription category transactions, groups by user and merchant, and surfaces any combination appearing 3 or more times. Ranks by total spent to identify which services are quietly accumulating the most charges.
Query 4 — Impulse Spending by Day of Week
Uses SQLite's STRFTIME and a CASE statement to convert numeric weekday values into readable day names. Filters for Dining and Shopping only and compares total spend and transaction count by day.
Query 5 — Top 10 Merchants by Total Spend
Ranks merchants by total spend and calculates each merchant's percentage share of all spending across the entire dataset using a subquery scalar.

### Phase 3: Tableau Dashboard
The dashboard contains five interactive views assembled into a single layout. An income bracket filter connects across sheets allowing viewers to drill into specific user segments.

### Key Findings
1. Shopping dominates regardless of income
Shopping is the highest spend category across Low, Mid, and High income brackets. This suggests spending behavior is driven by habit rather than income level, making it a strong candidate for in-app budgeting nudges targeting all user segments equally.

2. Shopping carries the highest budgeting risk with Healthcare coming in a close second
Shopping showed the largest month-over-month volatility score of all categories.  Users don't usually don't budget for shopping or healthcare which, can lead to issues, a spend alert could be instituted to help with the budgeting.

3.Thursday is peak impulse spending day
Shopping and Dining spend both peak on Thursdays — not weekends as conventional wisdom might suggest. A Thursday afternoon push notification reminding users of their weekly budget could directly reduce impulse spend.

4. Hulu is the top forgotten subscription
Hulu users showed the highest combination of charge frequency and average charge amount across all subscription merchants. A subscription audit feature surfacing recurring charges ranked by total annual cost would add direct user value.

5. Target, Best Buy, and Walmart capture the most spend
These three retailers alone account for a disproportionate share of total platform spending. Partnership or cashback integrations with these merchants would have the highest visibility and user impact of any merchant-level feature.


## Skills Demonstrated
Excel: Data cleaning, formula construction (SUBSTITUTE, VALUE, DATEVALUE, TRIM, PROPER, nested IF), change log documentation, paste special workflows

SQL: Aggregations, GROUP BY, HAVING, subqueries, CASE statements, STRFTIME date functions, window-style ranking with ORDER BY

Tableau: Multi-source dashboard, calculated fields, reference lines, filter actions across sheets, bubble charts, line charts, bar charts

