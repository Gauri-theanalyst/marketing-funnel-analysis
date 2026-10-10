-- Q1: Dataset scope (date range, events, unique users)

SELECT
  min(event_date) as first_date,
  max(event_date) as last_date,
  count(*) as total_users,
  count(Distinct user_pseudo_id) as distinct_users,
  Round(count(*)/count(distinct user_pseudo_id), 1) as events_per_user
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
-- Q2: Unique users by device

SELECT
  device.category,
  count(Distinct user_pseudo_id) as unique_users
   
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by device.category
order by unique_users desc

-- Q3: Which countries do our visitors come from?
SELECT
  geo.country AS country,
  COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY geo.country
ORDER BY unique_users DESC
LIMIT 10;
-- Q4: Purchases, total revenue and average order value (AOV)
SELECT count(*) as purchases,
sum(ecommerce.purchase_revenue) as total_revenue,
ROUND(SUM(ecommerce.purchase_revenue) / COUNT(*), 2) AS avg_order_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
