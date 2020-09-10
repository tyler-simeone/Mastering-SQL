-- Book 3

-- Chapter 5

-- Triggers Introduction

-- 1. 

create function set_pickup_date()
	returns trigger
	language plpgsql
as $$
begin
	
	update sales
	set pickup_date = current_date + integer '3'
	where sales.sale_id = new.sale_id;
	
	return null;
	
end;
$$

create trigger new_sale_made
	after insert
	on sales
	for each row
	execute procedure set_pickup_date();
	
insert into sales (sales_type_id, vehicle_id,
				   employee_id, customer_id,
  				   dealership_id, price, deposit,
				   purchase_date,
				   invoice_number, payment_method,
				   returned)
values (1, 255, 12, 555, 500, 80000, 12345, current_date, 123456789, 'mastercard', false);

-- Test

select * from sales
order by sale_id desc;

-- 2. 

-- WORK IN PROGRESS!

create function fix_pickup_date()
	returns trigger
	language plpgsql
as $$
begin
	
	update sales
	set pickup_date = purchase_date + integer '7'
	where sales.pickup_date <= sales.purchase_date;
	
	update sales
	set pickup_date = pickup_date + integer '4'
	where sales.pickup_date < sales.purchase_date + integer '7';
	
	return null;
	
end;
$$

create trigger update_pickup_date
	after update
	on sales
	for each statement
	execute procedure fix_pickup_date();
	


-- Test

update sales
set purchase_date = current_date
where sale_id = 1007;

select * from sales
order by sale_id desc;