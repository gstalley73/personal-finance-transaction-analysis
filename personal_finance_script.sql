-- Spending VS Income by Bracket
SELECT 
	income_bracket,
	category,
	ROUND(AVG(amount), 2) AS avg_transaction,
	ROUND(SUM(amount), 2) AS total_spent,
	COUNT(*) AS total_transactions,
	ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
	ROUND(SUM(amount) / AVG(monthly_income) * 100, 2) AS pct_of_income
FROM transactions t 
GROUP BY income_bracket, category
ORDER BY income_bracket, pct_of_income DESC;


-- Query 2, Month Over Month Category Volatility
SELECT
	category,
	ROUND(MAX(monthly_spend), 2) AS peak_month_spend,
	ROUND(MIN(monthly_spend), 2) AS lowest_month_spend,
	ROUND(MAX(monthly_spend) - MIN(monthly_spend), 2) AS volatility_score,
	ROUND(AVG(monthly_spend), 2) AS avg_monthly_spend
FROM (
	SELECT 
		category,
		STRFTIME('%Y-%m', date) AS month,
		SUM(amount) AS monthly_spend
	FROM transactions
	WHERE category !=''
	GROUP BY category, month
)
GROUP BY category 
ORDER BY volatility_score DESC;

-- Query 3 Forgotten Subscriptions
SELECT
	user_id,
	merchant,
	COUNT(*) AS charge_count,
	ROUND(AVG(amount), 2) AS avg_charge,
	ROUND(SUM(amount), 2) AS total_spent,
	MIN(STRFTIME('%Y-%m', date)) AS first_seen,
	MAX(STRFTIME('%Y-%m', date)) AS last_seen
FROM transactions
WHERE category = 'Subscriptions'
GROUP BY user_id, merchant 
HAVING COUNT(*) >= 2
ORDER BY total_spent DESC;

--Impulse spending by Day of the Week
SELECT
	CASE CAST (STRFTIME('%w', date) AS INTEGER)
		WHEN 0 THEN 'Sunday'
		WHEN 1 THEN 'Monday'
		WHEN 2 THEN 'Tuesday'
		WHEN 3 THEN 'Wednesday'
		WHEN 4 THEN 'Thursday'
		WHEN 5 THEN 'Friday'
		WHEN 6 THEN 'Saturday'
	END AS day_of_week,
	category,
	COUNT(*) AS total_transactions,
	ROUND(AVG(amount), 2) AS avg_transaction,
	ROUND(SUM(amount), 2) AS total_spend
FROM transactions
WHERE category IN ('Dining', 'Shopping')
GROUP BY day_of_week, category
ORDER BY total_spend DESC;

--Top 10 Merchants by Total Spend
SELECT
	merchant,
	category,
	COUNT(*) AS total_transactions,
	ROUND(AVG(amount), 2) AS avg_transaction,
	ROUND(SUM(amount), 2) AS total_spend,
	ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM transactions), 2) AS pct_of_total_spend
FROM transactions
WHERE merchant != ''
GROUP BY merchant, category
ORDER BY total_spend DESC
LIMIT 10;