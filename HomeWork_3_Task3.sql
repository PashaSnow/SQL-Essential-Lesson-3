CREATE DATABASE StorageDB
ON
(
	NAME = 'StorageDB',
	FILENAME = 'D:\MSSQL15.MSSQLSERVERDEV\MSSQL\MyData\StorageDB.mdf',
	SIZE = 10 MB,
	MAXSIZE = 30 MB,
	FILEGROWTH = 15%
)
COLLATE Cyrillic_General_CI_AS

USE StorageDB

CREATE TABLE Manager
(
	ManagerID int IDENTITY(1,1) not null PRIMARY KEY,
	Name nvarchar(20) not null,
	Phone nvarchar(15) not null CHECK (Phone LIKE '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
)
WITH (DATA_COMPRESSION = ROW)

CREATE TABLE Customers
(
	CustomerID int IDENTITY(1,1) not null PRIMARY KEY,
	Name nvarchar(20) not null,
	Phone nvarchar(15) not null CHECK (Phone LIKE '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') 
)
WITH (DATA_COMPRESSION = ROW)

CREATE TABLE Orders
(
	OrderID int IDENTITY(1,1) not null PRIMARY KEY,
	ManagerID int  null FOREIGN KEY REFERENCES Manager(ManagerID),
	CustomerID int  null FOREIGN KEY REFERENCES Customers(CustomerID),

	OrderDate date not null DEFAULT GetDate(),
	ShippingDate date not null DEFAULT DateADD(DAY, 5, GetDate())
)
WITH (DATA_COMPRESSION = ROW)

CREATE TABLE Products
(
	ProductID int IDENTITY(1,1) not null PRIMARY KEY,
	Description nvarchar(100) not null DEFAULT 'Backhoff - Basic CPU module',
	Article nvarchar(100) not null DEFAULT 'CX2072-0175',
	UnitPrice money not null DEFAULT 2500
)
WITH (DATA_COMPRESSION = ROW)

CREATE TABLE OrderDetail
(
	OrderID int not null FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
	ProductID int not null FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
	PRIMARY KEY (OrderID, ProductID),

	Qty int not null DEFAULT 1
)
WITH (DATA_COMPRESSION = ROW)

DROP TABLE Customers
DROP TABLE Manager
DROP TABLE Products
DROP TABLE Orders
DROP TABLE OrderDetail