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
