-- Create a sample sales database with customers, products, and orders

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    City NVARCHAR(100),
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data into Customers table
INSERT INTO Customers VALUES
(1,'John Smith','New York','2023-01-10'),
(2,'Emma Johnson','Los Angeles','2023-02-15'),
(3,'Michael Brown','Chicago','2023-03-05'),
(4,'Olivia Davis','Houston','2023-03-18'),
(5,'William Miller','Phoenix','2023-04-01'),
(6,'Sophia Wilson','Philadelphia','2023-04-22'),
(7,'James Moore','San Antonio','2023-05-10'),
(8,'Isabella Taylor','San Diego','2023-05-28'),
(9,'Benjamin Anderson','Dallas','2023-06-14'),
(10,'Mia Thomas','San Jose','2023-06-30'),
(11,'Lucas Jackson','Austin','2023-07-12'),
(12,'Charlotte White','Seattle','2023-07-25'),
(13,'Henry Harris','Denver','2023-08-09'),
(14,'Amelia Martin','Boston','2023-08-21'),
(15,'Alexander Thompson','Miami','2023-09-05'),
(16,'Evelyn Garcia','Atlanta','2023-09-19'),
(17,'Daniel Martinez','Orlando','2023-10-02'),
(18,'Harper Robinson','Las Vegas','2023-10-18'),
(19,'Matthew Clark','Portland','2023-11-03'),
(20,'Abigail Rodriguez','San Francisco','2023-11-25');


-- Insert sample data into Products table
INSERT INTO Products VALUES
(1,'Laptop Pro 15','Electronics',1500),
(2,'Wireless Mouse','Electronics',30),
(3,'Mechanical Keyboard','Electronics',120),
(4,'27 inch Monitor','Electronics',400),
(5,'USB-C Hub','Electronics',60),
(6,'Office Chair','Furniture',250),
(7,'Standing Desk','Furniture',500),
(8,'Desk Lamp','Furniture',45),
(9,'Bookshelf','Furniture',180),
(10,'Notebook Pack','Stationery',15),
(11,'Ballpoint Pen Set','Stationery',12),
(12,'Backpack','Accessories',80),
(13,'Water Bottle','Accessories',25),
(14,'Smartphone Stand','Accessories',20),
(15,'Noise Cancelling Headphones','Electronics',350);


-- Insert sample order transactions
INSERT INTO Orders VALUES
(1,1,1,1,'2024-01-10'),
(2,1,2,2,'2024-01-11'),
(3,2,3,1,'2024-01-15'),
(4,3,4,1,'2024-01-20'),
(5,4,5,3,'2024-01-22'),
(6,5,6,1,'2024-02-02'),
(7,6,7,1,'2024-02-05'),
(8,7,8,2,'2024-02-08'),
(9,8,9,1,'2024-02-12'),
(10,9,10,5,'2024-02-15'),
(11,10,11,4,'2024-02-20'),
(12,11,12,1,'2024-02-22'),
(13,12,13,3,'2024-03-01'),
(14,13,14,2,'2024-03-03'),
(15,14,15,1,'2024-03-06'),
(16,15,1,1,'2024-03-08'),
(17,16,2,3,'2024-03-10'),
(18,17,3,2,'2024-03-12'),
(19,18,4,1,'2024-03-15'),
(20,19,5,2,'2024-03-17'),
(21,20,6,1,'2024-03-20'),
(22,2,7,1,'2024-03-22'),
(23,3,8,2,'2024-03-25'),
(24,4,9,1,'2024-03-28'),
(25,5,10,6,'2024-04-01'),
(26,6,11,5,'2024-04-03'),
(27,7,12,1,'2024-04-05'),
(28,8,13,4,'2024-04-07'),
(29,9,14,2,'2024-04-10'),
(30,10,15,1,'2024-04-12'),
(31,11,1,1,'2024-04-15'),
(32,12,2,2,'2024-04-18'),
(33,13,3,1,'2024-04-20'),
(34,14,4,1,'2024-04-22'),
(35,15,5,3,'2024-04-25'),
(36,16,6,1,'2024-04-27'),
(37,17,7,1,'2024-04-29'),
(38,18,8,2,'2024-05-02'),
(39,19,9,1,'2024-05-05'),
(40,20,10,4,'2024-05-08');
