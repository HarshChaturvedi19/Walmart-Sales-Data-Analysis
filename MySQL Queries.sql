select * from walmart;


select count(*) walmart;

select  payment_method, count(*) from walmart
group by payment_method

 -- total branch and city 
SELECT branch, city ,COUNT(branch) AS branch_count
FROM walmart
GROUP BY branch, city;

-- maximum quantity
SELECT category, MAX(quantity) AS max_quantity

-- Business Problems 
--  Q1: Find different payment methods, number of transactions, and quantity sold by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;



-- Project Question #2: Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating
WITH ranked AS (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk
    FROM walmart
    GROUP BY branch, category
)
SELECT r.branch, r.category, r.avg_rating
FROM ranked r
WHERE r.rnk = 1;




-- Q3: Identify the busiest day for each branch based on the number of transactions
SELECT branch, formatted_date, day_of_week, transaction_count
FROM (
    SELECT 
        branch,
        STR_TO_DATE(date, '%d/%m/%Y') AS formatted_date,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_of_week,
        COUNT(*) AS transaction_count,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
    FROM walmart
    GROUP BY branch, formatted_date, day_of_week
) AS ranked
WHERE rnk = 1;


-- Q4: Calculate the total quantity of items sold per payment method
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Q5: Determine the average, minimum, and maximum rating of categories for each city
SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;


-- Q6: Calculate the total profit for each category
SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;



-- Q7: Determine the most common payment method for each branch
WITH ranked_payments AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT 
    branch, 
    payment_method AS preferred_payment_method, 
    total_trans
FROM ranked_payments
WHERE rnk = 1
ORDER BY branch;



-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts
SELECT
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_invoices
FROM walmart
GROUP BY branch, shift
ORDER BY branch, num_invoices DESC;
