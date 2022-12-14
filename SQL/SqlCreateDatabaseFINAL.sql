CREATE DATABASE cArDorm
GO
USE cArDorm
GO

CREATE TABLE Staff
(
	StaffID CHAR(5) NOT NULL PRIMARY KEY CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(6) NOT NULL CHECK(StaffGender IN ('Male', 'Female')),
	StaffEmail VARCHAR(50) NOT NULL CHECK(StaffEmail LIKE '%@gmail.com' OR StaffEmail LIKE '%@yahoo.com'),
	StaffPhoneNumber VARCHAR(20) NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	Salary MONEY CHECK (Salary BETWEEN 5000000 AND 10000000)
)

CREATE TABLE Customer
(
	CustomerID CHAR(5) NOT NULL PRIMARY KEY CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL CHECK(LEN(CustomerName) > 2),
	CustomerGender VARCHAR(6) NOT NULL CHECK(CustomerGender in ('Male', 'Female')),
	CustomerAddress VARCHAR(100) NOT NULL,
	CustomerPhoneNumber VARCHAR(20) NOT NULL,
	CustomerEmail VARCHAR(50) NOT NULL CHECK(CustomerEmail LIKE '%@gmail.com' OR CustomerEmail LIKE '%@yahoo.com'),
)

CREATE TABLE CarBrand
(
	CarBrandID CHAR(5) PRIMARY KEY NOT NULL CHECK(CarBrandID like 'CB[0-9][0-9][0-9]'),
	CarBrandName VARCHAR(50) NOT NULL
)

CREATE TABLE Car
(
	CarID CHAR(5) NOT NULL PRIMARY KEY CHECK(CarID like 'CA[0-9][0-9][0-9]'),
	CarBrandID CHAR(5) NOT NULL FOREIGN KEY REFERENCES CarBrand(CarBrandID) ON UPDATE CASCADE ON DELETE CASCADE,
	CarName VARCHAR(20) NOT NULL,
	CarPrice MONEY NOT NULL,
	Stock INT NOT NULL
)

CREATE TABLE Vendor
(
	VendorID CHAR(5) NOT NULL PRIMARY KEY CHECK(VendorID like 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(20) NOT NULL,
	VendorPhoneNumber VARCHAR(20) NOT NULL
)

CREATE TABLE TransactionHeader
(
	TransactionID CHAR(5) NOT NULL PRIMARY KEY CHECK(TransactionID like 'TR[0-9][0-9][0-9]'),
	StaffID CHAR(5) NOT NULL FOREIGN KEY REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE,
	CustomerID CHAR(5) NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL CHECK(TransactionDate <= GETDATE())
)

CREATE TABLE TransactionDetail
(
	TransactionID CHAR(5) NOT NULL FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	CarID CHAR(5) FOREIGN KEY REFERENCES Car(CarID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	Quantity INT NOT NULL,
	PRIMARY KEY (TransactionID, CarID)
)

CREATE TABLE PurchaseHeader
(
	PurchaseID CHAR(5) NOT NULL PRIMARY KEY CHECK(PurchaseID like 'PU[0-9][0-9][0-9]'),
	StaffID CHAR(5) NOT NULL FOREIGN KEY REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE,
	VendorID CHAR(5) NOT NULL FOREIGN KEY REFERENCES Vendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE,
	PurchaseDate DATE NOT NULL CHECK(PurchaseDate <= GETDATE())
)

CREATE TABLE PurchaseDetail
(
	PurchaseID CHAR(5) NOT NULL FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE,
	CarID CHAR(5) NOT NULL FOREIGN KEY REFERENCES Car(CarID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL,
	PRIMARY KEY(PurchaseID, CarID)
)
