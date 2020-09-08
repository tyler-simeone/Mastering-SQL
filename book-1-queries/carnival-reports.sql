-- Employee Reports

-- Best Sellers

-- 1. Who are the top 5 employees for generating sales income?
select 
	e.first_name || ' ' || e.last_name employee,
	sum(s.price) sales_income
from employees e
join sales s
on e.employee_id = s.employee_id
group by employee
order by sales_income desc limit 5;

-- 2. Who are the top 5 dealership for generating sales income?
select 
	d.business_name dealership,
	sum(s.price) sales_income
from dealerships d
join sales s
on d.dealership_id = s.dealership_id
group by dealership
order by sales_income desc limit 5;

-- 3. Which vehicle model generated the most sales income?
select 
	vmo.name vehicle_model,
	sum(s.price) sales_income
from vehiclemodels vmo
join vehicletypes vt
on vt.model_id = vmo.vehicle_model_id
join vehicles v
on v.vehicle_type_id = vt.vehicle_type_id
join sales s
on v.vehicle_id = s.vehicle_id
group by vehicle_model
order by sales_income desc limit 1;


-- Top Performance

-- 1. Which employees generate the most income per dealership?
select 
	d.business_name dealership,
	e.first_name || ' ' || e.last_name employee,
	sum(s.price) sales_income
from dealerships d
join dealershipemployees de
on d.dealership_id = de.dealership_id
join employees e
on e.employee_id = de.employee_id
join sales s 
on s.employee_id = e.employee_id
group by dealership, employee
order by sales_income desc;


-- Vehicle Reports

-- Inventory

-- 1. In our Vehicle inventory, show the count of each Model that is in stock.
select
	vmo.name model,
	count(v.vehicle_type_id) inventory
from vehiclemodels vmo
join vehicletypes vt
on vt.model_id = vmo.vehicle_model_id
join vehicles v 
on v.vehicle_type_id = vt.vehicle_type_id
group by model
order by model asc;

-- 2. In our Vehicle inventory, show the count of each Make that is in stock.
select
	vma.name make,
	count(v.vehicle_type_id) inventory
from vehiclemakes vma
join vehicletypes vt
on vt.make_id = vma.vehicle_make_id
join vehicles v 
on v.vehicle_type_id = vt.vehicle_type_id
group by make
order by make asc;

-- 3. In our Vehicle inventory, show the count of each BodyType that is in stock.
select
	vbt.name body_type,
	count(v.vehicle_type_id) inventory
from vehiclebodytypes vbt
join vehicletypes vt
on vt.body_type_id = vbt.vehicle_body_type_id
join vehicles v 
on v.vehicle_type_id = vt.vehicle_type_id
group by body_type
order by body_type asc;


-- Purchasing Power

-- 1. Which US state's customers have the highest average purchase price for a vehicle?
select 
	c.state,
	c.first_name || ' ' || c.last_name customer,
	round(avg(s.price), 2) average_purchase_price
from customers c
join sales s
on s.customer_id = c.customer_id
where s.sales_type_id = 1
group by c.state, customer
order by average_purchase_price desc;

-- 2. Now using the data determined above, which 5 states have the customers with the highest average purchase price for a vehicle?
select 
	c.state,
	c.first_name || ' ' || c.last_name customer,
	round(avg(s.price), 2) average_purchase_price
from customers c
join sales s
on s.customer_id = c.customer_id
where s.sales_type_id = 1
group by c.state, customer
order by average_purchase_price desc limit 5;