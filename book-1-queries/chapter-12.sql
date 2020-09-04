-- Chapter 12 (Views)

-- Practice: Carnival

-- 1. Create a view that lists all vehicle body types, makes and models.

CREATE VIEW vehicle_info AS
	select 
		vma.name make,
		vmo.name model,
		vbt.name body_type
	from vehicletypes vt
	join vehiclebodytypes vbt
	on vt.body_type_id = vbt.vehicle_body_type_id
	join vehiclemakes vma
	on vt.make_id = vma.vehicle_make_id
	join vehiclemodels vmo
	on vt.model_id = vmo.vehicle_model_id
	order by make;
	
select * from vehicle_info;

-- 2. Create a view that shows the total number of employees for each employee type.

CREATE VIEW employee_types AS
	select 
		et.name employee_type,
		count(e.employee_id) employee_count
	from employeetypes et
	join employees e
	on e.employee_type_id = et.employee_type_id
	group by employee_type;

select * from employee_types;

-- 3. Create a view that lists all customers without exposing their emails, phone numbers and street address.

CREATE VIEW customer_info AS
	select 
		c.first_name || ' ' || c.last_name customer,
		c.city, c.state, c.zipcode,
		c.company_name
	from customers c;

select * from customer_info;

-- 4. Create a view named sales2018 that shows the total number of sales for each sales type for the year 2018.

CREATE VIEW sales2018 AS
	select
		st.name sale_type,
		count(s.sale_id) sale_count
	from salestypes st
	join sales s
	on s.sales_type_id = st.sales_type_id
	where date_part('year', s.purchase_date) = 2018
	group by sale_type;

select * from sales2018;

-- 5. Create a view that shows the employee with the most number of sales at each dealership.

select 
	d.business_name dealership,
	e.first_name || ' ' || e.last_name employee,
	count(s.sale_id) sale_count
from employees e
join sales s 
on s.employee_id = e.employee_id
join dealerships d
on d.dealership_id = s.dealership_id
group by dealership, employee
order by sale_count desc;

