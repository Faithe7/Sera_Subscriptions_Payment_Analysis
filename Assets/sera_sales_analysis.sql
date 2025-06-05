SELECT *
FROM sera.sales
LIMIT 10;


-- Number of transactions
SELECT 
COUNT(*) AS total_rows, 
COUNT(transaction_id)  AS total_transactions,
COUNT(DISTINCT transaction_id) AS distinct_transaction_id
FROM sera.sales;

-- Therefore, no of rows = no of transactions = no of distinct transaction_id


--QUESTIONS

-- Total Number of transactions
SELECT COUNT(transaction_id)
FROM sera.sales;



-- Total period covered in the analysis
--- Start date and End date.

SELECT 
    MIN(datetime) AS start_date,
    MAX(datetime) AS end_date
FROM sera.sales;

	--Analysis Duration
	SELECT AGE(MAX(datetime), MIN(datetime)) AS period_covered
	FROM sera.sales;

	

-- Number of transactions by status and percentage of total for each status.

SELECT COUNT(*) AS total_transactions,

    COUNT(*) FILTER (WHERE status = 'success') AS total_sucess,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'success') / COUNT(*), 2) AS successful_perc,

	COUNT(*) FILTER (WHERE status = 'failed') AS total_failed,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'failed') / COUNT(*), 2) AS failed_perc,

    COUNT(*) FILTER (WHERE status = 'abandoned') AS total_abandoned,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'abandoned') / COUNT(*), 2) AS abandoned_perc

FROM sera.sales;



-- Monthly subscription revenue in NGN (with exchange rate NGN/USD at 950) split by channel.   

SELECT 
    TO_CHAR(DATE_TRUNC('month', datetime), 'Mon-YYYY') AS month, COUNT(transaction_id), channel,
    CEIL(SUM(amount * 950)) AS revenue_ngn
FROM sera.sales
WHERE status='success'  
GROUP BY DATE_TRUNC('month', datetime),channel
ORDER BY DATE_TRUNC('month', datetime),channel;

-- August 2023 had the highest revenue



-- Total transactions by channel split by the transaction status. 

SELECT channel, COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'success') AS total_sucess,
	COUNT(*) FILTER (WHERE status = 'failed') AS total_failed,
    COUNT(*) FILTER (WHERE status = 'abandoned') AS total_abandoned
FROM sera.sales
GROUP BY channel
ORDER BY total_transactions DESC;

-- Card had the highest rate of success and also the highest rate of failure.



-- Total suscribers; A subscriber is a user with a successful payment.

SELECT COUNT(DISTINCT user_id) FILTER (WHERE status = 'success') AS total_suscribers
FROM sera.sales



-- List of users showing their number of active months, total successful, abandoned, and failed transactions. 

WITH user_activity AS (
    SELECT user_id, DATE_TRUNC('month', datetime) AS active_month
    FROM sera.sales
    GROUP BY user_id, DATE_TRUNC('month', datetime)
),
user_status_count AS (
    SELECT user_id,
        COUNT(*) FILTER (WHERE status = 'success') AS total_successful,
        COUNT(*) FILTER (WHERE status = 'abandoned') AS total_abandoned,
        COUNT(*) FILTER (WHERE status = 'failed') AS total_failed
    FROM sera.sales
    GROUP BY user_id
)
SELECT ua.user_id,
    COUNT(ua.active_month) AS active_months,
    usc.total_successful,
    usc.total_abandoned,
    usc.total_failed
FROM user_activity ua
JOIN user_status_count usc ON ua.user_id = usc.user_id
GROUP BY ua.user_id, usc.total_successful, usc.total_abandoned, usc.total_failed
ORDER BY active_months DESC;



-- Users with more than 1 active month without a successful transaction.

SELECT am.user_id,
    COUNT(DISTINCT DATE_TRUNC('month', am.datetime)) AS active_months,
    COUNT(CASE WHEN am.status = 'success' THEN 1 END) AS total_successful
FROM sera.sales am
GROUP BY am.user_id
HAVING
    COUNT(DISTINCT DATE_TRUNC('month', am.datetime)) > 1
    AND COUNT(CASE WHEN am.status = 'success' THEN 1 END) = 0
ORDER BY active_months DESC;

