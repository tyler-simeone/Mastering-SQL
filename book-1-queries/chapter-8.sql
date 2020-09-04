-- Chapter 8

-- Purchase Income by Dealership

-- 1. 

select 
	d.business_name dealership,
	sum(s.price) purchase_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 1
group by dealership;

-- 2.

select 
	d.business_name dealership,
	sum(s.price) purchase_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 1
and date_part('month', s.purchase_date) = date_part('month', current_date)
group by dealership;

-- 3.

select 
	d.business_name dealership,
	sum(s.price) purchase_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 1
and date_part('year', s.purchase_date) = date_part('year', current_date)
group by dealership;


-- Lease Income by Dealership

-- 1.

select 
	d.business_name dealership,
	sum(s.price) lease_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 2
group by dealership;

-- 2.

select 
	d.business_name dealership,
	sum(s.price) lease_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 2
and date_part('month', s.purchase_date) = date_part('month', current_date)
group by dealership;

-- 3.

select 
	d.business_name dealership,
	sum(s.price) lease_revenue
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
where s.sales_type_id = 2
and date_part('year', s.purchase_date) = date_part('year', current_date)
group by dealership;

-- Total Income by Employee

-- 1.

select 
	e.first_name || ' ' || e.last_name employee,
	sum(s.price) sales_revenue
from employees e
join sales s
on s.employee_id = e.employee_id
group by employee;


