-- 1. 


    -- actual time=0.010..0.125 (before index)
    EXPLAIN ANALYZE SELECT * from Employees 
    WHERE employee_type_id = 1;

    CREATE INDEX employee_type 
    ON employees (
        employee_type_id ASC
    );

    -- actual time=0.051..0.084 (after index)
    EXPLAIN ANALYZE SELECT * from Employees 
    WHERE employee_type_id = 1;


-- 2. 


    -- actual time=1.262..1.319 (before index)
    EXPLAIN ANALYZE SELECT * from Sales 
    WHERE dealership_id = 500;

    CREATE INDEX dealership_id 
    ON sales (
        dealership_id ASC
    );

    -- actual time=0.215..0.236 (after index)
    EXPLAIN ANALYZE SELECT * from Sales 
    WHERE dealership_id = 500;


-- 3. 


    -- actual time=0.367..2.613 (before index)
    EXPLAIN ANALYZE SELECT * from customers 
    WHERE state = 'CA';

    CREATE INDEX customer_state
    ON customers (
        state ASC
    );

    -- actual time=0.056..0.085 (after index)
    EXPLAIN ANALYZE SELECT * from customers 
    WHERE state = 'CA';

-- 4. 

    -- actual time=0.015..0.302
    EXPLAIN ANALYZE SELECT * from vehicles 
    where year_of_car BETWEEN 2018 AND 2020;

    CREATE INDEX vehicle_year
    ON vehicles (
        year_of_car DESC
    );

    -- actual time=0.010..0.268
    EXPLAIN ANALYZE SELECT * from vehicles 
    where year_of_car BETWEEN 2018 AND 2020;

-- 5. 

    -- actual time=0.009..0.248 (before index)
    EXPLAIN ANALYZE SELECT * from vehicles 
    where floor_price < 30000;

    CREATE INDEX floor_price_idx
    ON vehicles (
        floor_price ASC
    );

    -- actual time=0.010..0.260 (after index)
    EXPLAIN ANALYZE SELECT * from vehicles 
    where floor_price < 30000;