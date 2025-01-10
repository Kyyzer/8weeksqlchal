-- 0. Investigating the null values
-- customer_orders
SELECT *
FROM pizza_runner.customer_orders;
-- what we can see is there are two instances of null values, a null value and also a string that says 'null'
-- one way of resolving the null value is to impute the same value from a nearby row or the most common occurrence from the data
-- in this case, we will replace the strings with NULL so that it does not affect the aggregation in our queries
-- we will also replace the other empty strings with NULL

-- runner_orders
SELECT *
FROM pizza_runner.runner_orders;
-- we can see a similar mix of null values and 'null' strings
-- it will be easy to replace the nulls under the cancellation column with an empty string
-- but rows 6 and 9 should retain the null values as to represent 'no data'

-- permanently replacing the null values
UPDATE pizza_runner.customer_orders
SET exclusions = NULL
WHERE exclusions = 'null' OR exclusions = ''

UPDATE pizza_runner.customer_orders
SET extras = NULL
WHERE extras = 'null' OR extras = ''

UPDATE pizza_runner.runner_orders
SET cancellation = ''
WHERE cancellation IS NULL or cancellation = 'null'

UPDATE pizza_runner.runner_orders
SET
	pickup_time = NULL,
	distance = NULL,
	duration = NULL
WHERE order_id = 6;

UPDATE pizza_runner.runner_orders
SET
	pickup_time = NULL,
	distance = NULL,
	duration = NULL
WHERE order_id = 9;

-- A1. How many pizzas were ordered?
SELECT
	COUNT(order_id)
FROM pizza_runner.customer_orders;

-- A2. How many unique customer orders were made?
SELECT
	COUNT(DISTINCT(order_id))
FROM pizza_runner.customer_orders;

-- A3. How many successful orders were delivered by each runner?
SELECT
	runner_id,
	COUNT(order_id)
FROM pizza_runner.runner_orders
WHERE cancellation = ''
GROUP BY runner_id;

-- A4. How many of each type of pizza was delivered?
SELECT
	pizza_name,
	customer_orders.pizza_id,
	COUNT(customer_orders.pizza_id)
FROM pizza_runner.customer_orders
JOIN pizza_runner.runner_orders
ON customer_orders.order_id = runner_orders.order_id
JOIN pizza_runner.pizza_names
ON customer_orders.pizza_id = pizza_names.pizza_id
WHERE cancellation = ''
GROUP BY pizza_name, customer_orders.pizza_id;

-- A5. How many vegetarian and meatlovers were ordered by each customer?
SELECT
	customer_orders.customer_id,
	pizza_names.pizza_name,
	customer_orders.pizza_id,
	COUNT(customer_orders.pizza_id)
FROM pizza_runner.customer_orders
JOIN pizza_runner.pizza_names
ON pizza_names.pizza_id = customer_orders.pizza_id
GROUP BY customer_orders.customer_id, pizza_names.pizza_name, customer_orders.pizza_id
ORDER BY customer_orders.customer_id;

-- A6. What was the maximum number of pizzas delivered in a single order?
SELECT
	customer_orders.order_id,
	COUNT(pizza_id) AS number
FROM pizza_runner.customer_orders
JOIN pizza_runner.runner_orders
ON customer_orders.order_id = runner_orders.order_id
WHERE cancellation = ''
GROUP BY customer_orders.order_id
ORDER BY number DESC;

-- A7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT
	customer_orders.customer_id,
	SUM(
		CASE
			WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1
			ELSE 0
		END
	) AS "At Least 1 Change",
	SUM(
		CASE
			WHEN exclusions IS NULL AND extras IS NULL THEN 1
			ELSE 0
		END
	) AS "No Changes"
FROM pizza_runner.customer_orders
JOIN pizza_runner.runner_orders
ON customer_orders.order_id = runner_orders.order_id
WHERE cancellation = ''
GROUP BY customer_id;

-- A8. How many pizzas were delivered that had both exclusions and extras?
SELECT
	COUNT(customer_orders.order_id)
FROM pizza_runner.customer_orders
JOIN pizza_runner.runner_orders
ON customer_orders.order_id = runner_orders.order_id
WHERE cancellation = '' AND exclusions IS NULL AND extras IS NULL;

-- A9. What was the total volume of pizzas ordered for each hour of the day?
SELECT
	TO_CHAR(customer_orders.order_time, 'HH24') AS hour,
	COUNT(customer_orders.order_id)
FROM pizza_runner.customer_orders
GROUP BY hour;

-- A10. What was the volume of orders for each day of the week?
SELECT
	TO_CHAR(customer_orders.order_time, 'Day') AS day,
	COUNT(customer_orders.order_id)
FROM pizza_runner.customer_orders
GROUP BY day;