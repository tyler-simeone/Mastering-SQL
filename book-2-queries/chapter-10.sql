-- Chapter 10

-- Employee Reports

-- 1. How many emloyees are there for each role?

select
	et.name employee_type,
	count(e.employee_id) employee_count
from employeetypes et
join employees e
on e.employee_type_id = et.employee_type_id
group by employee_type;

-- 2. How many finance managers work at each dealership?

select 
	d.business_name dealership,
	count(et.name) finance_manager_count
from dealerships d
join dealershipemployees de
on de.dealership_id = d.dealership_id
join employees e
on e.employee_id = de.employee_id
join employeetypes et
on et.employee_type_id = e.employee_type_id
where et.name ilike 'finance%'
group by dealership
order by finance_manager_count desc;

-- 3. Get the names of the top 3 employees who work shifts at the most dealerships?

select
	e.first_name || ' ' || e.last_name employee,
	count(de.dealership_id) dealership_count
from employees e
join dealershipemployees de
on de.employee_id = e.employee_id
group by employee
order by dealership_count desc limit 3;

-- 4. Get a report on the top two employees who has made the most sales through leasing vehicles.

select 
	e.first_name || ' ' || e.last_name employee,
	count(s.sale_id) sale_count
from employees e
join sales s
on s.employee_id = e.employee_id
where s.sales_type_id = 2
group by employee
order by sale_count desc limit 2;
