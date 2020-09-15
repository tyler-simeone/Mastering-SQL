-- Book 3 Chapter 7

-- Transactions

-- 1.

BEGIN;

SELECT * FROM employeetypes;

INSERT INTO employeetypes(name)
VALUES('Automotive Mechanic');

SELECT * FROM employees
ORDER BY employee_id DESC;

INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
VALUES('Octavius', 'Dukeseratricks', 'tavio@gmail.com', '615-555-4321', 9),
('Sir', 'Dunkachud', 'seabum@gmail.com', '615-555-1234', 9),
('Hingle', 'McCringleberry', 'excessivecelebration@gmail.com', '615-555-9999', 9),
('Darth', 'Vador', 'iamyourfather@gmail.com', '615-555-4444', 9),
('Luke', 'Skywalker', 'senderrbud@gmail.com', '615-555-2222', 9);

SELECT * FROM dealerships 
WHERE business_name LIKE 'Sollowaye%'
OR business_name LIKE 'Hrishchenko%'
OR business_name LIKE 'Cadreman%';

INSERT INTO dealershipemployees(dealership_id, employee_id)
VALUES
(50,1001),
(128,1001),
(322,1001),
(50,1002),
(128,1002),
(322,1002),
(50,1003),
(128,1003),
(322,1003),
(50,1004),
(128,1004),
(322,1004),
(50,1005),
(128,1005),
(322,1005);

SELECT * FROM dealershipemployees 
ORDER BY dealership_employee_id DESC;

COMMIT;


-- 2.

BEGIN;

SELECT * FROM dealerships
ORDER BY dealership_id DESC;

SAVEPOINT savepoint_1;

INSERT INTO dealerships (business_name, city, state)
VALUES ('Felphun Automotive', 'Washington, D.C.', 'Virginia');

SAVEPOINT savepoint_2;

SELECT * FROM dealershipemployees
order by dealership_employee_id DESC;

SELECT * FROM employeetypes;

SELECT * FROM employees
WHERE employee_type_id = 3
OR employee_type_id = 6
OR employee_type_id = 4;

INSERT INTO dealershipemployees (employee_id, dealership_id)
VALUES 
(1,1007),
(3,1007),
(5,1007);

SAVEPOINT savepoint_3;

SELECT * FROM dealerships
WHERE business_name LIKE 'Scrogges%';

SELECT * FROM dealerships
WHERE business_name LIKE 'Felphun%';

SELECT * FROM dealershipemployees
WHERE dealership_id = 1009;

UPDATE dealershipemployees
SET dealership_id = 1009
WHERE dealership_id = 129;

SAVEPOINT savepoint_4;

COMMIT;