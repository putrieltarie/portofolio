USE myskill;

-- 1. Identify the top three customers with the highest total order amounts
select c.first_name, 
c.last_name,
sum(o.total_amount) total_order_amount
from Customers as c
join Orders o ON o.customer_id = c.customer_id
group by c.customer_id
order by total_order_amount desc
limit 3
;

-- 2. Average Order for Each Customers
select c.first_name, 
c.last_name,
avg(o.total_amount) average_order
from Customers as c
join Orders o ON o.customer_id = c.customer_id
group by c.customer_id
;

-- 3. Employees with > 4 resolved ticket support
select e.first_name,
e.last_name,
count(s.ticket_id)
FROM employees e
join supporttickets s on e.employee_id = s.employee_id
WHERE s.status = 'resolved'
group by e.employee_id
having count(s.ticket_id) > 4
;


-- 4. Find all products that have never been ordered!
SELECT p.product_name 
FROM products p
left join orderdetails od on od.product_id = p.product_id
WHERE od.order_detail_id is NULL
;

-- 5. Total Revenue From All Product
select sum(quantity*unit_price)
from orderdetails
;

-- 6. Find categories with an average price greater than $500!
with cte_avg_price as(
select category, avg(price) rerata
from products
group by category)
SELECT*FROM cte_avg_price WHERE rerata > 500
;
