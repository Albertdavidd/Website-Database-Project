CREATE DATABASE cArDorm
GO
USE cArDorm
GO


create table [Staff] (
	StaffID varchar(20) not null Primary Key
		check (StaffID like 'ST[0-9][0-9][0-9]'),
	StaffName varchar(50) not null,
	StaffGender varchar(10) not null
		check (StaffGender in ('Male', 'Female')),
	StaffEmail varchar (50) not null
		check (StaffEmail in ('%@gmail.com', '%@yahoo.com')),
	StaffPhone int not null,
	StaffAddress varchar (100) not null,
	Salary int 
	check (salary between 5000000 and 10000000)
)
	
create table [Customer](
	CustomerID varchar (20) Primary Key not null
		check (CustomerID like 'CU[0-9][0-9][0-9]'),
	CustomerName varchar(20) not null 
		check (LEN(CustomerName) > 3),
	CustomerGender varchar(10) not null
		check (CustomerGender in ('Male', 'Female')),
	CustomerEmail varchar (50) not null
		check (CustomerEmail in ('%@gmail.com', '%@yahoo.com')),
	CustomerPhone int not null,
	CustomerAddress varchar (100) not null
)

--CarBrand
--CarBrandID varchar PK
--CarBrandName

create table [CarBrand](
	CarBrandID varchar (20) Primary Key not null
		check (CarBrandID like 'CB[0-9][0-9][0-9]'),
	CarBrandName varchar (50) not null
)

--Car
--CarID varchar PK
--CarName 
--CarPrice
--Stock
--CarBrandID fk

create table [Car](
	CarID varchar(20) Primary Key not null
		check (CarID like 'CA[0-9][0-9][0-9]'),
	CarName varchar (20) not null,
	CarPrice int not null,
	Stock int not null,
	CarBrandID varchar (20) foreign key references CarBrand(CarBrandID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
)

create table [Vendor] (
	VendorID varchar (20) Primary Key not null
		check (VendorID like 'VE[0-9][0-9][0-9]'),
	VendorName varchar (20) not null
)

create table [Transaction] (
	TransactionID varchar (20) primary key not null
		check (TransactionID like 'TR[0-9][0-9][0-9]'),
	StaffID varchar (20) foreign key references Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID varchar (20) foreign key references Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate Date not null
		check (TransactionDate <= GETDATE()),
	CarID varchar (20) foreign key references Car(CarID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
)

create table [Purchase](
	PurchaseID varchar (20) primary key not null
		check (PurchaseID like 'PU[0-9][0-9][0-9]'),
	StaffID varchar (20) foreign key references Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	VendorID varchar (20) foreign key references Vendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseDate Date not null
		check (PurchaseDate <= GETDATE()),
	CarID varchar (20) foreign key references Car(CarID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	Quantity int not null
)
