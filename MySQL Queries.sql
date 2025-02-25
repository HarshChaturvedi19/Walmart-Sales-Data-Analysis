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
