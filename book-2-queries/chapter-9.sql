-- Chapter 9

-- Available Models

-- 1.

select
	vmo.name model,
	count(v.vehicle_type_id) vehicle_supply_count
from vehiclemodels vmo
join vehicletypes vt 
on vt.model_id = vmo.vehicle_model_id
join vehicles v
on v.vehicle_type_id = vt.vehicle_type_id
group by model
order by vehicle_supply_count asc limit 1;

-- 2.

select
	vmo.name model,
	count(v.vehicle_type_id) vehicle_supply_count
from vehiclemodels vmo
join vehicletypes vt 
on vt.model_id = vmo.vehicle_model_id
join vehicles v
on v.vehicle_type_id = vt.vehicle_type_id
group by model
order by vehicle_supply_count desc limit 1;

-- Diverse Dealerships

-- 1. Lowest-selling dealerships

select
	d.business_name dealership,
	count(s.vehicle_id) sale_count
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
group by dealership
order by sale_count asc;
	
-- 2. Highest-selling dealerships

select
	d.business_name dealership,
	count(s.vehicle_id) sale_count
from dealerships d
join sales s
on s.dealership_id = d.dealership_id
group by dealership
order by sale_count desc;
	


