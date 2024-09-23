Create database Couriers2

use Couriers2

-- Create User table
CREATE TABLE Users
(
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

-- Create Courier table
CREATE TABLE Courier (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE
);

-- Create CourierServices table
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Create Location table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);


INSERT INTO Users (UserID, Name, Email, Password, ContactNumber, Address)
VALUES 
  (1, 'Hritik', 'hrit@gmail.com', 'hr123', '9734567890', '123 hyd St'),
  (2, 'Ram', 'sh@gmail.com', 'shy456', '9876543210', '456 wrngl St'),
  (3, 'Sita', 'bob@gmail.com', 'bob789', '8912223333', '789 kdp Ave'),
  (4, 'Radhe', 'akh@gmail.com', 'akh456', '9545556066', '101 nz St'),
  (5, 'Pavan', 'pk@gmail.com', 'pk123', '7278849909', '202 ngkl St');



  INSERT INTO Courier(CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate)
VALUES 
  (1, 'nikhil', ' nizampet 42', 'araujo', '23 state st', 2.3, 'In Transit', 'TRK124056', '2023-12-10'),
  (2, 'akash', 'kukatpally 23', 'cubarsi', '28 city st', 8.2, 'Pending', 'TRK780132', NULL),
  (3, 'Johnson','lingampally 2','yamin', '101 Pine St', 3.5, 'Delivered', 'TRK344678', '2023-11-25'),
  (4, 'messi', 'bachupally 40', 'yamal', '202 kphb St', 6.3, 'In Transit', 'TRK911234', NULL),
  (5, 'pedri', 'ktr street 3', 'lamin', '123 huda St', 10.0, 'Pending', 'TRK567990', NULL);



  INSERT INTO CourierServices (ServiceID, ServiceName, Cost)
VALUES 
  (1, 'Standard Delivery', 10.50),
  (2, 'Express Delivery', 15.75),
  (3, 'Overnight Delivery', 20.00),
  (4, 'International Delivery', 25.50),
  (5, 'Same-Day Delivery', 30.00);



  INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary)
VALUES 
  (1, 'robert', 'ro@gmail.com', '9234567890', 'Manager', 60000.00),
  (2, 'Smith', 'sm@gmail.com', '9876543210', 'Delivery Staff', 40000.00),
  (3, 'kohli', 'kh@gmail.com', '8712223333', 'Customer Service', 45000.00),
  (4, 'sharma', 'sha@gmail.com', '9545556666', 'Dispatcher', 55000.00),
  (5, 'ronaldo', 'rona@gmail.com','6308889999', 'Warehouse Staff', 38000.00);



  INSERT INTO Location (LocationID, LocationName, Address)
VALUES 
  (1, 'Main Office', '123 Main St, CityA, CountryA'),
  (2, 'Branch Office 1', '456 Elm St, CityB, CountryB'),
  (3, 'Warehouse', '789 Oak Ave, CityC, CountryC'),
  (4, 'Branch Office 2', '101 Pine St, CityD, CountryD'),
  (5, 'Distribution Center', '202 Cedar St, CityE, CountryE');


  INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES 
  (1, 1, 2, 75.00, '2023-12-05'),
  (2, 3, 1, 120.50, '2023-12-08'),
  (3, 2, 4, 90.25, '2023-11-28'),
  (4, 4, 3, 110.00, '2023-12-01'),
  (5, 5, 5, 80.75, '2023-12-03');











--Assignment:
-- 1. List all customers:
SELECT * FROM Users;

-- 2. List all orders for a specific customer:
  select * from Courier  where SenderName = 'messi'

-- 3. List all couriers:
SELECT * FROM Courier;

-- 4. List all packages for a specific order:
SELECT * FROM Courier WHERE TrackingNumber = 'TRK567990'; 

-- 5. List all deliveries for a specific courier:
  SELECT * FROM Courier WHERE CourierID = 2;

-- 6. List all undelivered packages:
SELECT * FROM Courier WHERE Status <> 'UnDelivered';

-- 7. List all packages scheduled for delivery today:
  SELECT * FROM Courier WHERE DeliveryDate = '2023-12-10';

-- 8. List all packages with a specific status:
SELECT * FROM Courier WHERE Status = 'Delivered'; 

-- 9. Calculate the total number of packages for each courier.
SELECT CourierID, COUNT(*) AS TotalPackages FROM Courier GROUP BY CourierID;

-- 10. Find the average delivery time for each courier
SELECT CourierID, AVG(DATEDIFF(DD, DeliveryDate, OrderDate)) AS AvgDeliveryTime FROM Courier GROUP BY CourierID;

-- 11. List all packages with a specific weight range:
  SELECT * FROM Courier WHERE Weight BETWEEN '3.2' AND '7.4';

-- 12. Retrieve employees whose names contain 'John'
SELECT * FROM Employee WHERE Name LIKE '%robert%';

-- 13. Retrieve all courier records with payments greater than $50.
SELECT c.* FROM Courier c INNER JOIN Payment p ON c.CourierID = p.CourierID WHERE p.Amount > 50;

-- Comments for Task 3 queries
-- 14. Find the total number of couriers handled by each employee.
SELECT EmployeeID, Name, COUNT(CourierID) AS TotalCouriersHandled
FROM Employee
LEFT JOIN Courier ON Employee.EmployeeID = Courier.CourierID
GROUP BY Employee.EmployeeID, Employee.Name;

-- 15. Calculate the total revenue generated by each location
SELECT Location.LocationID, Location.LocationName, SUM(p.Amount) AS TotalRevenue
FROM Location
LEFT JOIN Payment p ON Location.LocationID = p.LocationID
GROUP BY Location.LocationID, Location.LocationName;

-- 16. Find the total number of couriers delivered to each location.
SELECT L.LocationID, L.LocationName, COUNT(c.CourierID) AS TotalCouriersDelivered
FROM Location L
LEFT JOIN Payment P ON L.LocationID = P.LocationID
LEFT JOIN Courier c ON P.CourierID = c.CourierID
WHERE c.Status = 'Delivered'
GROUP BY L.LocationID, L.LocationName;

-- 17. Find the courier with the highest average delivery time:
SELECT CourierID, AVG(DATEDIFF(DD, DeliveryDate, OrderDate)) AS AvgDeliveryTime
FROM Courier
GROUP BY CourierID
ORDER BY AvgDeliveryTime DESC
LIMIT 1;

--Pending 17 33 34 35

 
-- 18. Find Locations with Total Payments Less Than a Certain Amount
SELECT l.LocationID, l.LocationName, COALESCE(SUM(p.Amount), 0) AS TotalPayments
FROM Location l
LEFT JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName
HAVING COALESCE(SUM(p.Amount), 0) < 100;

-- 19. Calculate Total Payments per Location
SELECT Location.LocationID, Location.LocationName, COALESCE(SUM(Payment.Amount), 0) AS TotalPayments
FROM Location 
LEFT JOIN Payment  ON Location.LocationID = Payment.LocationID
GROUP BY Location.LocationID, Location.LocationName;

-- 20. Retrieve couriers who have received payments totaling more than $1000 in a specific location
SELECT  c.*
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
JOIN Location l ON p.LocationID = l.LocationID
WHERE p.Amount > 1000
  AND l.LocationID = 4;

-- 21. Retrieve couriers who have received payments totaling more than $1000 after a certain date
SELECT c.*
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > 1000 AND p.PaymentDate > '2023-10-08';  

-- 22. Retrieve locations where the total amount received is more than $5000 before a certain date
SELECT c.CourierID, c.SenderName 
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.PaymentDate < '2023-6-6' 
GROUP BY c.CourierID, c.SenderName 
HAVING SUM(p.Amount) > 5000;

-- 23. Retrieve Payments with Courier Information
SELECT * FROM Payment INNER JOIN Courier ON Payment.CourierID = Courier.CourierID;

-- 24. Retrieve Payments with Location Information
SELECT * FROM Payment INNER JOIN Location ON Payment.LocationID = Location.LocationID;

-- 25. Retrieve Payments with Courier and Location Information
SELECT * FROM Payment INNER JOIN Courier ON Payment.CourierID = Courier.CourierID INNER JOIN Location ON Payment.LocationID = Location.LocationID;

-- 26. List all payments with courier details
SELECT * FROM Payment INNER JOIN Courier ON Payment.CourierID = Courier.CourierID;

-- 27. Total payments received for each courier
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPaymentsReceived
FROM Courier c
LEFT JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID, c.SenderName;

-- 28. List payments made on a specific date

SELECT * FROM Payment
WHERE PaymentDate = '2010-10-10'; 

-- 29. Get Courier Information for Each Payment
SELECT PaymentID, PaymentDate, Amount, c.*
FROM Payment p
LEFT JOIN Courier c ON p.CourierID = c.CourierID;

-- 30. Get Payment Details with Location
SELECT p.*, l.*
FROM Payment p
LEFT JOIN Location l ON p.LocationID = l.LocationID;

-- 31. Calculating Total Payments for Each Courier
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayments
FROM Courier c
LEFT JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID, c.SenderName;

-- 32. List Payments Within a Date Range
SELECT * FROM Payment
WHERE PaymentDate BETWEEN '2018-1-10' AND '2023-12-6';

-- 33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side
SELECT *
FROM Users u
LEFT JOIN Courier c ON u.UserID = c.UserID

UNION

SELECT *
FROM Users u
RIGHT JOIN Courier c ON u.UserID = c.UserID
WHERE u.UserID IS NULL;

-- 34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side
SELECT *
FROM Courier c
LEFT JOIN CourierServices cs ON c.CourierID = cs.ServiceID

UNION

SELECT *
FROM Courier c
RIGHT JOIN CourierServices cs ON c.CourierID = cs.ServiceID
WHERE c.CourierID IS NULL;

-- 35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side
SELECT *
FROM Employee e
LEFT JOIN Payment p ON e.EmployeeID = p.EmployeeID

UNION

SELECT *
FROM Employee e
RIGHT JOIN Payment p ON e.EmployeeID = p.EmployeeID
WHERE e.EmployeeID IS NULL;

-- 36. List all users and all courier services, showing all possible combinations
SELECT u.*, cs.*
FROM Users u
CROSS JOIN CourierServices cs;

-- 37. List all employees and all locations, showing all possible combinations
SELECT e.*, l.*
FROM Employee e
CROSS JOIN Location l;

-- 38. Retrieve a list of couriers and their corresponding sender information (if available)
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.SenderName = u.Name;

-- 39. Retrieve a list of couriers and their corresponding receiver information (if available)
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.ReceiverName = u.Name;

-- 40. Retrieve a list of couriers along with the courier service details (if available)
SELECT c.*, cs.*
FROM Courier c
INNER JOIN CourierServices cs ON c.CourierID = cs.ServiceID;

-- 41. Retrieve a list of employees and the number of couriers assigned to each employee
SELECT e.EmployeeID, e.Name AS EmployeeName, COUNT(c.CourierID) AS AssignedCouriers
FROM Employee e
LEFT JOIN Courier c ON e.EmployeeID = c.CourierID
GROUP BY e.EmployeeID, e.Name;

-- 42. Retrieve a list of locations and the total payment amount received at each location
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalPaymentAmount
FROM Location l
LEFT JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName;

-- 43. Retrieve all couriers sent by the same sender (based on SenderName)
SELECT c1.*, c2.*
FROM Courier c1
JOIN Courier c2 ON c1.SenderName = c2.SenderName
WHERE c1.CourierID <> c2.CourierID;

-- 44. List all employees who share the same role
SELECT Role, Name AS EmployeesWithSameRole
FROM Employee
GROUP BY Role,Name
HAVING COUNT(*) > 1;

-- 45. Retrieve all payments made for couriers sent from the same location
SELECT p.*, c.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID
WHERE c.SenderAddress = '101 Pine St'; 

-- 46. Retrieve all couriers sent from the same location (based on SenderAddress)
SELECT c1.*, c2.*
FROM Courier c1
JOIN Courier c2 ON c1.SenderAddress = c2.SenderAddress
WHERE c1.CourierID <> c2.CourierID;

-- 47. List employees and the number of couriers they have delivered
SELECT e.EmployeeID, e.Name AS EmployeeName, COUNT(c.CourierID) AS DeliveredCouriers
FROM Employee e
LEFT JOIN Courier c ON e.EmployeeID = c.CourierID
WHERE c.Status = 'Delivered'
GROUP BY e.EmployeeID, e.Name;

-- 48. Find couriers that were paid an amount greater than the cost of their respective courier services
SELECT c.*, cs.*
FROM Courier c
JOIN CourierServices cs ON c.CourierID = cs.ServiceID
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > cs.Cost;
-- Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All

-- 49. Find couriers that have a weight greater than the average weight of all couriers
SELECT c.*
FROM Courier c
WHERE c.Weight > (SELECT AVG(Weight) FROM Courier);

-- 50. Find the names of all employees who have a salary greater than the average salary
SELECT Name
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- 51. Find the total cost of all courier services where the cost is less than the maximum cost
SELECT SUM(Cost) AS TotalCost
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);

-- 52. Find all couriers that have been paid for
SELECT c.*
FROM Courier c
INNER JOIN Payment p ON c.CourierID = p.CourierID;

-- 53. Find the locations where the maximum payment amount was made
SELECT l.*
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
WHERE p.Amount = (SELECT MAX(Amount) FROM Payment);

-- 54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName')

SELECT * FROM Courier
WHERE Weight > (SELECT SUM(Weight)FROM Courier WHERE SenderName = 'messi');