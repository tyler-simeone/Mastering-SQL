-- Chapter 11

-- States With Most Customers

-- 1. What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?

select
	c.state state,
	count(s.sale_id) sale_count
from customers c
join sales s
on s.customer_id = c.customer_id
group by state
order by sale_count desc limit 5;

-- 2. What are the top 5 US zipcodes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?

select
	c.zipcode zipcode,
	count(s.sale_id) sale_count
from customers c
join sales s
on s.customer_id = c.customer_id
group by zipcode
order by sale_count desc limit 5;

-- 3. What are the top 5 dealerships with the most customers?

select 
	d.business_name dealership,
	count(s.customer_id) customer_count
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
join customers c
on s.customer_id = c.customer_id
group by dealership
order by customer_count desc limit 5;
