CREATE DATABASE AssetManagementDigital; 
USE AssetManagementDigital;

-- Create employees table
CREATE TABLE employees (
    employee_id INT IDENTITY(1, 1) PRIMARY KEY,
    [name] VARCHAR(50) NOT NULL,
    department VARCHAR(30) NOT NULL,
    email VARCHAR(255),
    pwd VARCHAR(30)
);

-- Create assets table
CREATE TABLE assets (
    asset_id INT IDENTITY(1, 1) PRIMARY KEY,
    [name] VARCHAR(100) NOT NULL,
    [type] VARCHAR(20) NOT NULL,
    serial_num VARCHAR(10) UNIQUE NOT NULL,
    purchase_date DATE,
    [location] VARCHAR(100),
    [status] VARCHAR(100) NOT NULL CHECK ([status] IN ('in use', 'decommissioned', 'under maintenance', 'available')),
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES employees(employee_id)
);

-- Create maintenance table
CREATE TABLE maintenance (
    maintenance_id INT IDENTITY(1, 1) PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES assets(asset_id),
    maintenance_date DATE,
    [description] VARCHAR(MAX),
    cost DECIMAL(8, 2) NOT NULL
);

-- Create asset_allocations table
CREATE TABLE asset_allocations (
    allocation_id INT IDENTITY(1, 1) PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES assets(asset_id),
    employee_id INT FOREIGN KEY REFERENCES employees(employee_id),
    allocation_date DATE DEFAULT GETDATE(),
    return_date DATE
);

-- Create reservations table
CREATE TABLE reservations (
    reservation_id INT IDENTITY(1, 1) PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES assets(asset_id),
    employee_id INT FOREIGN KEY REFERENCES employees(employee_id),
    reservation_date DATE NOT NULL,
    [start_date] DATE NOT NULL,
    [end_date] DATE NOT NULL,
    [status] VARCHAR(50) CHECK ([status] IN ('pending', 'approved', 'canceled')) DEFAULT 'pending'
);

-- Insert data into employees
INSERT INTO employees ([name], department, email, pwd)
VALUES
    ('Avinash Verma', 'Marketing', 'avinash.verma@company.in', 'password123'),
    ('Bhavna Gupta', 'Engineering', 'bhavna.gupta@company.in', 'secret!'),
    ('Chandrika Singh', 'Human Resources', 'chandrika.singh@company.in', NULL),
    ('Dinesh Patel', 'IT', 'dinesh.patel@company.in', 'secure_access'),
    ('Eesha Sharma', 'Sales', 'eesha.sharma@company.in', NULL);

-- Insert data into assets
INSERT INTO assets ([name], [type], serial_num, purchase_date, [location], [status], owner_id)
VALUES
    ('Server 1', 'IT Equipment', 'SRV12345', '2023-01-15', 'Data Center', 'in use', 1),
    ('Desktop Computer', 'IT Equipment', 'DESK6789', '2022-11-10', 'Main Office', 'in use', 2),
    ('Laser Printer', 'Office Equipment', 'PRN90876', '2021-06-05', 'Branch Office', 'decommissioned', 3),
    ('Company Vehicle', 'Transportation', 'CAR54678', '2020-09-20', 'Main Office', 'under maintenance', 4),
    ('Conference Table', 'Furniture', 'TBL546790', '2024-09-15', 'Meeting Room', 'in use', 5);

-- Insert data into maintenance
INSERT INTO maintenance (asset_id, maintenance_date, [description], cost)
VALUES
    (1, '2024-10-01', 'Preventive maintenance performed', 500.00),
    (2, '2023-12-20', 'Software update installed', 200.00),
    (3, '2024-02-15', 'Printer cartridge replaced', 100.00),
    (4, '2022-12-05', 'Engine oil and filter changed', 300.00),
    (5, '2024-09-25', 'Tire rotation and alignment', 150.00);

-- Insert data into asset_allocations
INSERT INTO asset_allocations (asset_id, employee_id, allocation_date, return_date)
VALUES
    (1, 1, '2023-02-01', '2024-10-15'),
    (2, 2, '2022-12-01', NULL),
    (3, 3, '2021-07-01', '2024-01-01'),
    (4, 4, '2020-10-01', '2023-01-01'),
    (5, 4, '2023-01-15', '2024-09-14');

-- Insert data into reservations
INSERT INTO reservations (asset_id, employee_id, reservation_date, [start_date], [end_date], status)
VALUES
    (1, 5, '2024-10-01', '2024-11-05', '2025-02-27', 'approved'),
    (2, 4, '2024-09-01', '2024-10-06', '2025-01-31', 'canceled'),
    (3, 1, '2024-08-01', '2024-09-16', '2024-12-03', 'pending'),
    (4, 3, '2024-10-01', '2024-11-30', '2024-12-12', 'pending'),
    (5, 2, '2024-11-01', '2024-11-15', '2025-03-28', 'canceled');

ALTER TABLE maintenance
DROP CONSTRAINT FK__maintenan__asset__3E52440B;  -- Replace this with the actual constraint name if different

ALTER TABLE maintenance
ADD CONSTRAINT FK_Maintenance_Asset
FOREIGN KEY (asset_id)
REFERENCES Assets(asset_id)
ON DELETE CASCADE;



ALTER TABLE asset_allocations
DROP CONSTRAINT FK__asset_all__asset__412EB0B6;

ALTER TABLE asset_allocations
ADD CONSTRAINT FK__asset_all__asset__412EB0B6
FOREIGN KEY (asset_id) REFERENCES assets(asset_id) ON DELETE CASCADE;





ALTER TABLE reservations
DROP CONSTRAINT FK__reservati__asset__45F365D3;

ALTER TABLE reservations
ADD CONSTRAINT FK__reservati__asset__45F365D3
FOREIGN KEY (asset_id) REFERENCES assets(asset_id) ON DELETE CASCADE;



	select* from employees
	select* from assets
	select* from maintenance
	select* from asset_allocations
	select* from reservations