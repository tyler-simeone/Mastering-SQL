-- Book 3 Chapter 6

-- Carnival Dealerships

-- 1. 

create or replace function url_formatter()
	returns trigger
	language plpgsql
as $$
begin

	new.website = concat('http://www.carnivalcars.com/', replace(lower(new.business_name), ' ', '_'));

	return new;

end;
$$

create trigger update_website
	before insert or update
	on dealerships
	for each row execute procedure url_formatter();

-- Tests

insert into dealerships(business_name, phone, city, state, website, tax_id)
values ('New Dealership!', '615-211-2222', 'Nashville', 'Tennessee', 'www.testing123.com', 'tp-201-2010');

update dealerships
set website = 'www.testing123.com'
where dealership_id = 1000;

select * from dealerships 
order by dealership_id desc;
