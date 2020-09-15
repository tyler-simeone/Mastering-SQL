-- Book 3 Chapter 8

-- Vehicle Transactions

-- 1. 

BEGIN;

SELECT 
	vbt.name body_type, vma.name make,
	vmo.name model
FROM vehicletypes vt
JOIN vehiclebodytypes vbt
ON vt.body_type_id = vbt.vehicle_body_type_id
JOIN vehiclemakes vma
ON vt.make_id = vma.vehicle_make_id
JOIN vehiclemodels vmo
ON vt.model_id = vmo.vehicle_model_id;

SAVEPOINT savepoint_1;

INSERT INTO vehiclemakes (name)
VALUES ('Honda');

SELECT * FROM vehiclemakes;

INSERT INTO vehiclemodels (name)
VALUES ('CR-V');

SELECT * FROM vehiclemodels 
ORDER BY vehicle_model_id DESC;

INSERT INTO vehiclebodytypes (name)
VALUES ('CUV');

SELECT * FROM vehiclebodytypes;

SAVEPOINT savepoint_2;

INSERT INTO vehicletypes (body_type_id, make_id, model_id)
VALUES (5, 6, 17);

SELECT * FROM vehicletypes
ORDER BY vehicle_type_id DESC;

SAVEPOINT savepoint_3;

INSERT INTO vehicles (vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold)
VALUES 
('WEE555444321YEaa89', 'I4', 31, 'Lilac', 'Beige', 21755, 18999, 0, 2021, false),
('TEE5354224321Ywa80', 'I4', 31, 'Dark Red', 'Beige', 21755, 18999, 0, 2021, false),
('ZEE455444321RAaz84', 'I4', 31, 'Lime', 'Beige', 21755, 18999, 12, 2021, false),
('FRE5547773221uwa76', 'I4', 31, 'Navy', 'Beige', 21755, 18999, 24, 2021, false),
('LE785544821N1A7789', 'I4', 31, 'Sand', 'Beige', 21755, 18999, 3, 2021, false);

SAVEPOINT savepoint_4;

SELECT * FROM vehicles 
ORDER BY vehicle_id DESC;

COMMIT;

-- 2. 

BEGIN;

SELECT * FROM vehiclemodels;

SELECT * FROM vehicletypes
WHERE model_id = 5 
OR model_id = 6;

SELECT * FROM vehicles
WHERE vehicle_type_id = 3
OR vehicle_type_id = 6
OR vehicle_type_id = 9
AND is_sold = false;

UPDATE vehicles
SET year_of_car = 2021,
    interior_color = 'Red and Black'
WHERE vehicle_type_id = 3
OR vehicle_type_id = 6
OR vehicle_type_id = 9
AND is_sold = false;

SAVEPOINT new_mazdas;

SELECT * FROM vehiclemakes;

SELECT * FROM vehicletypes
WHERE make_id = 2;

SELECT * FROM vehicles
WHERE vehicle_type_id = 23
AND is_sold = false;

UPDATE vehicles
SET year_of_car = 2020
WHERE vehicle_type_id = 23
AND is_sold = false;

SAVEPOINT remaining_mazdas;

COMMIT;
