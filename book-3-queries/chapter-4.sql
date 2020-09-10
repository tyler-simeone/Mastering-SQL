-- Book 3

-- Chapter 4

-- Stored Procedures Practice

-- Selling a Vehicle

alter table vehicles
add column is_sold boolean
default false;

create procedure sell_vehicle(vehicle int)
language plpgsql
as $$
begin

	update vehicles 
	set is_sold = true
	where vehicle_id = vehicle;
		
end
$$;

call sell_vehicle(6);

-- Tests
	
select * from vehicles
order by vehicle_id asc;


-- Returning a Vehicle

alter table sales
add column returned boolean
default false;

create procedure return_vehicle(vehicle int)
language plpgsql
as $$
begin

	update vehicles
	set is_sold = false
	where vehicle_id = vehicle;
	
	update sales
	set returned = true
	where vehicle_id = vehicle;
	
	create table if not exists oilchangelog (
		oil_change_id int generated always as identity,
		vehicle_id int not null,
		oil_change_date date not null default current_date,
		primary key(oil_change_id),
		constraint vehicle_id_fkey
			foreign key(vehicle_id)
				references vehicles(vehicle_id)
	);
	
	insert into oilchangelog (vehicle_id)
	values(vehicle);

end
$$;

call return_vehicle(9);

-- Tests

select * from sales
order by vehicle_id asc;

select * from vehicles
order by vehicle_id asc;