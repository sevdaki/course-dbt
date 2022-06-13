# Analytics engineering with dbt

## Week 1 Project

-- How many users do we have?
SELECT 
  COUNT(DISTINCT user_id) AS user_count
FROM users
;
-- 130 users


-- On average, how many orders do we receive per hour?
WITH orders_per_hour AS (
  SELECT 
  date_trunc('hour', created_at) as order_hour
  , COUNT(DISTINCT order_id) AS order_count
  FROM orders
  GROUP BY order_hour)
  
SELECT 
  SUM(order_count) / COUNT(DISTINCT order_hour) AS avg_order_count_per_hour
FROM orders_per_hour
;
-- 7.5 orders per hour


-- On average, how long does an order take from being placed to being delivered?
SELECT 
  avg(delivered_at - created_at) AS avg_order_to_delivery_hours
FROM orders
;
-- 3 days


-- How many users have only made one purchase? Two purchases? Three+ purchases?
WITH user_order_count AS (
  SELECT 
    user_id
    , COUNT(order_id) AS order_count
  FROM orders
  GROUP BY user_id)

SELECT 
  CASE 
    WHEN order_count > 2 THEN '3+'
    ELSE CAST(order_count AS VARCHAR) 
    END AS order_count
  , COUNT(user_id)
FROM user_order_count
GROUP BY 1
ORDER BY 1
;
-- 1: 25 users
-- 2: 28 users
-- 3+ 71 users


-- On average, how many unique sessions do we have per hour?
WITH sessions_per_hour AS (
  SELECT 
  date_trunc('hour', created_at) as session_hour
  , COUNT(DISTINCT session_id) AS session_count
  FROM events
  GROUP BY session_hour)
  
SELECT 
  SUM(session_count) / COUNT(DISTINCT session_hour) AS avg_session_count_per_hour
FROM sessions_per_hour
;
-- 16 sessions per hour on average

