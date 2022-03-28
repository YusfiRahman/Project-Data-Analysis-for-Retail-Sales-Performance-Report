## A.Overall_Performance_by_Year
SELECT 
YEAR(order_date) AS years, 
SUM(sales) AS sales, 
COUNT(order_quantity) AS number_of_order 
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date);


## B.Overall_Performance_by_Product_Sub_category
SELECT
YEAR(order_date) AS years,
product_sub_category,
SUM(sales) AS sales
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
AND YEAR(order_date) BETWEEN 2011 AND 2012
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;


## C.Promotion_Effectiveness_and_Efficiency_by_Years
SELECT
YEAR(order_date) AS years,
SUM(sales) AS sales,
SUM(discount_value) AS promotion_value,
ROUND((SUM(discount_value)/SUM(sales))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years;


## D.Promotion_Effectiveness_and_Efficiency_by_Product_Sub_Category
SELECT
YEAR(order_date) AS years,
product_sub_category,
product_category,
SUM(sales) AS sales,
SUM(discount_value) AS promotion_value,
ROUND((SUM(discount_value)/SUM(sales))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
AND YEAR(order_date) = 2012
GROUP BY 
years,
product_sub_category,
product_category
ORDER BY sales DESC;


## E.Customers_Transactions_per_Year
SELECT
YEAR(order_date) AS years,
COUNT(DISTINCT customer) AS number_of_customer
FROM dqlab_sales_store
WHERE order_status = 'Order Finished ' AND YEAR(order_date) BETWEEN 2009 AND 2012
GROUP BY years
ORDER BY years ASC;