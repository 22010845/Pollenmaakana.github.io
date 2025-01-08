
create database MaseruMall
-- Use the database
USE MaseruMall;

-- Create Shops Table
CREATE TABLE Shops (
    ShopID INT PRIMARY KEY,
    ShopName VARCHAR(255) NOT NULL,
    ShopNumber INT NOT NULL,
    BusinessType VARCHAR(100),
    CoverageArea DECIMAL(10, 2),
    ContactNumber VARCHAR(15),
    Location VARCHAR(255)

);

CREATE TABLE ShopEmployees (
    EmployeeID INT IDENTITY(10,1) PRIMARY KEY,
    EmployeeName VARCHAR(255),
    DateOfBirth DATE,
    Age INT,
    Role VARCHAR(100),
    ContactNumber VARCHAR(15),
    ShopID INT,
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
    CONSTRAINT chk_DateOfBirth_ShopEmployees CHECK (DateOfBirth <= DATEADD(YEAR, -18, GETDATE())),
    CONSTRAINT chk_Phone_ShopEmployees CHECK (LEN(ContactNumber) = 8 AND ContactNumber LIKE '[0-9]%')
);

 
 -- Create MallEmployees Table
CREATE TABLE MallEmployees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    DateOfBirth DATE,
    Age INT,
    Role VARCHAR(100),
    ContactNumber VARCHAR(15),
    CONSTRAINT chk_ContactNumber CHECK (ContactNumber LIKE '[0-9]%' AND LEN(ContactNumber) = 8)
);

-- Create Maintenance Table
CREATE TABLE Maintenance (
    MaintenanceID  INT IDENTITY(20,1)  PRIMARY KEY,
    ShopID INT,
    MaintenanceStatus VARCHAR(100),
    CostEstimate DECIMAL(10, 2),
    ActualCost DECIMAL(10, 2),
    PriorityOfJob VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
    FOREIGN KEY (EmployeeID) REFERENCES MallEmployees(EmployeeID)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(30,1)  PRIMARY KEY,
    ShopID INT,
    ProductName VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    QuantityInStock INT,
    Laybuys INT,
    ReorderQuantityLevel INT,
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(400,1)  PRIMARY KEY,
    CustomerType VARCHAR(50),
    Name VARCHAR(255),
    Age INT,
    EmailAddress VARCHAR(255),
    [Transaction] VARCHAR(255),  -- 'Transaction' is now enclosed in square brackets
    ProductID INT,
    ShopID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)
); 

-- Add Check Constraint to MallEmployees Table for Age
ALTER TABLE MallEmployees
ADD CONSTRAINT chk_DateOfBirth_MallEmployees CHECK (DateOfBirth <= DATEADD(YEAR, -18, GETDATE()));

-- Create Leases Table
CREATE TABLE Leases (
    LeaseID INT IDENTITY(50,1)PRIMARY KEY,
    ShopID INT,
    LeaseDuration INT,
    LeaseOwner VARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    RentAmount DECIMAL(10, 2),
    SecurityDeposit DECIMAL(10, 2),
    PaymentFrequency VARCHAR(50),
    LeaseType VARCHAR(50),
    RenewalOptions VARCHAR(255),
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)
);

-- Create Sales Table
CREATE TABLE Sales (
    SalesID INT IDENTITY(60,1) PRIMARY KEY,
    ShopID INT,
    ProductID INT,
    CustomerID INT,
    DateOfSales DATE,
    SalesQuantity INT,
    SalesUnitPrice DECIMAL(10, 2),
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SecurityIncident Table
CREATE TABLE SecurityIncident (
    IncidentID INT PRIMARY KEY,
    DateAndTime DATETIME,
    Location VARCHAR(255),
    EmployeeID INT,
    Status VARCHAR(100),
    RespondTime TIME,
    ActionTaken TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES MallEmployees(EmployeeID)
);
go
-- Insert Data into Shops Table
INSERT INTO Shops (ShopID, ShopName, ShopNumber, BusinessType, CoverageArea, ContactNumber, Location)
VALUES
(1, 'Fashion World', 101, 'Clothing', 150.00, '71123456', 'Ground Floor'),
(2, 'Tech Central', 102, 'Electronics', 160.00, '81198765', 'First Floor'),
(3, 'Home Living', 103, 'Furniture', 180.00, '71234567', 'Second Floor'),
(4, 'Gadgets & Gear', 104, 'Electronics', 167.00, '61098765', 'Ground Floor'),
(5, 'Shoes & More', 105, 'Footwear', 190.00, '71156473', 'First Floor'),
(6, 'Beauty Zone', 106, 'Beauty', 140.00, '61165748', 'Second Floor'),
(7, 'Sports Hub', 107, 'Sports Equipment', 120.00, '61067895', 'Ground Floor'),
(8, 'Luxury Watches', 108, 'Jewelry', 150.00, '71287654', 'First Floor'),
(9, 'Book Haven', 109, 'Books', 134.00, '71023456', 'Second Floor'),
(10, 'Grocery Stop', 110, 'Grocery', 156.00, '71234512', 'Ground Floor');
 
-- Insert Data into ShopEmployees Table
INSERT INTO ShopEmployees (EmployeeName, DateOfBirth, Age, Role, ContactNumber, ShopID)
VALUES
('Keabetswe Phiri', '1990-04-04', 34, 'Sales Assistant', '81234567', 1),
('Tshegofatso Mabuza', '1989-11-15', 35, 'Cashier', '71123456', 2),
('Phetogo Selepe', '1992-07-21', 32, 'Store Manager', '61098765', 3),
('Neo Dube', '1988-12-03', 36, 'Security Guard', '71156473', 4),
('Mpho Tsotetsi', '1991-03-29', 33, 'Supervisor', '81165748', 5),
('Mmathapelo Kgosi', '1994-10-11', 30, 'Sales Assistant', '71067895', 6),
('Kgomotso Modise', '1993-09-04', 31, 'Cleaner', '71287654', 7),
('Bontle Khama', '1995-01-19', 29, 'Manager', '71123456', 8),
('Olebogeng Keatley', '1986-05-15', 38, 'Maintenance Worker', '81234512', 9),
('Sello Makhubela', '1992-06-30', 32, 'Cashier', '71023456', 10);

INSERT INTO MallEmployees (EmployeeID, EmployeeName, DateOfBirth, Age, Role, ContactNumber)
VALUES
(1, 'Thato Mooketsi', '1985-06-15', 39, 'Security Officer', '61012345'),
(2, 'Lerato Khumalo', '1990-01-20', 34, 'Cleaning Supervisor', '71123456'),
(3, 'Reabetswe Modise', '1992-08-30', 32, 'Maintenance Manager', '81234567'),
(4, 'Tebogo Kgatlwane', '1987-02-18', 37, 'Customer Service Manager', '71098765'),
(5, 'Masego Nthekela', '1995-04-11', 29, 'Marketing Coordinator', '81156473'),
(6, 'Keletso Makgato', '1988-12-09', 36, 'Facilities Manager', '71165748'),
(7, 'Kabelo Motshidi', '1991-11-03', 33, 'Finance Officer', '81067895'),
(8, 'Lindiwe Makgola', '1993-07-24', 31, 'Operations Coordinator', '81287654'),
(9, 'Palesa Kgomo', '1990-09-11', 34, 'IT Support Technician', '71023456'),
(10, 'Ofentse Dintwa', '1989-03-02', 35, 'Human Resources Officer', '71123456');

-- Insert Data into Maintenance Table

INSERT INTO Maintenance (ShopID, MaintenanceStatus, CostEstimate, ActualCost, PriorityOfJob, EmployeeID)
VALUES
(1, 'Completed', 1500.00, 1400.00, 'High', 1),
(2, 'Pending', 500.00, 0.00, 'Medium', 2),
(3, 'Completed', 800.00, 750.00, 'Low', 3),
(4, 'Completed', 1200.00, 1100.00, 'High', 4),
(5, 'Pending', 600.00, 0.00, 'Low', 5),
(6, 'Completed', 400.00, 350.00, 'Medium', 6),
(7, 'Pending', 1000.00, 0.00, 'High', 7),
(8, 'Completed', 2000.00, 1900.00, 'Medium', 8),
(9, 'Pending', 1500.00, 0.00, 'Low', 9),
(10, 'Completed', 1200.00, 1150.00, 'High', 10);


-- Insert Data into Products Table
INSERT INTO Products (ShopID, ProductName, Description, Price, QuantityInStock, Laybuys, ReorderQuantityLevel)
VALUES
(1, 'T-Shirt', 'Cotton T-Shirt', 150.00, 50, 0, 10),
(2, 'Smartphone', 'Latest model smartphone', 5000.00, 30, 1, 5),
(3, 'Sofa Set', '3-piece sofa set', 3000.00, 20, 1, 3),
(4, 'Laptop', 'High-performance laptop', 7500.00, 15, 0, 3),
(5, 'Running Shoes', 'Comfortable sports shoes', 800.00, 40, 1, 8),
(6, 'Lipstick', 'Long-lasting lipstick', 250.00, 60, 0, 5),
(7, 'Football', 'Professional football', 400.00, 25, 1, 3),
(8, 'Wristwatch', 'Luxury wristwatch', 10000.00, 10, 0, 2),
(9, 'Novel', 'Fiction novel', 200.00, 100, 1, 20),
(10, 'Groceries', 'Groceries for the week', 800.00, 50, 1, 10);

-- Insert Data into Customers Table
INSERT INTO Customers (CustomerType, Name, Age, EmailAddress, [Transaction], ProductID, ShopID)
VALUES
('Ordinary', 'John Doe', 30, 'john.doe@example.com', 'Purchase', 30, 1),
('Platinum', 'Jane Smith', 28, 'jane.smith@example.com', 'Purchase', 31, 2),
('Ordinary', 'Michael Johnson', 35, 'michael.johnson@example.com', 'Return', 32, 3),
('Platinum', 'Emily Davis', 25, 'emily.davis@example.com', 'Exchange', 33, 4),
('Ordinary', 'David Lee', 40, 'david.lee@example.com', 'Purchase',34, 5),
('Platinum', 'Sarah Williams', 32, 'sarah.williams@example.com', 'Purchase',35, 6),
('Ordinary', 'Kevin Brown', 45, 'kevin.brown@example.com', 'Return', 36, 7),
('Platinum', 'Olivia Taylor', 29, 'olivia.taylor@example.com', 'Exchange', 37, 8),
('Ordinary', 'Sophia Wilson', 26, 'sophia.wilson@example.com', 'Purchase', 38, 9),
('Platinum', 'Daniel Moore', 38, 'daniel.moore@example.com', 'Purchase', 39, 10);



-- Insert Data into Sales Table
INSERT INTO Sales (ShopID, ProductID, CustomerID, DateOfSales, SalesQuantity, SalesUnitPrice)
VALUES
(1, 30, 400, '2024-11-01', 2, 150.00),
(2, 31, 401, '2024-11-02', 1, 5000.00),
(3, 32, 402, '2024-11-03', 1, 3000.00),
(4, 33, 403, '2024-11-04', 1, 7500.00),
(5, 34, 404, '2024-11-05', 3, 800.00),
(6, 35, 405, '2024-11-06', 2, 250.00),
(7, 36, 406, '2024-11-07', 1, 400.00),
(8, 37, 407, '2024-11-08', 1, 10000.00),
(9, 38, 408, '2024-11-09', 5, 200.00),
(10, 39, 409, '2024-11-10', 1, 800.00);



-- Insert Data into SecurityIncident Table
INSERT INTO SecurityIncident (IncidentID, DateAndTime, Location, EmployeeID, Status, RespondTime, ActionTaken)
VALUES
(1, '2024-11-01 08:30:00', 'Fashion World', 1, 'Resolved', '00:30:00', 'Reported to supervisor'),
(2, '2024-11-02 09:00:00', 'Tech Central', 2, 'Pending', '01:00:00', 'Under investigation'),
(3, '2024-11-03 10:00:00', 'Home Living', 3, 'Resolved', '00:45:00', 'Issue reported'),
(4, '2024-11-04 11:30:00', 'Gadgets & Gear', 4, 'Resolved', '00:20:00', 'Action taken'),
(5, '2024-11-05 12:00:00', 'Shoes & More', 5, 'Pending', '00:40:00', 'Security notified'),
(6, '2024-11-06 13:15:00', 'Beauty Zone', 6, 'Resolved', '00:25:00', 'Closed after investigation'),
(7, '2024-11-07 14:45:00', 'Sports Hub', 7, 'Pending', '01:10:00', 'Security alerted'),
(8, '2024-11-08 15:00:00', 'Luxury Watches', 8, 'Resolved', '00:35:00', 'Checked by mall security'),
(9, '2024-11-09 16:20:00', 'Book Haven', 9, 'Pending', '01:30:00', 'Under review'),
(10, '2024-11-10 17:50:00', 'Grocery Stop', 10, 'Resolved', '00:15:00', 'Resolved after mall manager intervention');



INSERT INTO Leases (ShopID, LeaseDuration, LeaseOwner, StartDate, EndDate, RentAmount, SecurityDeposit, PaymentFrequency, LeaseType, RenewalOptions)
VALUES
(1, 12, 'John Doe', '2024-01-01', '2025-01-01', 1000.00, 500.00, 'Monthly', 'Fixed-term', 'No'),
(2, 24, 'Jane Smith', '2024-05-01', '2026-05-01', 1200.00, 600.00, 'Quarterly', 'Renewable', 'Yes'),
(3, 36, 'Emily Davis', '2024-02-01', '2027-02-01', 1500.00, 750.00, 'Annually', 'Fixed-term', 'No'),
(4, 18, 'Michael Johnson', '2024-03-01', '2025-09-01', 900.00, 450.00, 'Monthly', 'Renewable', 'Yes'),
(5, 12, 'Sarah Williams', '2024-06-01', '2025-06-01', 1100.00, 550.00, 'Monthly', 'Fixed-term', 'No'),
(6, 24, 'David Lee', '2024-07-01', '2026-07-01', 950.00, 475.00, 'Quarterly', 'Renewable', 'Yes'),
(7, 36, 'Kevin Brown', '2024-08-01', '2027-08-01', 1300.00, 650.00, 'Annually', 'Fixed-term', 'No'),
(8, 24, 'Olivia Taylor', '2024-09-01', '2026-09-01', 1400.00, 700.00, 'Monthly', 'Renewable', 'Yes'),
(9, 12, 'Sophia Wilson', '2024-10-01', '2025-10-01', 800.00, 400.00, 'Quarterly', 'Fixed-term', 'No'),
(10, 18, 'Daniel Moore', '2024-11-01', '2026-11-01', 1000.00, 500.00, 'Monthly', 'Renewable', 'Yes');
go
select * from shops
-- Select all from ShopEmployees table
SELECT * FROM ShopEmployees;

-- Select all from Maintenance table
SELECT * FROM Maintenance;

-- Select all from Products table
SELECT * FROM Products;

-- Select all from Customers table
SELECT * FROM Customers;

-- Select all from MallEmployees table
SELECT * FROM MallEmployees;

-- Select all from Leases table
SELECT * FROM Leases;

-- Select all from Sales table
SELECT * FROM Sales;

-- Select all from SecurityIncident table
SELECT * FROM SecurityIncident;
go
-- Display relevant information on customers who have registered their information in the different shops:
SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    c.EmailAddress,
    c.CustomerType,
    s.ShopName,
    p.ProductName
FROM Customers c
JOIN Shops s ON c.ShopID = s.ShopID
JOIN Products p ON c.ProductID = p.ProductID;
go
--Display rental balances for the different shop owners:
SELECT 
    l.LeaseID,
    s.ShopName,
    l.RentAmount,
    l.StartDate,
    l.EndDate,
    DATEDIFF(MONTH, l.StartDate, GETDATE()) AS MonthsElapsed,
    l.RentAmount * DATEDIFF(MONTH, l.StartDate, GETDATE()) AS RentBalance
FROM Leases l
JOIN Shops s ON l.ShopID = s.ShopID
WHERE l.EndDate >= GETDATE();  
go

-- Display information on maintenance applications and approval status:
SELECT 
    m.MaintenanceID,
    s.ShopName,
    m.MaintenanceStatus,
    m.CostEstimate,
    m.ActualCost,
    m.PriorityOfJob,
    se.EmployeeName AS AssignedEmployee
FROM Maintenance m
JOIN Shops s ON m.ShopID = s.ShopID
JOIN ShopEmployees se ON m.EmployeeID = se.EmployeeID;
go

--Display information on how much rent will be paid in the lease period, determined by the square meters of the shops rented:
SELECT 
    l.LeaseID,
    s.ShopName,
    l.LeaseDuration,
    s.CoverageArea,
    l.RentAmount * l.LeaseDuration AS TotalRentForLease
FROM Leases l
JOIN Shops s ON l.ShopID = s.ShopID;
go

--Display customers who are defaulting on the items on lay buys in the different shops:
SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    c.EmailAddress,
    p.ProductName,
    p.Laybuys,
    s.ShopName
FROM Customers c
JOIN Products p ON c.ProductID = p.ProductID
JOIN Shops s ON c.ShopID = s.ShopID
WHERE p.Laybuys > 0;
go


--Stored Procedure to Return All Transactions for a Specific Customer with Respect to Shops Transacted:
CREATE PROCEDURE GetCustomerTransactions
    @CustomerID INT
AS
BEGIN
    SELECT 
        c.CustomerID,
        c.Name AS CustomerName,
        c.CustomerType,
        c.EmailAddress,
        s.ShopID,
        s.ShopName,
        s.ShopNumber,
        s.BusinessType,
        p.ProductName,
        sa.SalesQuantity,
        sa.SalesUnitPrice,
        sa.DateOfSales,
        sa.SalesQuantity * sa.SalesUnitPrice AS TotalTransactionAmount
    FROM 
        Customers c
    INNER JOIN 
        Sales sa ON c.CustomerID = sa.CustomerID
    INNER JOIN 
        Shops s ON sa.ShopID = s.ShopID
    INNER JOIN 
        Products p ON sa.ProductID = p.ProductID
    WHERE 
        c.CustomerID = @CustomerID
    ORDER BY 
        sa.DateOfSales DESC;
END;
go

EXEC GetCustomerTransactions @CustomerID = 401;

go


ALTER TABLE dbo.Leases
ADD LeaseStatus VARCHAR(50);  -- Add a column to track the lease status (if not already present)
go

CREATE PROCEDURE CheckAndRecordLeaseDefault
AS
BEGIN
    DECLARE @ShopID INT, 
            @Message NVARCHAR(255), 
            @CurrentDate DATE = GETDATE(),
            @RentalDueDate DATE, 
            @RentalFrequency NVARCHAR(50);

    -- Cursor to loop through shops that are potentially defaulting
    DECLARE LeaseCursor CURSOR FOR
    SELECT 
        s.ShopID, 
        l.StartDate,  -- Using StartDate as reference for rental due date
        l.PaymentFrequency
    FROM 
        dbo.Leases l  -- Ensure correct schema for Leases
    JOIN 
        dbo.Shops s ON l.ShopID = s.ShopID  -- Ensure correct schema for Shops
    WHERE 
        -- We are assuming rental due date is based on the StartDate and PaymentFrequency
        -- Adjust the logic for RentalDueDate based on how payments work in your setup
        l.StartDate <= @CurrentDate
        AND ((l.PaymentFrequency = 'Monthly' AND DATEDIFF(MONTH, l.StartDate, @CurrentDate) >= 1)
             OR (l.PaymentFrequency = 'Quarterly' AND DATEDIFF(QUARTER, l.StartDate, @CurrentDate) >= 1));

    OPEN LeaseCursor;

    FETCH NEXT FROM LeaseCursor INTO @ShopID, @RentalDueDate, @RentalFrequency;

    -- Loop through each shop to record defaults
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Update the Leases table to indicate a default
        UPDATE dbo.Leases  -- Corrected schema name
        SET LeaseStatus = 'Default'
        WHERE ShopID = @ShopID AND StartDate = @RentalDueDate;

        -- Set message for the defaulting shop
        SET @Message = 'Shop ID ' + CAST(@ShopID AS NVARCHAR) + ' is defaulting on rental payment.';

        -- Output the message (you can adjust how you want the message to be displayed)
        PRINT @Message;

        FETCH NEXT FROM LeaseCursor INTO @ShopID, @RentalDueDate, @RentalFrequency;
    END;

    CLOSE LeaseCursor;
    DEALLOCATE LeaseCursor;
END;
go
-- Insert sample Shops
INSERT INTO dbo.Shops (ShopID,ShopName, ShopNumber, BusinessType, CoverageArea, ContactNumber, Location)
VALUES
(13, 'Shop A', 111, 'Retail', 100.50, '1234567890', 'Mall Floor 1'),
(14, 'Shop B', 112, 'Restaurant', 50.75, '0987654321', 'Mall Floor 2');

go
-- Insert sample Leases
INSERT INTO dbo.Leases (ShopID, LeaseDuration, LeaseOwner, StartDate, EndDate, RentAmount, SecurityDeposit, PaymentFrequency, LeaseType, RenewalOptions)
VALUES
(1, 12, 'Owner A', '2023-01-01', '2024-01-01', 5000.00, 1000.00, 'Monthly', 'Fixed', 'Yes'),
(2, 12, 'Owner B', '2023-03-01', '2024-03-01', 3000.00, 500.00, 'Quarterly', 'Flexible', 'No');
go
EXEC CheckAndRecordLeaseDefault;
go

CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    PurchaseDate DATETIME,
    SupplierName VARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
go

CREATE TABLE InventoryLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    QuantityUpdated INT,
    UpdateDate DATETIME
);
go
--Automatic Product Inventory Update on Stock Purchase
CREATE TRIGGER trg_UpdateInventoryOnPurchase
ON Purchases
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT, @QuantityPurchased INT;

    -- Get product details from the inserted record
    SELECT @ProductID = ProductID, @QuantityPurchased = Quantity
    FROM INSERTED;

    -- Update the inventory by adding the purchased quantity to the existing stock
    UPDATE Products
    SET QuantityInStock = QuantityInStock + @QuantityPurchased
    WHERE ProductID = @ProductID;

    -- Optional: Log the inventory update (for auditing purposes)
    INSERT INTO InventoryLog (ProductID, QuantityUpdated, UpdateDate)
    VALUES (@ProductID, @QuantityPurchased, GETDATE());
END;
go
-- Insert sample product data into Products table
INSERT INTO dbo.Products ( ProductName, Price, QuantityInStock, Laybuys, ReorderQuantityLevel)
VALUES
( 'Product A', 10.00, 50, 0, 5),  -- Initial stock is 50
( 'Product B', 20.00, 30, 0, 5);  -- Initial stock is 30
go

-- Insert a purchase record that will trigger the inventory update
INSERT INTO dbo.Purchases (PurchaseID,ProductID, Quantity)
VALUES (1,43, 10);  -- 10 units of Product A purchased
go
-- Verify that Product A's stock was updated
SELECT ProductID, ProductName, QuantityInStock
FROM dbo.Products
WHERE ProductID = 43;
go

-- Verify that an inventory log entry was created
SELECT * FROM dbo.InventoryLog;
go

-- Insert another purchase for Product B
INSERT INTO dbo.Purchases (PurchaseID,ProductID, Quantity)
VALUES (3,43, 5);  -- 5 units of Product B purchased
go

select * from Purchases



select * from Products

--Ensure No Two Stores Can Occupy the Same Space in the Mall
CREATE TRIGGER trg_PreventDuplicateShopLocation
ON Shops
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @ShopID INT, @ShopNumber INT, @Location VARCHAR(255);

    -- Get the inserted or updated shop details
    SELECT @ShopID = ShopID, @ShopNumber = ShopNumber, @Location = Location
    FROM INSERTED;

    -- Check if another shop has the same shop number or location
    IF EXISTS (
        SELECT 1
        FROM Shops
        WHERE (ShopNumber = @ShopNumber OR Location = @Location)
            AND ShopID <> @ShopID
    )
    BEGIN
        -- Rollback the transaction if a conflict is found
        ROLLBACK TRANSACTION;
        PRINT 'Error: Two shops cannot occupy the same space or have the same shop number!';
    END;
END;
go
-- Insert two shops with different locations and shop numbers
INSERT INTO Shops (ShopID, ShopName, ShopNumber, BusinessType, CoverageArea, ContactNumber, Location)
VALUES
(15, 'Shop A', 101, 'Retail', 100.50, '1234567890', 'Mall Floor 1'),
(16, 'Shop B', 102, 'Restaurant', 50.75, '0987654321', 'Mall Floor 2');

go
select * from Shops
go
-- Create the ShopOwners table (if not already created)
CREATE TABLE ShopOwners (
    OwnerID INT PRIMARY KEY,
    ShopID INT,
    OwnerName VARCHAR(255),
    Email VARCHAR(255),
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)
);
go


CREATE TRIGGER trg_NotifyShopOwnerWhenLowStock
ON Sales
AFTER INSERT
AS
BEGIN
    DECLARE @ShopID INT, @ProductID INT, @SalesQuantity INT, @NewStockLevel INT, @ReorderLevel INT;

    -- Loop through all inserted records
    DECLARE sales_cursor CURSOR FOR
    SELECT ShopID, ProductID, SalesQuantity
    FROM INSERTED;

    OPEN sales_cursor;
    FETCH NEXT FROM sales_cursor INTO @ShopID, @ProductID, @SalesQuantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ensure that the ProductID exists in the Products table
        IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
        BEGIN
            -- Get the current stock level and reorder level for the product
            SELECT @NewStockLevel = QuantityInStock - @SalesQuantity, @ReorderLevel = ReorderQuantityLevel
            FROM Products
            WHERE ProductID = @ProductID;

            -- Check if the product is low in stock
            IF @NewStockLevel < @ReorderLevel
            BEGIN
                -- For demonstration, we will print a message (you can replace this with actual notification logic)
                PRINT 'Low stock alert: Shop owner of ShopID ' + CAST(@ShopID AS VARCHAR) +
                      ' is notified that product ' + CAST(@ProductID AS VARCHAR) + ' is low in stock!';
            END;

            -- Update the stock level in the Products table
            UPDATE Products
            SET QuantityInStock = @NewStockLevel
            WHERE ProductID = @ProductID;
        END
        ELSE
        BEGIN
            PRINT 'Error: ProductID ' + CAST(@ProductID AS VARCHAR) + ' does not exist in the Products table.';
        END;

        FETCH NEXT FROM sales_cursor INTO @ShopID, @ProductID, @SalesQuantity;
    END

    CLOSE sales_cursor;
    DEALLOCATE sales_cursor;
END;
GO
-- Insert two sales records
INSERT INTO Sales (ShopID, ProductID, SalesQuantity, DateOfSales, SalesUnitPrice)
VALUES (1, 40, 0, GETDATE(), 0),  -- Sale 1
       (1, 40, 0, GETDATE(), 15.00);  -- Sale 2
GO

-- Check the updated stock level for the product
SELECT ProductID, ProductName, QuantityInStock, ReorderQuantityLevel
FROM Products
WHERE ProductID = 40;
GO

select * from Products

CREATE TRIGGER trg_NotifyShopOwnerWhenLowStock
ON Sales
AFTER INSERT
AS
BEGIN
    DECLARE @ShopID INT, @ProductID INT, @SalesQuantity INT, @NewStockLevel INT, @ReorderLevel INT;

    -- Get the sales details
    SELECT @ShopID = ShopID, @ProductID = ProductID, @SalesQuantity = SalesQuantity
    FROM INSERTED;

    -- Ensure that the ProductID exists in the Products table
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        -- Get the current stock level and reorder level for the product
        SELECT @NewStockLevel = QuantityInStock - @SalesQuantity, @ReorderLevel = ReorderQuantityLevel
        FROM Products
        WHERE ProductID = @ProductID;

        -- Check if the product is low in stock
        IF @NewStockLevel < @ReorderLevel
        BEGIN
            -- For demonstration, we will print a message (you can replace this with actual notification logic)
            PRINT 'Low stock alert: Shop owner of ShopID ' + CAST(@ShopID AS VARCHAR) +
                  ' is notified that product ' + CAST(@ProductID AS VARCHAR) + ' is low in stock!';
            
            -- Optionally, log the notification or send an actual email, etc.
        END;

        -- Update the stock level in the Products table
        UPDATE Products
        SET QuantityInStock = @NewStockLevel
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        PRINT 'Error: ProductID ' + CAST(@ProductID AS VARCHAR) + ' does not exist in the Products table.';
    END
END;
GO
UPDATE Products
SET ReorderQuantityLevel = 20  -- Example value; adjust as needed
WHERE ProductID = 40;
go
UPDATE Products
SET ShopID = 1,  -- Assuming ShopID = 1 is valid for this product
    Description = 'Laptop',
    Price = 500.00  -- Example price
WHERE ProductID = 40;


SELECT * FROM Products WHERE ProductID = 40;


-- Insert a sale into the Sales table to trigger the stock level check
INSERT INTO Sales (ShopID, ProductID, SalesQuantity, DateOfSales, SalesUnitPrice)
VALUES (1, 40, 5, GETDATE(), 10.00);  -- Adjust these values as needed
go
INSERT INTO Sales (ShopID, ProductID, SalesQuantity, DateOfSales, SalesUnitPrice)
VALUES (1, 40, 5, GETDATE(), 500.00); 
go -- Example sale
SELECT ProductID, ProductName, QuantityInStock, ReorderQuantityLevel
FROM Products
WHERE ProductID = 40;
go

-- Check the updated stock level for the product
SELECT ProductID, ProductName, QuantityInStock
FROM Products
WHERE ProductID = 40;  -- Adjust with the correct ProductID
go
--Generating Reports Based on Sales Date or Product Sold
CREATE INDEX idx_Sales_Report
ON Sales (DateOfSales, ProductID);
go 
SELECT * 
FROM Sales 
WHERE DateOfSales BETWEEN '2024-01-01' AND '2024-12-31' 
  AND ProductID = 30;

  go
-- Searching for Lease Agreements Based on Start and End Dates
CREATE INDEX idx_Leases_DateRange
ON Leases (StartDate, EndDate);
SELECT * 
FROM Leases 
WHERE StartDate >= '2024-01-01' 
  AND EndDate <= '2025-12-31';
go
--Frequently Searching for Customers by Their Names or Email Addresses
CREATE INDEX idx_Customers_Name_Email
ON Customers (Name, EmailAddress);
go
SELECT * 
FROM Customers 
WHERE Name = 'John Doe' 
   OR EmailAddress = 'john.doe@example.com';
  go

--Calculate the Total Sales for a Specific Shop Over a Given Period of Time
CREATE FUNCTION fn_CalculateTotalSalesForShop
(
    @ShopID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(10, 2);

    SELECT @TotalSales = SUM(SalesQuantity * SalesUnitPrice)
    FROM Sales
    WHERE ShopID = @ShopID
      AND DateOfSales BETWEEN @StartDate AND @EndDate;

    RETURN ISNULL(@TotalSales, 0);
END;
go
SELECT dbo.fn_CalculateTotalSalesForShop(2, '2024-11-02', '2025-12-31');

go
--Calculate Total Revenue from Rentals Collected from All Shops in the Mall Over a Given Period of Time
CREATE FUNCTION fn_CalculateTotalRentalRevenue
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10, 2);

    SELECT @TotalRevenue = SUM(RentAmount)
    FROM Leases
    WHERE StartDate <= @EndDate
      AND EndDate >= @StartDate;

    RETURN ISNULL(@TotalRevenue, 0);
END;
go

SELECT dbo.fn_CalculateTotalRentalRevenue('2024-01-01', '2024-12-31');
go

--Calculate the Yearly 10% Escalation for Rent of All Mall Shops
CREATE FUNCTION fn_CalculateYearlyRentEscalation
(
    @Year INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT ShopID, RentAmount, RentAmount * 1.10 AS RentWithEscalation
    FROM Leases
    WHERE YEAR(StartDate) <= @Year
      AND YEAR(EndDate) >= @Year
);
go 
SELECT * 
FROM dbo.fn_CalculateYearlyRentEscalation(2024);

go

--Product Availability View
CREATE VIEW vw_ProductAvailability AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Description,
    p.Price,
    p.QuantityInStock,
    p.ReorderQuantityLevel,
    s.ShopID,
    s.ShopName
FROM Products p
JOIN Shops s ON p.ShopID = s.ShopID
WHERE p.QuantityInStock > 0;
go
SELECT * FROM vw_ProductAvailability;
go
--Product Purchase History View
CREATE VIEW vw_ProductPurchaseHistory AS
SELECT 
    p.ProductID,
    p.ProductName,
    s.ShopID,
    s.ShopName,
    c.CustomerID,
    c.Name AS CustomerName,
    sa.SalesQuantity,
    sa.SalesUnitPrice,
    sa.DateOfSales
FROM Sales sa
JOIN Products p ON sa.ProductID = p.ProductID
JOIN Shops s ON sa.ShopID = s.ShopID
JOIN Customers c ON sa.CustomerID = c.CustomerID;
go


SELECT * FROM vw_ProductPurchaseHistory;
go
--Employee Information View
CREATE VIEW vw_EmployeeInformation AS
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.DateOfBirth,
    e.Age,
    e.Role,
    e.ContactNumber,
    'Shop Employee' AS EmployeeType,
    s.ShopName
FROM ShopEmployees e
JOIN Shops s ON e.ShopID = s.ShopID
UNION ALL
SELECT 
    m.EmployeeID,
    m.EmployeeName,
    m.DateOfBirth,
    m.Age,
    m.Role,
    m.ContactNumber,
    'Mall Employee' AS EmployeeType,
    NULL AS ShopName
FROM MallEmployees m;
go
SELECT * FROM vw_EmployeeInformation;
go

--Minimum Rent Amount Validation
CREATE PROCEDURE CheckMinimumRentAmount
    @ShopID INT,
    @PaidRentAmount DECIMAL(10, 2)
AS
BEGIN
    DECLARE @MinRentAmount DECIMAL(10, 2);

    -- Get the minimum rent amount (assuming RentAmount in Leases table is monthly rent)
    SELECT @MinRentAmount = RentAmount
    FROM Leases
    WHERE ShopID = @ShopID;

    -- Check if the paid rent is less than the minimum rent
    IF @PaidRentAmount < @MinRentAmount
    BEGIN
        PRINT 'Rent payment is less than the minimum monthly rent amount.';
    END
    ELSE
    BEGIN
        PRINT 'Rent payment is valid.';
    END
END;
go

-- Insert a shop lease with a minimum rent amount (example: 1000)
INSERT INTO Leases ( ShopID, LeaseDuration, LeaseOwner, StartDate, EndDate, RentAmount, SecurityDeposit, PaymentFrequency, LeaseType, RenewalOptions)
VALUES ( 1, 12, 'John Doe', '2024-01-01', '2025-01-01', 1000.00, 500.00, 'Monthly', 'Standard', 'Yes');
-- Test: Check rent validation for shop 101 with a paid rent of 800 (less than the minimum rent of 1000)
EXEC CheckMinimumRentAmount @ShopID = 1, @PaidRentAmount = 800;

--No Withdrawal on Zero Balance
CREATE PROCEDURE CheckWithdrawal
    @AccountID INT,
    @WithdrawalAmount DECIMAL(10, 2)
AS
BEGIN
    DECLARE @CurrentBalance DECIMAL(10, 2);

    -- Get the current balance of the account
    SELECT @CurrentBalance = Balance
    FROM Accounts
    WHERE AccountID = @AccountID;

    -- Check if the withdrawal amount exceeds the available balance
    IF @WithdrawalAmount > @CurrentBalance
    BEGIN
        PRINT 'Withdrawal not possible. Insufficient balance.';
    END
    ELSE
    BEGIN
        -- Proceed with the withdrawal (Assuming update to account balance happens here)
        UPDATE Accounts
        SET Balance = Balance - @WithdrawalAmount
        WHERE AccountID = @AccountID;

        PRINT 'Withdrawal successful.';
    END
END;
go

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(255) NOT NULL,
    Balance DECIMAL(10, 2) NOT NULL
);
go
-- Insert a test account with zero balance
INSERT INTO Accounts (AccountID, AccountHolder, Balance)
VALUES (1, 'John Doe', 0.00);
go
-- Test: Attempt withdrawal of 500 from account with zero balance
EXEC CheckWithdrawal @AccountID = 1, @WithdrawalAmount = 500;
go

--Shop Owner Qualification for Maintenance
CREATE TRIGGER trg_PreventMaintenanceForNonPayingShops
ON Maintenance
AFTER INSERT
AS
BEGIN
    DECLARE @ShopID INT, @RentDue DECIMAL(10, 2);

    -- Get the shop ID from the inserted maintenance request
    SELECT @ShopID = ShopID FROM INSERTED;

    -- Check if the shop owner is behind on rent
    SELECT @RentDue = RentAmount
    FROM Leases
    WHERE ShopID = @ShopID;

    IF @RentDue > 0 -- This implies the shop is behind on rent
    BEGIN
        -- Prevent the insertion into the maintenance table
        RAISERROR('Shop is behind on rent and is not eligible for maintenance work.', 16, 1);
        ROLLBACK;
    END
END;
go
-- Insert a lease for shop 101 with overdue rent
UPDATE Leases
SET RentAmount = 500.00  -- Assuming the shop is behind on paying rent
WHERE ShopID = 1;

-- Test: Attempt to insert a maintenance request for shop 1 with overdue rent
INSERT INTO Maintenance ( ShopID, MaintenanceStatus, CostEstimate, ActualCost, PriorityOfJob, EmployeeID)
VALUES (1, 'Pending', 200.00, 150.00, 'High', 1);

select * from MallEmployees

--Lease Expiration Warning
CREATE PROCEDURE CheckLeaseExpiration
    @ShopID INT
AS
BEGIN
    DECLARE @EndDate DATE, @CurrentDate DATE;

    -- Get the lease end date
    SELECT @EndDate = EndDate
    FROM Leases
    WHERE ShopID = @ShopID;

    SET @CurrentDate = GETDATE();

    -- Check if the lease is within 3 months of expiration
    IF DATEDIFF(MONTH, @CurrentDate, @EndDate) <= 3
    BEGIN
        PRINT 'Your lease is almost finished. 3 months to lease expiration.';
    END
    ELSE
    BEGIN
        PRINT 'Your lease is not near expiration.';
    END
END;
go
-- Insert a lease for shop 101 with expiration in 2 months
UPDATE Leases
SET EndDate = DATEADD(MONTH, 2, GETDATE())
WHERE ShopID = 1;
-- Test: Check lease expiration warning for shop 101
EXEC CheckLeaseExpiration @ShopID = 1;

--Ensure that Customers and Employees are not under 18 years of age
-- Add constraint to Customers table to ensure they are 18 or older
ALTER TABLE Customers
ADD CONSTRAINT chk_Age_Customers CHECK (Age >= 18);

-- Add constraint to Employees table to ensure they are 18 or older
ALTER TABLE ShopEmployees
ADD CONSTRAINT chk_Age_Employees CHECK (Age >= 18);

-- Ensure that phone numbers for shop employees are 8 digits
ALTER TABLE ShopEmployees
ADD CONSTRAINT chk_Phone_ShopEmployees CHECK (LEN(ContactNumber) = 8 AND ContactNumber LIKE '[0-9]%');

-- Ensure that phone numbers for mall employees are 8 digits
ALTER TABLE MallEmployees
ADD CONSTRAINT chk_Phone_MallEmployees CHECK (LEN(ContactNumber) = 8 AND ContactNumber LIKE '[0-9]%');


-- Modify Products table to ensure the Price column is NOT NULL
ALTER TABLE Products
ALTER COLUMN Price DECIMAL(10, 2) NOT NULL;

--Listing all the shops in the mall:
SELECT ShopID, ShopName, ShopNumber, BusinessType, CoverageArea, Location
FROM Shops;

--Listing all the employees in a specific shop:
SELECT SE.EmployeeName, SE.Role, SE.ContactNumber
FROM ShopEmployees SE
WHERE SE.ShopID = 1;

-- Listing sales data for each shop in the mall (daily or monthly):
SELECT S.ShopID, S.ShopName, SUM(SA.SalesQuantity) AS TotalSalesQuantity, SUM(SA.SalesUnitPrice * SA.SalesQuantity) AS TotalSalesAmount
FROM Sales SA
JOIN Shops S ON SA.ShopID = S.ShopID
WHERE SA.DateOfSales = '2024-11-01'  -- Modify the date as needed
GROUP BY S.ShopID, S.ShopName;
--WHERE YEAR(SA.DateOfSales) = 2024 AND MONTH(SA.DateOfSales) = 11;

--Display the maintenance work being done or pending on each shop in the mall and the employee assigned to handle the maintenance work
SELECT S.ShopID, S.ShopName, M.MaintenanceStatus, M.PriorityOfJob, M.EmployeeID, ME.EmployeeName
FROM Maintenance M
JOIN Shops S ON M.ShopID = S.ShopID
JOIN MallEmployees ME ON M.EmployeeID = ME.EmployeeID
WHERE M.MaintenanceStatus IN ('Pending', 'Completed');


--Calculate escalation for the shop owners after a year of leasing the property:
SELECT L.ShopID, S.ShopName, L.LeaseOwner, L.RentAmount, 
       L.RentAmount * 1.05 AS EscalatedRentAmount  -- 5% escalation
FROM Leases L
JOIN Shops S ON L.ShopID = S.ShopID
WHERE DATEDIFF(YEAR, L.StartDate, GETDATE()) >= 1;  -- After 1 year

-- List security incidents in the mall (daily, weekly, or monthly):
SELECT SI.IncidentID, SI.DateAndTime, SI.Location, SI.Status, SI.ActionTaken, ME.EmployeeName
FROM SecurityIncident SI
JOIN MallEmployees ME ON SI.EmployeeID = ME.EmployeeID
WHERE CONVERT(DATE, SI.DateAndTime) = '2024-11-01';  -- Modify date as needed




