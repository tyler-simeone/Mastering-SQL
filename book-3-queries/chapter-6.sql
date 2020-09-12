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


-- 2.

create or replace function default_phone_num()
	returns trigger
	language plpgsql
as $$
begin

	update dealerships
	set phone = '777-111-0305'
	where phone is null;
	
	return null;

end;
$$

create trigger add_phone
	after insert
	on dealerships
	for each row
	execute procedure default_phone_num();
	
-- Test

insert into dealerships(business_name)
values('New dealership 3!');

select * from dealerships
order by dealership_id desc;


-- 3.
select * from dealerships;

select count(*) from dealerships
where tax_id not like '%-%-%-%--%';

create or replace function update_tax_id()
	returns trigger
	language plpgsql
as $$
begin

	update dealerships
	set tax_id = concat(tax_id, '--', lower(state))
	where tax_id not like '%-%-%-%--%';
	
	return null;

end;
$$

create trigger tax_id
	before insert or update
	on dealerships
	for each row
	execute procedure update_tax_id();
	
insert into dealerships(business_name)
values('new Dealership');

update dealerships
set tax_id = concat(tax_id, '--', lower(state))
where tax_id not like '%-%-%-%--%'
and dealership_id = 1;

select * from dealerships
where tax_id not like '%-%-%-%--%'
and dealership_id = 1;
