-- Comparing SELECT run times on normalized data w/ joins
-- vs denormalized data in one table

-- Created new table for denormalized data for faster SELECT


-- Times (normalized tables w/ multiple joins)
-- Pl: 0.355
-- Ex: 2.343

EXPLAIN ANALYZE SELECT 
	v.msr_price, vbt.name bodytype, 
	vma.name make, vmo.name model 
FROM vehicles v
JOIN vehicletypes vt on v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclebodytypes vbt 
ON vt.body_type_id = vbt.vehicle_body_type_id
JOIN vehiclemakes vma
ON vt.make_id = vma.vehicle_make_id
JOIN vehiclemodels vmo
ON vt.model_id = vmo.vehicle_model_id
WHERE msr_price > 15000
ORDER BY msr_price;

CREATE TABLE denormvehicletypes AS SELECT vbt.name bodytype, vma.name make, vmo.name model 
FROM vehicletypes vt 
JOIN vehiclebodytypes vbt 
ON vt.body_type_id = vbt.vehicle_body_type_id
JOIN vehiclemakes vma
ON vt.make_id = vma.vehicle_make_id
JOIN vehiclemodels vmo
ON vt.model_id = vmo.vehicle_model_id;

ALTER TABLE denormvehicletypes ADD COLUMN vehicle_type_id SERIAL PRIMARY KEY;


ALTER TABLE vehicles
DROP CONSTRAINT vehicles_vehicle_type_id_fkey;

ALTER TABLE vehicles 
ADD CONSTRAINT vehicles_vehicle_type_id_fkey 
FOREIGN KEY (vehicle_type_id) 
REFERENCES denormvehicletypes (vehicle_type_id);

-- Times (denormalized tables no joins)

-- PT: 0.219 ms
-- ET: 1.9 ms

-- PT: 0.143 ms
-- ET: 1.127 ms


EXPLAIN ANALYZE SELECT v.msr_price,  dvt.*
FROM vehicles v
JOIN denormvehicletypes dvt
ON v.vehicle_type_id = dvt.vehicle_type_id
WHERE v.msr_price > 15000
ORDER BY msr_price;



-- TYLER'S SQL QUERIES!


CREATE OR REPLACE FUNCTION fix_pickup_date()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	
	UPDATE sales
	SET pickup_date = purchase_date + integer '7'
	WHERE sales.pickup_date <= sales.purchase_date;
	
	UPDATE sales
	SET pickup_date = pickup_date + integer '4'
	WHERE sales.pickup_date < sales.purchase_date + integer '7';
	
	RETURN null;
	
END;
$$

CREATE TRIGGER update_pickup_date
	AFTER INSERT OR UPDATE
	ON sales
	FOR EACH ROW
	EXECUTE PROCEDURE fix_pickup_date();




-- Create stored proc to sell a vehicle (common use case)

CREATE OR REPLACE PROCEDURE sell_vehicle(saleTypeId int, vehicleId int, employeeId int, 
										 customerId int, dealershipId int, price numeric, deposit int, 
										 purchaseDate date, pickupDate date, invoiceNum varchar(50), 
										 paymentMethod varchar(50))
LANGUAGE plpgsql
AS $$
BEGIN

	-- Making sure vehicle hasn't been sold, and if so, making sure vehicle has been returned
	IF NOT EXISTS (SELECT * FROM sales WHERE vehicle_id = vehicleId AND returned = false) THEN
	  
		INSERT INTO sales (sales_type_id, vehicle_id, employee_id, customer_id, 
						   dealership_id, price, deposit, purchase_date, pickup_date,
						   invoice_number, payment_method)
		VALUES (saleTypeId, vehicleId, employeeId, customerId, dealershipId,
				price, deposit, purchaseDate, pickupDate, invoiceNum, paymentMethod);
				
	END IF;
				
END;
$$

SELECT * FROM sales 
ORDER BY sale_id DESC;

CALL sell_vehicle(1, 255, 25, 126, 100, 79999.49, 10000, '2020-09-23', '2020-09-30', '213V7W9854', 'mastercard');
CALL sell_vehicle(1, 50, 25, 125, 100, 31976.59, 10000, '2020-09-23', '2020-09-30', '423V7X9784', 'visa');


