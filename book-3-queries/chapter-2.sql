-- Book 3

-- Chapter 2

-- Practice: Employees

-- 1. 

delete from sales
where invoice_number = '7628231837'

-- 2.

ALTER table  sales
    DROP CONSTRAINT sales_employee_id_fkey,
    ADD CONSTRAINT sales_employee_id_fkey 
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

delete from employees 
where employee_id = 35;