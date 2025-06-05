# Sera Subscriptions Payment Analysis and Visualization

## Introduction
This dashboard provides a data-driven overview of subscription payments for Sera, a global SaaS company offering financial insights for investment decisions. By leveraging SQL for data transformation and Power BI for visualization, it uncovers key patterns in revenue generation, transaction outcomes, subscriber trends, and payment channel performance across 2022 and 2023. The goal is to identify what’s working, where revenue is being lost, and how payment processes can be optimized to improve user experience and financial performance.

## Objectives
- **Transform and Model Data:** Restructure raw subscription payment data into a clean, analysis-ready format to support efficient querying and reporting.
- **Analyze Sales and Retention Trends:** Explore revenue, transaction patterns, and subscriber behavior to understand sales performance and customer retention over time.
- **Build Insightful Dashboards:** Develop interactive visualizations using SQL and Power BI to uncover actionable insights and support strategic business decisions.

## Tools
- SQL (PostgreSQL)
- Power BI

## Technique and Skills
- Data Transformation and Analysis with SQL
- Data Transformation with Power Query
- Data Modelling
- DAX
- Slicers for interactive filtering
- Bookmark
- Report Automation
- Data Visualization

## Datasource
<a href = "https://resagratia.com/"> Resagratia </a> 

## Data Transformation with SQL
As part of preparing the data for analysis and dashboarding, several transformations were performed using SQL to ensure consistency, accuracy, and usability of the subscription payment data. Below is a summary of the key transformation steps:

- **Transaction Date Standardization:**
The transaction date column, originally stored as a text string with ordinal suffixes and a 12-hour timestamp, was cleaned and converted into a proper timestamp format. This enables accurate time-based analysis such as monthly trends.

- **Card Type Consolidation:**
Card types were normalized by grouping variants like “Mastercard debit” and “Mastercard credit” under a single category (e.g., “Mastercard”). This consolidation simplifies analysis of payment processor performance and customer preferences.

- **Credit vs. Debit Classification:**
A new column, credit_or_debit, was created to classify whether a transaction was made with a credit or debit card. This allows for deeper insight into user payment behavior.

- **Creation of Analytical View:**
All cleaned and transformed columns were combined into a reusable SQL view. This view acts as a virtual table, allowing for efficient querying and dashboard integration.

<a href = "https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_sales_date_time_transformation.sql"> Date time Transformation with SQL </a>

<a href = "https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_sales_data_transformation.sql"> Data Transformation with SQL </a>

## Data Analysis with SQL
Exploratory data analysis was conducted in SQL to uncover key patterns and performance metrics. The following actions were carried out:

- Counted the total number of transactions and determined the analysis period based on available data.
- Calculated the distribution of transaction statuses (successful, failed, abandoned) and their percentage shares.
- Aggregated subscription revenue by month and payment channel, adjusted for currency (NGN and USD).
- Assessed transaction outcomes (success, failure, abandoned) across different payment channels to determine which methods yielded the best and worst results.
- Counted unique users with at least one successful transaction to define the active subscriber base.

<a href = "https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_sales_analysis.sql"> Data Analysis with SQL </a>

## Data Model
The data transformed in Power Query. Date columns were created for each datasets using the datetime column. Then, date table was created. Finally, relationships were created between the tables in the dataset. Additional were also created. 

![Data Model](https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_payment_subscriptions_dashboard_data_model.png)

## Dashboard Insights

![Sera Payment Subscriptions Dashboard](https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_payment_subscriptions_dashboard.PNG)

### Key Metrics 
- **Total Revenue:** ₦5,243,896 - Generated form successful transactions.
- **Subscribers:** 264 - Number of users who successfully subscribed (successful transactions).
- **Total Transactions:** 1,465 - Includes successful, failed and abandoned transactions.
- **Current Month Revenue:** ₦393,842 (⬇ from previous month)

### Key Insights
#### Declining Activity in Current Month
- Revenue dropped significantly from ₦843,762 to ₦393,842.
- Subscribers fell by over 50% from previous month.
- Transactions also declined by over 60%, indicating potential churn or seasonal variation.

#### Transaction Breakdown
- Abandoned Transactions (1,054) represent 72% of all transactions with unknown card type.
- Only 315 (22%) of transactions were successful.
- Failed Transactions were 96 (7%), predominantly with debit cards (66%).
- Debit cards had the highest success rate (52%).

#### Bank Performance
- Guaranty Trust Bank (GTBank) and Access Bank processed the highest number of successful transactions.
- GTBank shows the highest total transactions but also a high number of abandoned ones.
- Banks like UBA and First Bank also performed well with lower abandonment rates.

#### Monthly Trends
- Revenue peaked mid-year and dipped towards the year's end, showing possible seasonal effects.
- Transaction volume followed a similar trend, suggesting a correlation between user engagement and revenue.

#### Geographical Insights
- Majority of users are from NG (Nigeria), with some from US, CA, and UK.
- Nigeria also sees the highest number of transactions and revenue, aligning with card usage trends in NGN.

#### Currency and Card Type Analysis
- NGN dominates successful transactions (245), followed by USD (19).
- MasterCard debit cards are the most used and most successful, while credit cards have the highest failure rate.
- Many card types were not recorded and were therefore categorized as “other”.
- Abandoned transactions is largely concentrated on bank transfer payments.

## Recommendations

- **Investigate High Abandonment Rate:**
Over 70% of transactions are abandoned. Investigate user journey and payment gateway friction, especially with cards.

- **Improve Credit Card Reliability:**
High failure rates suggest integration or compliance issues with credit card providers.

- **Re-Engage Dropping Subscribers:**
Target re-engagement campaigns for churned users and offer incentives during low-activity months.

- **Focus on Performing Banks:**
Strengthen partnerships with high-performing banks like GTBank, Access Bank, and UBA for better reliability and trust.

- **Expand Global Support:**
With inflow of international transactions, optimizing the platform for multi-currency transactions and support for more card types could boost conversions.

## Download
<a href = "https://github.com/Faithe7/Sera_Subscriptions_Payment_Analysis/blob/main/Assets/sera_payment_subscriptions_dashboard.pbix"> Download the Power BI file </a>
