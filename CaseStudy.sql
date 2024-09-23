CREATE DATABASE DigitalAssetManagement;
USE DigitalAssetManagement;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE Assets (
    asset_id INT PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    serial_number VARCHAR(255),
    purchase_date DATE,
    location VARCHAR(255),
    status VARCHAR(255),
    owner_id INT FOREIGN KEY REFERENCES Employees(employee_id)
);

CREATE TABLE MaintenanceRecords (
    maintenance_id INT PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES Assets(asset_id),
    maintenance_date DATE,
    description TEXT,
    cost DECIMAL(10, 2)
);

CREATE TABLE AssetAllocations (
    allocation_id INT PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES Assets(asset_id),
    employee_id INT FOREIGN KEY REFERENCES Employees(employee_id),
    allocation_date DATE,
    return_date DATE
);

CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY,
    asset_id INT FOREIGN KEY REFERENCES Assets(asset_id),
    employee_id INT FOREIGN KEY REFERENCES Employees(employee_id),
    reservation_date DATE,
    start_date DATE,
    end_date DATE,
    status VARCHAR(255)
);

INSERT INTO Employees (employee_id, name, department, email, password) VALUES
(1, 'Avinash Kumar', 'IT', 'avinashkumar@example.com', 'Password123'),
(2, 'Priya Patel', 'HR', 'priyapatel@example.com', 'Password456'),
(3, 'Rajesh Singh', 'Finance', 'rajeshsingh@example.com', 'Password789'),
(4, 'Meena Sharma', 'Marketing', 'meenasharma@example.com', 'Password012'),
(5, 'Vivek Gupta', 'Sales', 'vivekgupta@example.com', 'Password345');


INSERT INTO Assets (asset_id, name, type, serial_number, purchase_date, location, status, owner_id) VALUES
(1, 'Dell Laptop', 'Laptop', 'DL12345', '2023-01-01', 'Indore', 'In Use', 1),
(2, 'HP Printer', 'Printer', 'HP67890', '2023-02-15', 'Mumbai', 'In Use', 2),
(3, 'Canon Projector', 'Projector', 'CN76543', '2023-03-20', 'Delhi', 'In Use', 3),
(4, 'Lenovo Desktop', 'Desktop', 'LN45678', '2023-04-10', 'Bangalore', 'In Use', 4),
(5, 'Samsung Tablet', 'Tablet', 'SM98765', '2023-05-25', 'Chennai', 'In Use', 5);

INSERT INTO MaintenanceRecords (maintenance_id, asset_id, maintenance_date, description, cost) VALUES
(1, 1, '2023-06-10', 'Keyboard replacement', 1000.00),
(2, 2, '2023-08-05', 'Toner cartridge replacement', 500.00),
(3, 3, '2023-09-01', 'Lamp replacement', 750.00),
(4, 4, '2023-10-15', 'Hard drive upgrade', 2000.00),
(5, 5, '2023-11-20', 'Screen protector replacement', 250.00);

INSERT INTO AssetAllocations (allocation_id, asset_id, employee_id, allocation_date, return_date) VALUES
(1, 1, 1, '2023-04-01', '2023-05-31'),
(2, 2, 2, '2023-05-15', '2023-06-30'),
(3, 3, 3, '2023-07-01', '2023-08-15'),
(4, 4, 4, '2023-08-20', '2023-10-10'),
(5, 5, 5, '2023-09-05', '2023-11-05');

INSERT INTO Reservations (reservation_id, asset_id, employee_id, reservation_date, start_date, end_date, status) VALUES
(1, 3, 3, '2023-07-01', '2023-07-10', '2023-07-15', 'Approved'),
(2, 4, 4, '2023-08-25', '2023-09-01', '2023-09-07', 'Approved'),
(3, 5, 5, '2023-10-10', '2023-10-20', '2023-10-25', 'Approved'),
(4, 1, 1, '2023-11-05', '2023-11-15', '2023-11-20', 'Approved'),
(5, 2, 2, '2023-12-01', '2023-12-10', '2023-12-15', 'Approved');