create database couriermanagement2

use couriermanagement2

-- User Table
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

-- Courier Table
CREATE TABLE Courier (
    CourierID INT PRIMARY KEY IDENTITY(1,1),
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE,
    EmployeeID INT, 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

ALTER TABLE Courier
ADD UserID INT;

ALTER TABLE Courier
ADD CONSTRAINT FK_UserID FOREIGN KEY (UserID) REFERENCES [User](UserID);

-- CourierServices Table
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Location Table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    LocationName VARCHAR(100),
    Address TEXT
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Orders Table (Many-to-Many between User and Courier, with additional attributes)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    CourierID INT,
    OrderDate DATE,
    DeliveryStatus VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
);

-- Insert sample data into User table
INSERT INTO [User] (Name, Email, Password, ContactNumber, Address)
VALUES 
('Alice Johnson', 'alice@example.com', 'password123', '1234567890', '123 Main St'),
('Bob Smith', 'bob@example.com', 'password456', '0987654321', '456 Elm St'),
('Charlie Brown', 'charlie@example.com', 'password789', '5551234567', '789 Oak St'),
('Dana White', 'dana@example.com', 'password321', '5559876543', '101 Pine St'),
('Eve Black', 'eve@example.com', 'password654', '5556789012', '202 Maple St');

-- Insert sample data into Employee table
INSERT INTO Employee (Name, Email, ContactNumber, Role, Salary)
VALUES 
('Charlie Green', 'charlie.green@example.com', '5555555555', 'Courier', 35000),
('Dana White', 'dana.white@example.com', '5555551234', 'Manager', 50000),
('Evan Brown', 'evan.brown@example.com', '5551239876', 'Courier', 30000),
('Frank Silver', 'frank.silver@example.com', '5554567890', 'Courier', 32000),
('Grace Blue', 'grace.blue@example.com', '5556543210', 'Dispatcher', 40000);

-- Insert sample data into Location table
INSERT INTO Location (LocationName, Address)
VALUES 
('Warehouse A', '789 Oak St'),
('Warehouse B', '101 Pine St'),
('Delivery Hub X', '303 Cedar St'),
('Distribution Center Y', '202 Maple St'),
('Sorting Facility Z', '404 Birch St');

-- Insert sample data into CourierServices table
INSERT INTO CourierServices (ServiceName, Cost)
VALUES 
('Standard Delivery', 10.00),
('Express Delivery', 20.00),
('Overnight Delivery', 50.00),
('International Delivery', 100.00),
('Economy Delivery', 5.00);

-- Insert sample data into Courier table
INSERT INTO Courier (SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate, EmployeeID)
VALUES 
('Alice Johnson', '123 Main St', 'Bob Smith', '456 Elm St', 2.5, 'Delivered', 'TRK12345', '2023-10-01', 1),
('Charlie Brown', '789 Oak St', 'Dana White', '101 Pine St', 1.2, 'In Transit', 'TRK54321', NULL, 2),
('Eve Black', '202 Maple St', 'Alice Johnson', '123 Main St', 3.5, 'Delivered', 'TRK78901', '2023-10-03', 3),
('Dana White', '101 Pine St', 'Charlie Green', '789 Oak St', 4.0, 'Dispatched', 'TRK67890', NULL, 4),
('Bob Smith', '456 Elm St', 'Eve Black', '202 Maple St', 0.8, 'In Transit', 'TRK34567', NULL, 5);

-- Insert sample data into Payment table
INSERT INTO Payment (CourierID, LocationID, Amount, PaymentDate)
VALUES 
(1, 1, 10.00, '2023-10-01'),
(2, 2, 20.00, '2023-10-02'),
(3, 3, 30.00, '2023-10-03'),
(4, 4, 40.00, '2023-10-04'),
(5, 5, 50.00, '2023-10-05');

-- Insert sample data into Orders table
INSERT INTO Orders (UserID, CourierID, OrderDate, DeliveryStatus)
VALUES 
(1, 1, '2023-10-01', 'Delivered'),
(2, 2, '2023-10-02', 'In Transit'),
(3, 3, '2023-10-03', 'Delivered'),
(4, 4, '2023-10-04', 'Not Dispatched'),
(5, 5, '2023-10-05', 'In Transit');

select * from Courier
select * from Orders
select * from [User]