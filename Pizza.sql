

desc orders;
desc order_details;
desc pizza_types;
desc pizzas;




# 1) Total Revenue


select round(sum(o.quantity*p.price)) as Total_Revenue from 
order_details o inner join pizzas p on 
o.pizza_id=p.pizza_id;

# 2) Average Order Value

SELECT 
    ROUND(SUM(o.quantity * p.price) / COUNT(DISTINCT o.order_id)) AS Average_Order_value
FROM
    order_details o
        INNER JOIN
    pizzas p ON o.pizza_id = p.pizza_id;

# 3) Total Pizza Sold
SELECT 
    SUM(quantity) AS Total_pizza_sold
FROM
    order_details;


# 4) Total Order
SELECT 
    COUNT(DISTINCT (order_id)) AS Total_Order
FROM
    Order_details;

#5) Average Pizza Order

SELECT 
    SUM(Quantity) / COUNT(DISTINCT (order_id)) AS Average_Pizza_Order
FROM
    order_details;



# 6) Daily Trends For Total Orders
SELECT 
    DAYNAME(date) AS 'DayOfWeek',
    COUNT(DISTINCT order_id) AS total_orders
FROM
    orders
GROUP BY DAYNAME(date)
ORDER BY total_orders DESC;


# 8) Hourly Trend for total orders
SELECT 
    HOUR(time) AS Hours, COUNT(DISTINCT order_id) AS Counts
FROM
    orders
GROUP BY HOUR(time)
ORDER BY hours;


# 9) Percentage of Sales by Pizza Category

SELECT 
    pi.category,COUNT(*) AS order_count,
    ROUND(SUM(quantity * price), 2) AS revenue,
    ROUND((ROUND(SUM(o.quantity * p.price))) / (SELECT 
                    ROUND(SUM(o.quantity * p.price)) AS Total_Revenue
                FROM
                    order_details o
                        INNER JOIN
                    pizzas p ON o.pizza_id = p.pizza_id) * 100,
            2) AS shares
FROM
    pizzas p
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY pi.category;

# 10) Percentage of Sales by Pizza Size

SELECT 
    p.size,COUNT(*) AS order_count,
    ROUND(SUM(quantity * price), 2) AS revenue,
    ROUND((ROUND(SUM(o.quantity * p.price))) / (SELECT 
                    ROUND(SUM(o.quantity * p.price)) AS Total_Revenue
                FROM
                    order_details o
                        INNER JOIN
                    pizzas p ON o.pizza_id = p.pizza_id) * 100,
            2) AS shares
FROM
    pizzas p
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY p.size;


# 11) Total Pizzas Sold by Pizza Category

SELECT
 category
 ,SUM(quantity) AS quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY category;



# 12) Top 5 Best Sellers by Total Pizzas Sold

SELECT  name
  ,SUM(quantity) AS total_quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY total_quantity_sold DESC limit 5;



# 13) Bottom 5 Best Sellers by Total Pizzas Sold
SELECT  name
  ,SUM(quantity) AS total_quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY total_quantity_sold asc limit 5;

# 14) Frequency of Orders by Date
SELECT
    date,
    COUNT(DISTINCT order_id) AS order_count
FROM
    orders
GROUP BY
    date
ORDER BY
    order_count DESC;
    
    
# 15) Frequency of Orders by Month 

SELECT
    Month(date),
    COUNT(DISTINCT order_id) AS order_count
FROM
    orders
GROUP BY
    Month(date)
ORDER BY
    order_count DESC;
    
# 16) Average Price per Pizza Size
SELECT
    size,
    round(avg(price),2) AS average_price,
    price
FROM
    pizzas
GROUP BY
    size;
    
    

    


