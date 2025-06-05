-- SELECT *
-- FROM sera.sales_txn

--STRING MANIPULATION - DATE
---transform the column by separating it into its date and time components for easier analysis
----using TO_DATE() Approach (used if only the date was needed)

SELECT transaction_date, 
TO_DATE(TRIM(SUBSTRING(transaction_date,1,14)),'Mon DDth, YYYY') AS date
FROM sera.sales_txn
LIMIT 10;

----using TO_TIMESTAMP() to extract DateTime

SELECT transaction_date, 
TO_TIMESTAMP(transaction_date, 'Mon DDth, YYYY HH:MI:SS AM') AS datetime
FROM sera.sales_txn
ORDER BY datetime DESC
LIMIT 10;

----Alternative: use of regular expressions (REGEX) with the SUBSTRING() function to extract date and time components.

-- SELECT
-- SUBSTRING(transaction_date FROM '\w{3} \d{1,2}\w{2}, \d{4}') AS extracted_date
-- FROM sera.sales_txn
-- LIMIT 10;

