USE restaurant_db;

-- Menu Analysis:

-- 1. View the menu_items table.
Select * from menu_items;

-- 2. Find the number of items on the menu.
Select count(*) from menu_items;

-- 3. What are the least and most expensive items on the menu?
Select * from menu_items
order by price;
Select * from menu_items
order by price DESC;

-- 4. How many italian dishes are on the menu?
Select count(*) As Number_of_italian_dishes from menu_items
Where category = 'Italian';

-- 5. What are the least and most expensive italian dishes on the menu?
Select * from menu_items
Where category = 'Italian'
Order by price;

-- 6.  How many dishes are in each category?
Select category, count(menu_item_id) as Number_of_dishes_by_category from menu_items
group by category;

-- 7. What is the average dish price within each category?
Select category, avg(price) as avg_price from menu_items
group by category
order by avg_price;

-- -------------------------------------------------------------------------------
-- Order Analysis:

-- 1. View the order_details table.
Select * from order_details;

-- 2. What is the date range of the table?
select min(order_date), max(order_date) from order_details;


-- 3. How many orders where made within this date range?
Select count(DISTINCT order_id) from order_details;
Select count( order_id) from order_details;


-- 4. How many items where ordered within this date range?
Select count(order_id) from order_details;


-- 5. Wich orders had the most number of items?
Select order_id, count(item_id) as num_items from order_details
group by order_id
Order by num_items DESC;


-- 6. How many orders had more than 12 items?
Select order_id, count(item_id) as num_items from order_details
group by order_id
Having num_items>12;

-- Count how many rows in the question above.
Select count(*) from 
(Select order_id, count(item_id) as num_items from order_details
group by order_id
Having num_items>12) As num_orders;

-- -------------------------------------------------------------------------------
-- Combined Menu & Order Analysis:

-- 1. Combine the meun_items and the order_details tables into a single table.alter
Select * from menu_items;
Select * from order_details;

Select * from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id;
    

-- 2. What were the least and most ordered items? What categories were they in?
Select item_name, category, count(order_details_id) as num_purchases 
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
Group by item_name, category
Order by num_purchases;


-- 3. What were the top 5 orders that spent the most money?
Select order_id, sum(price) as total_spend from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
Group by order_id
order by total_spend desc
limit 5;


-- 4. View the details of the most spend order.
Select category, count(item_id) as num_items 
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
    where order_id = 440
    Group by category;

-- 5. View the details of the top 5 highest spend orders.
Select order_id, category, count(item_id) as num_items 
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
    where order_id IN (440,2075,1975,330,2675)
    Group by order_id, category;