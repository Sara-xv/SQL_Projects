-- ==========================
-- Customers
-- ==========================
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    City NVARCHAR(50),
    RegisterDate DATE
);

-- ==========================
-- Employees
-- ==========================
CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

-- ==========================
-- Categories
-- ==========================
CREATE TABLE Categories
(
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(50)
);

-- ==========================
-- Suppliers
-- ==========================
CREATE TABLE Suppliers
(
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100),
    City NVARCHAR(50)
);

-- ==========================
-- Products
-- ==========================
CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    SupplierID INT,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,

    FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY(SupplierID) REFERENCES Suppliers(SupplierID)
);

-- ==========================
-- Orders
-- ==========================
CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
);

-- ==========================
-- OrderItems
-- ==========================
CREATE TABLE OrderItems
(
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);

-- ==========================
-- Payments
-- ==========================
CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMethod NVARCHAR(30),
    Amount DECIMAL(10,2),
    PaymentDate DATE,

    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
);

--------------------------------------------------
-- Categories
--------------------------------------------------

INSERT INTO Categories VALUES
(1,'Laptop'),
(2,'Mobile'),
(3,'Monitor'),
(4,'Accessories'),
(5,'Storage');

--------------------------------------------------
-- Suppliers
--------------------------------------------------

INSERT INTO Suppliers VALUES
(1,'Dell','Tehran'),
(2,'Samsung','Mashhad'),
(3,'Asus','Tabriz'),
(4,'HP','Shiraz'),
(5,'Logitech','Isfahan');

--------------------------------------------------
-- Employees
--------------------------------------------------

INSERT INTO Employees VALUES
(1,'Ali','Ahmadi','Sales',1800),
(2,'Sara','Mohammadi','Sales',1900),
(3,'Reza','Karimi','Sales',2000),
(4,'Mina','Jafari','Support',1700),
(5,'Hamed','Nazari','Support',1750),
(6,'Nima','Moradi','Sales',2100),
(7,'Maryam','Hosseini','Sales',2200),
(8,'Saeed','Rahimi','Finance',2300),
(9,'Zahra','Ebrahimi','Finance',2400),
(10,'Omid','Yousefi','Manager',3500);

--------------------------------------------------
-- Customers
--------------------------------------------------

INSERT INTO Customers VALUES
(1,'Ali','Ahmadi','Tehran','2023-01-10'),
(2,'Sara','Mohammadi','Mashhad','2023-01-15'),
(3,'Reza','Karimi','Shiraz','2023-01-20'),
(4,'Mina','Jafari','Tabriz','2023-01-22'),
(5,'Hamed','Nazari','Isfahan','2023-01-25'),
(6,'Nima','Moradi','Karaj','2023-02-01'),
(7,'Maryam','Hosseini','Qom','2023-02-03'),
(8,'Saeed','Rahimi','Ahvaz','2023-02-05'),
(9,'Zahra','Ebrahimi','Rasht','2023-02-10'),
(10,'Omid','Yousefi','Yazd','2023-02-12'),

(11,'Parsa','Amini','Tehran','2023-02-15'),
(12,'Negar','Karimi','Mashhad','2023-02-18'),
(13,'Hossein','Taheri','Shiraz','2023-02-20'),
(14,'Fatemeh','Bagheri','Tabriz','2023-02-22'),
(15,'Amir','Rostami','Isfahan','2023-02-25'),
(16,'Mahsa','Jalili','Karaj','2023-03-01'),
(17,'Pouya','Shahidi','Qom','2023-03-05'),
(18,'Elham','Abbasi','Ahvaz','2023-03-08'),
(19,'Arman','Khosravi','Rasht','2023-03-10'),
(20,'Niloofar','Soleimani','Yazd','2023-03-12'),

(21,'Kian','Akbari','Tehran','2023-03-15'),
(22,'Shiva','Hosseini','Mashhad','2023-03-18'),
(23,'Milad','Azizi','Shiraz','2023-03-20'),
(24,'Leila','Ranjbar','Tabriz','2023-03-22'),
(25,'Arash','Mousavi','Isfahan','2023-03-25'),
(26,'Samira','Noori','Karaj','2023-03-28'),
(27,'Sina','Ghasemi','Qom','2023-04-01'),
(28,'Hanieh','Shirazi','Ahvaz','2023-04-03'),
(29,'Navid','Javadi','Rasht','2023-04-05'),
(30,'Yasaman','Eskandari','Yazd','2023-04-08'),

(31,'Mohsen','Nouri','Tehran','2023-04-10'),
(32,'Atena','Maleki','Mashhad','2023-04-12'),
(33,'Peyman','Asadi','Shiraz','2023-04-15'),
(34,'Shirin','Khalili','Tabriz','2023-04-18'),
(35,'Iman','Safari','Isfahan','2023-04-20'),
(36,'Neda','Gholami','Karaj','2023-04-22'),
(37,'Behzad','Ansari','Qom','2023-04-25'),
(38,'Roya','Kiani','Ahvaz','2023-04-27'),
(39,'Majid','Farhadi','Rasht','2023-05-01'),
(40,'Shabnam','Yeganeh','Yazd','2023-05-03'),

(41,'Ehsan','Hashemi','Tehran','2023-05-06'),
(42,'Mitra','Najafi','Mashhad','2023-05-08'),
(43,'Kamran','Aghaei','Shiraz','2023-05-10'),
(44,'Golnaz','Tahmasbi','Tabriz','2023-05-12'),
(45,'Babak','Sharifi','Isfahan','2023-05-15'),
(46,'Taraneh','Mansouri','Karaj','2023-05-18'),
(47,'Farzad','Kaviani','Qom','2023-05-20'),
(48,'Shadi','Nematollahi','Ahvaz','2023-05-23'),
(49,'Hamid','Pournia','Rasht','2023-05-26'),
(50,'Aida','Soltani','Yazd','2023-05-30');

--------------------------------------------------
-- Products
--------------------------------------------------

INSERT INTO Products
(ProductID, CategoryID, SupplierID, ProductName, Price, Stock)
VALUES
(1,1,1,'Dell XPS 13',42000,15),
(2,1,1,'Dell Inspiron 15',31000,20),
(3,1,3,'Asus VivoBook 15',28000,18),
(4,1,3,'Asus ZenBook 14',45000,12),
(5,1,4,'HP Pavilion',34000,14),
(6,1,4,'HP Envy',48000,8),
(7,2,2,'Samsung Galaxy S24',38000,25),
(8,2,2,'Samsung Galaxy A55',18000,30),
(9,2,2,'Samsung Galaxy A35',14500,22),
(10,2,2,'Samsung Galaxy S23 FE',29000,16),

(11,2,3,'Asus ROG Phone',52000,6),
(12,2,1,'Dell Venue Phone',12000,4),
(13,3,2,'Samsung 24 Monitor',8500,20),
(14,3,2,'Samsung 27 Monitor',12500,15),
(15,3,1,'Dell UltraSharp 27',17500,10),
(16,3,4,'HP 24 Monitor',7800,18),
(17,3,3,'Asus ProArt 27',21000,7),
(18,4,5,'Logitech MX Master 3',4200,40),
(19,4,5,'Logitech G502',3100,35),
(20,4,5,'Logitech K380',1900,50),

(21,4,5,'Logitech G Pro Keyboard',5200,18),
(22,4,5,'Logitech Webcam C920',3600,15),
(23,4,5,'Logitech Headset H390',2800,25),
(24,5,2,'Samsung SSD 500GB',3200,28),
(25,5,2,'Samsung SSD 1TB',6100,20),
(26,5,3,'Asus External SSD',7200,12),
(27,5,4,'HP USB Flash 64GB',600,70),
(28,5,4,'HP USB Flash 128GB',900,60),
(29,5,1,'Dell External HDD 1TB',3500,22),
(30,5,1,'Dell External HDD 2TB',5100,15),

(31,1,3,'Asus TUF Gaming',39000,9),
(32,1,1,'Dell Latitude',41000,11),
(33,1,4,'HP EliteBook',47000,7),
(34,2,2,'Samsung Galaxy Z Flip',56000,5),
(35,2,2,'Samsung Galaxy Z Fold',85000,3),
(36,3,3,'Asus Gaming Monitor',24000,8),
(37,3,1,'Dell Curved Monitor',19500,10),
(38,4,5,'Logitech Speakers',2500,20),
(39,4,5,'Logitech Mouse Pad',500,80),
(40,4,5,'Logitech USB Hub',1100,35),

(41,5,2,'Samsung Memory Card 128GB',950,40),
(42,5,2,'Samsung Memory Card 256GB',1700,25),
(43,5,1,'Dell Dock Station',6900,10),
(44,5,3,'Asus Router',5400,13),
(45,4,5,'Logitech StreamCam',5900,8),
(46,1,4,'HP ProBook',36000,14),
(47,2,2,'Samsung Galaxy M55',16500,20),
(48,3,4,'HP 27 Monitor',13500,9),
(49,4,5,'Logitech Mechanical Keyboard',6400,16),
(50,5,1,'Dell USB-C Adapter',850,55);

--------------------------------------------------
-- Orders
--------------------------------------------------

INSERT INTO Orders
(OrderID, CustomerID, EmployeeID, OrderDate, TotalAmount)
VALUES
(1,1,1,'2024-01-05',42000),
(2,2,2,'2024-01-06',38000),
(3,3,3,'2024-01-08',12500),
(4,4,4,'2024-01-10',1900),
(5,5,5,'2024-01-12',6100),
(6,6,6,'2024-01-15',34000),
(7,7,7,'2024-01-18',8500),
(8,8,8,'2024-01-20',17500),
(9,9,9,'2024-01-22',4200),
(10,10,10,'2024-01-25',950),

(11,11,1,'2024-02-01',28000),
(12,12,2,'2024-02-03',14500),
(13,13,3,'2024-02-05',5200),
(14,14,4,'2024-02-08',3500),
(15,15,5,'2024-02-10',45000),
(16,16,6,'2024-02-12',7200),
(17,17,7,'2024-02-14',39000),
(18,18,8,'2024-02-17',56000),
(19,19,9,'2024-02-20',7800),
(20,20,10,'2024-02-22',900),

(21,21,1,'2024-03-01',52000),
(22,22,2,'2024-03-03',19500),
(23,23,3,'2024-03-05',2500),
(24,24,4,'2024-03-07',1700),
(25,25,5,'2024-03-10',47000),
(26,26,6,'2024-03-12',24000),
(27,27,7,'2024-03-15',5400),
(28,28,8,'2024-03-18',36000),
(29,29,9,'2024-03-20',16500),
(30,30,10,'2024-03-22',13500),

(31,31,1,'2024-04-01',6400),
(32,32,2,'2024-04-03',850),
(33,33,3,'2024-04-05',41000),
(34,34,4,'2024-04-07',85000),
(35,35,5,'2024-04-09',21000),
(36,36,6,'2024-04-12',5900),
(37,37,7,'2024-04-15',3600),
(38,38,8,'2024-04-17',5100),
(39,39,9,'2024-04-20',2800),
(40,40,10,'2024-04-22',1100),

(41,41,1,'2024-05-01',31000),
(42,42,2,'2024-05-03',18000),
(43,43,3,'2024-05-06',3200),
(44,44,4,'2024-05-08',600),
(45,45,5,'2024-05-10',48000),
(46,46,6,'2024-05-12',12500),
(47,47,7,'2024-05-15',2800),
(48,48,8,'2024-05-18',6100),
(49,49,9,'2024-05-20',6900),
(50,50,10,'2024-05-22',17500),

(51,1,2,'2024-06-01',38000),
(52,5,3,'2024-06-03',52000),
(53,10,4,'2024-06-05',4200),
(54,15,5,'2024-06-08',14500),
(55,20,6,'2024-06-10',8500),
(56,25,7,'2024-06-12',24000),
(57,30,8,'2024-06-15',19500),
(58,35,9,'2024-06-18',5400),
(59,40,10,'2024-06-20',36000),
(60,45,1,'2024-06-25',6100);


--------------------------------------------------
-- OrderItems
--------------------------------------------------
 
INSERT INTO OrderItems
(OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1,1,1,1,42000),
(2,2,7,1,38000),
(3,3,14,1,12500),
(4,4,20,1,1900),
(5,5,25,1,6100),
(6,6,5,1,34000),
(7,7,13,1,8500),
(8,8,15,1,17500),
(9,9,18,1,4200),
(10,10,41,1,950),
 
(11,11,3,1,28000),
(12,12,9,1,14500),
(13,13,21,1,5200),
(14,14,29,1,3500),
(15,15,4,1,45000),
(16,16,26,1,7200),
(17,17,31,1,39000),
(18,18,34,1,56000),
(19,19,16,1,7800),
(20,20,28,1,900),
 
(21,21,11,1,52000),
(22,22,37,1,19500),
(23,23,38,1,2500),
(24,24,42,1,1700),
(25,25,33,1,47000),
(26,26,36,1,24000),
(27,27,44,1,5400),
(28,28,46,1,36000),
(29,29,47,1,16500),
(30,30,48,1,13500),
 
(31,31,49,1,6400),
(32,32,50,1,850),
(33,33,32,1,41000),
(34,34,35,1,85000),
(35,35,17,1,21000),
(36,36,45,1,5900),
(37,37,22,1,3600),
(38,38,30,1,5100),
(39,39,23,1,2800),
(40,40,40,1,1100),
 
(41,41,2,1,31000),
(42,42,8,1,18000),
(43,43,24,1,3200),
(44,44,27,1,600),
(45,45,6,1,48000),
(46,46,14,1,12500),
(47,47,23,1,2800),
(48,48,25,1,6100),
(49,49,43,1,6900),
(50,50,15,1,17500),
 
(51,51,7,1,38000),
(52,52,11,1,52000),
(53,53,18,1,4200),
(54,54,9,1,14500),
(55,55,13,1,8500),
(56,56,36,1,24000),
(57,57,37,1,19500),
(58,58,44,1,5400),
(59,59,46,1,36000),
(60,60,25,1,6100);
 
--------------------------------------------------
-- Payments
-- (PaymentDate = OrderDate, یعنی پرداخت همان روز سفارش انجام شده)
-- روش پرداخت به‌صورت چرخشی بین چهار حالت رایج تخصیص داده شده
--------------------------------------------------
 
INSERT INTO Payments
(PaymentID, OrderID, PaymentMethod, Amount, PaymentDate)
VALUES
(1,1,'Credit Card',42000,'2024-01-05'),
(2,2,'Cash',38000,'2024-01-06'),
(3,3,'Bank Transfer',12500,'2024-01-08'),
(4,4,'Online',1900,'2024-01-10'),
(5,5,'Credit Card',6100,'2024-01-12'),
(6,6,'Cash',34000,'2024-01-15'),
(7,7,'Bank Transfer',8500,'2024-01-18'),
(8,8,'Online',17500,'2024-01-20'),
(9,9,'Credit Card',4200,'2024-01-22'),
(10,10,'Cash',950,'2024-01-25'),
 
(11,11,'Bank Transfer',28000,'2024-02-01'),
(12,12,'Online',14500,'2024-02-03'),
(13,13,'Credit Card',5200,'2024-02-05'),
(14,14,'Cash',3500,'2024-02-08'),
(15,15,'Bank Transfer',45000,'2024-02-10'),
(16,16,'Online',7200,'2024-02-12'),
(17,17,'Credit Card',39000,'2024-02-14'),
(18,18,'Cash',56000,'2024-02-17'),
(19,19,'Bank Transfer',7800,'2024-02-20'),
(20,20,'Online',900,'2024-02-22'),
 
(21,21,'Credit Card',52000,'2024-03-01'),
(22,22,'Cash',19500,'2024-03-03'),
(23,23,'Bank Transfer',2500,'2024-03-05'),
(24,24,'Online',1700,'2024-03-07'),
(25,25,'Credit Card',47000,'2024-03-10'),
(26,26,'Cash',24000,'2024-03-12'),
(27,27,'Bank Transfer',5400,'2024-03-15'),
(28,28,'Online',36000,'2024-03-18'),
(29,29,'Credit Card',16500,'2024-03-20'),
(30,30,'Cash',13500,'2024-03-22'),
 
(31,31,'Bank Transfer',6400,'2024-04-01'),
(32,32,'Online',850,'2024-04-03'),
(33,33,'Credit Card',41000,'2024-04-05'),
(34,34,'Cash',85000,'2024-04-07'),
(35,35,'Bank Transfer',21000,'2024-04-09'),
(36,36,'Online',5900,'2024-04-12'),
(37,37,'Credit Card',3600,'2024-04-15'),
(38,38,'Cash',5100,'2024-04-17'),
(39,39,'Bank Transfer',2800,'2024-04-20'),
(40,40,'Online',1100,'2024-04-22'),
 
(41,41,'Credit Card',31000,'2024-05-01'),
(42,42,'Cash',18000,'2024-05-03'),
(43,43,'Bank Transfer',3200,'2024-05-06'),
(44,44,'Online',600,'2024-05-08'),
(45,45,'Credit Card',48000,'2024-05-10'),
(46,46,'Cash',12500,'2024-05-12'),
(47,47,'Bank Transfer',2800,'2024-05-15'),
(48,48,'Online',6100,'2024-05-18'),
(49,49,'Credit Card',6900,'2024-05-20'),
(50,50,'Cash',17500,'2024-05-22'),
 
(51,51,'Bank Transfer',38000,'2024-06-01'),
(52,52,'Online',52000,'2024-06-03'),
(53,53,'Credit Card',4200,'2024-06-05'),
(54,54,'Cash',14500,'2024-06-08'),
(55,55,'Bank Transfer',8500,'2024-06-10'),
(56,56,'Online',24000,'2024-06-12'),
(57,57,'Credit Card',19500,'2024-06-15'),
(58,58,'Cash',5400,'2024-06-18'),
(59,59,'Bank Transfer',36000,'2024-06-20'),
(60,60,'Online',6100,'2024-06-25');