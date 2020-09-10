-- Book 3

-- Chapter 1

-- Practice: Employees

update dealershipemployees
set dealership_id = 20
where employee_id = 680
and dealership_id = 751;

-- Practice: Sales

update sales
set payment_method = 'mastercard'
where invoice_number = '2781047589';