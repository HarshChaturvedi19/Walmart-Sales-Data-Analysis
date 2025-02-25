
# **Walmart Sales Analysis**

## **Project Overview**
This project focuses on analyzing Walmart sales data using SQL queries. The goal is to extract meaningful insights about transactions, customer behavior, sales trends, and business performance. The dataset contains details on **branches, payment methods, categories, sales, quantity, ratings, and profits**.

## **Dataset**
The dataset, `walmart`, includes the following columns:
- `branch` - Store branch location
- `city` - City where the store is located
- `category` - Product category
- `payment_method` - Type of payment used
- `quantity` - Number of items sold
- `rating` - Customer rating for the purchase
- `date` - Transaction date
- `time` - Transaction time
- `unit_price` - Price per unit
- `profit_margin` - Profit percentage

---

## **Business Questions & SQL Queries**

### **1️⃣ General Data Exploration**
```sql
SELECT * FROM walmart;
```
Retrieve all records from the dataset.

```sql
SELECT COUNT(*) AS total_records FROM walmart;
```
Count the total number of transactions in the dataset.

```sql
SELECT payment_method, COUNT(*) FROM walmart
GROUP BY payment_method;
```
Find the number of transactions per payment method.

---

### **2️⃣ Store & Branch Analysis**
```sql
SELECT branch, city, COUNT(branch) AS branch_count
FROM walmart
GROUP BY branch, city;
```
Identify the total number of branches in each city.

---

### **3️⃣ Product & Sales Insights**
```sql
SELECT category, MAX(quantity) AS max_quantity
FROM walmart;
```
Find the maximum quantity sold for each product category.

```sql
SELECT
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;
```
Determine the number of transactions and total quantity sold by payment method.

---

### **4️⃣ Customer Rating Insights**
```sql
WITH ranked AS (
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk
    FROM walmart
    GROUP BY branch, category
)
SELECT branch, category, avg_rating
FROM ranked
WHERE rnk = 1;
```
Identify the highest-rated product category in each branch.

```sql
SELECT
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;
```
Find the average, minimum, and maximum rating for each category in each city.

---

### **5️⃣ Sales Performance Analysis**
```sql
SELECT
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;
```
Calculate the total profit for each category and rank them in descending order.

---

### **6️⃣ Store Operations & Traffic Analysis**
```sql
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
```
Find the busiest day for each branch based on the number of transactions.

```sql
WITH ranked_payments AS (
    SELECT
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method, total_trans
FROM ranked_payments
WHERE rnk = 1
ORDER BY branch;
```
Determine the most common payment method for each branch.

```sql
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
```
Categorize sales transactions into **Morning, Afternoon, and Evening shifts**.

---

## **Key Insights & Findings**
This section will include your analysis findings:

- **Sales Insights:** Key categories, branches with the highest sales, and preferred payment methods.
- **Profitability:** Insights into the most profitable product categories and locations.
- **Customer Behavior:** Trends in ratings, payment preferences, and peak shopping hours.

---

## **Next Steps**
- **Customer Segmentation:** Identify purchase patterns across different customer types.
- **Predictive Analytics:** Forecast sales trends using machine learning models.
- **Inventory Optimization:** Align stock levels with sales demand to prevent shortages.

---

## **License**
This project is licensed under the **MIT License**. Feel free to use and modify it for learning purposes.

---

## **🚀 Ready to Explore?**
Run these queries in **MySQL Workbench** and analyze Walmart's sales trends! 😊

