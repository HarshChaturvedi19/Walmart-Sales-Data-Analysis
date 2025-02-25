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

