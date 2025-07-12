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
