-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
	customer_id, 
    SUM(price)
FROM dannys_diner.sales
JOIN dannys_diner.menu
ON sales.product_id = menu.product_id
GROUP BY customer_id
ORDER BY customer_id;
	
-- 2. How many days has each customer visited the restaurant?
SELECT 
	customer_id, 
	COUNT(DISTINCT order_date)
FROM dannys_diner.sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
WITH first_purchase AS (
  SELECT
  	customer_id,
  	MIN(order_date) AS first_order_date
  FROM dannys_diner.sales
  GROUP BY customer_id
)  
SELECT 
	first_purchase.customer_id, 
    first_order_date,
    product_name
FROM first_purchase
JOIN dannys_diner.sales
ON sales.customer_id = first_purchase.customer_id AND sales.order_date = first_purchase.first_order_date
JOIN dannys_diner.menu
ON sales.product_id = menu.product_id
ORDER BY first_purchase.customer_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
WITH most_purchased AS (
  SELECT
  	product_id,
  	COUNT(product_id) AS times_purchased
  FROM dannys_diner.sales
  GROUP BY product_id
  ORDER BY product_id
)
SELECT
	most_purchased.product_id,
    product_name,
    times_purchased
FROM most_purchased
JOIN dannys_diner.menu
ON menu.product_id = most_purchased.product_id;

-- 5. Which item was the most popular for each customer?
SELECT 
	customer_id,
    sales.product_id,
    menu.product_name,
    COUNT(sales.product_id) AS times_purchased
FROM dannys_diner.sales
JOIN dannys_diner.menu
ON menu.product_id = sales.product_id
GROUP BY customer_id, sales.product_id, menu.product_name
ORDER BY customer_id, sales.product_id;

-- 6. Which item was purchased first by the customer after they became a member?
WITH first_purchase AS (
  SELECT
  	sales.customer_id,
	MIN(order_date)
  FROM dannys_diner.sales
  JOIN dannys_diner.members
  ON members.customer_id = sales.customer_id
  WHERE members.join_date <= sales.order_date
  GROUP BY sales.customer_id
)
SELECT
	f.customer_id,
	min,
	m.product_name
FROM first_purchase f
JOIN dannys_diner.sales s
ON f.min = s.order_date AND f.customer_id = s.customer_id
JOIN dannys_diner.menu m
ON m.product_id = s.product_id;

-- 7. Which item was purchased just before the customer became a member?
WITH first_purchase AS (
  SELECT
  	sales.customer_id,
	MAX(order_date)
  FROM dannys_diner.sales
  JOIN dannys_diner.members
  ON members.customer_id = sales.customer_id
  WHERE members.join_date > sales.order_date
  GROUP BY sales.customer_id
)
SELECT
	f.customer_id,
	max,
	m.product_name
FROM first_purchase f
JOIN dannys_diner.sales s
ON f.max = s.order_date AND f.customer_id = s.customer_id
JOIN dannys_diner.menu m
ON m.product_id = s.product_id;

-- 8. What is the total items and amount spent for each member before they became a member?
WITH first_purchase AS (
  SELECT
  	sales.customer_id,
	COUNT(sales.order_date),
	SUM(menu.price)
  FROM dannys_diner.sales
  JOIN dannys_diner.members
  ON members.customer_id = sales.customer_id
  JOIN dannys_diner.menu
  ON menu.product_id = sales.product_id
  WHERE members.join_date > sales.order_date
  GROUP BY sales.customer_id
)
SELECT
	customer_id,
	count total_items,
	sum total_amount_spent
FROM first_purchase;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT
	sales.customer_id,
	SUM(
		CASE
			WHEN menu.product_name = 'sushi' THEN menu.price *2*10
			ELSE menu.price *10
		END
	) AS total_points
FROM dannys_diner.sales
JOIN dannys_diner.menu
ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - 
-- how many points do customer A and B have at the end of January?

SELECT
	sales.customer_id,
	SUM(
		CASE
			WHEN sales.order_date >= members.join_date THEN menu.price *2*10
			ELSE menu.price *10
		END
	) AS total_points
FROM dannys_diner.sales
JOIN dannys_diner.menu
ON sales.product_id = menu.product_id
JOIN dannys_diner.members
ON sales.customer_id = members.customer_id
GROUP BY sales.customer_id;

SELECT *
FROM dannys_diner.sales
JOIN dannys_diner.members
ON sales.customer_id = members.customer_id;