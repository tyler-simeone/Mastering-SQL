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