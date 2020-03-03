CREATE DATABASE Personnel
ON
(
	NAME = 'Personnel',
	FILENAME = 'D:\MSSQL15.MSSQLSERVERDEV\MSSQL\MyData\Personnel.mdf',
	SIZE = 10 MB,
	MAXSIZE = 50 MB,
	FILEGROWTH = 10%
)
COLLATE Cyrillic_General_CI_AS

USE Personnel


CREATE TABLE Department
(
	ID int not null IDENTITY PRIMARY KEY,
	[Name] nvarchar(20) not null UNIQUE
)
WITH (DATA_COMPRESSION = ROW);


CREATE TABLE Position
(
	ID int not null IDENTITY PRIMARY KEY,
	DepartmentID int null, --ALTER CONSTRAINT 32-34
	[Name] nvarchar(20) UNIQUE,
	Salary money not null DEFAULT 1000,
)
WITH (DATA_COMPRESSION = ROW);

ALTER TABLE Position
ADD CONSTRAINT FK_DELITE 
FOREIGN KEY (DepartmentID) REFERENCES Department(ID) ON DELETE SET NULL



CREATE TABLE Employeers
(
	ID int not null IDENTITY PRIMARY KEY,
	DepartmentID int null FOREIGN KEY REFERENCES  Department(ID) ON DELETE SET NULL,
	PositionID int null FOREIGN KEY REFERENCES  Position(ID) ON DELETE SET NULL,
	FName nvarchar(20) not null,
	LName nvarchar(20) not null,
	Phone nvarchar(20) not null UNIQUE CHECK ( Phone LIKE '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
)
WITH (DATA_COMPRESSION = ROW);



DROP TABLE Employeers
DROP TABLE Position
DROP TABLE Department


--Fill all tables

INSERT Department
VALUES 
('Developers'), 
('Managers')

SELECT * FROM Department

INSERT Position
VALUES
(1, 'Junior .Net', 750),
(1, 'Middle .Net', 2500),
(1, 'Senior .Net', 4000),
(2, 'Office manager', 700),
(2, 'Product manager', 1000)

SELECT * FROM Position

INSERT Employeers VALUES(1, 4, 'Pavlo', 'Bauman', '(063)-123-45-67')

SELECT * FROM Employeers

USE master
DROP DATABASE Personnel