CREATE VIEW Staff_Total_Purchase_and_Max_Car_Purchase_View AS
GO
SELECT 
	s.StaffID,
	s.StaffName,
	[Staff Email] = Upper(s.StaffEmail),
	[Total Purchase] = count(ph.PurchaseID),
    [Maximum Car Purchased] = max(pd.Quantity)
FROM 
	Staff s 
	JOIN PurchaseHeader ph
	ON s.StaffID = ph.StaffID
	join PurchaseDetail pd
	on ph.PurchaseID = pd.PurchaseID
WHERE 
	s.StaffEmail LIKE '%@yahoo.com' 
	and 
	s.StaffGender = 'Female'
Group by
	s.StaffID,
	s.StaffName,
	s.StaffEmail

Drop view Staff_Total_Purchase_and_Max_Car_Purchase_View 

--no 9

Create view Vendor_Transaction_Handled_and_Minimum_View AS

GO
Select
	[Vendor ID] = replace (v.VendorID, 'VE', 'Vendor '),
	v.VendorName,
	[Total Transaction Handled] = count(ph.VendorID),
	[Minimum Purchase in One Transaction] = min(pd.Quantity)
From
	Vendor v
	join PurchaseHeader ph
	on v.VendorID = ph.VendorID
	join PurchaseDetail pd
	on ph.PurchaseID = pd.PurchaseID
Where
	month (ph.PurchaseDate) = 5
	and
	v.VendorName like '%a%'
Group by
	v.VendorID,
	v.VendorName
	

--no 6
SELECT
    UPPER(CONCAT(cb.CarBrandName, ' ', c.CarName)) AS [Name],
    CONCAT('Rp. ', convert(int,c.CarPrice)) AS Price,
    CONCAT(Stock, ' Stock(s)') AS Stock
FROM
    CarBrand cb
    JOIN Car c 
	ON cb.CarBrandID = c.CarBrandID,
	(
		select
			[AVG] = avg(c.CarPrice)
		from
			Car c
		where
			c.CarName like '%e%'
	) as a
WHERE
    c.CarPrice > a.[AVG]
GROUP BY
    CarBrandName, 
	CarName, 
	CarPrice, 
	Stock

--no 8
SELECT 
	SUBSTRING(s.StaffName, 1, CHARINDEX(' ',s.StaffName) - 1) AS [Staff Firstname],     
	SUBSTRING(s.StaffName,
		CHARINDEX(' ', s.StaffName) + 1,
		LEN(s.StaffName) - CHARINDEX(' ', s.StaffName)) AS [Staff Lastname],
		[Total of Car That Has Been Sold] = sum(td.Quantity)
FROM 
	Staff s
	JOIN TransactionHeader th
	ON s.StaffID = th.StaffID
	join TransactionDetail td
	on th.TransactionID = td.TransactionID,
	(
		select
			[AVG] = AVG(td.Quantity)
		from
			TransactionDetail td
	) as a
WHERE 
	StaffName LIKE '% %' 
Group By
	s.StaffName,
	[AVG]
Having
	sum(td.Quantity) > a.[AVG]



SELECT
    SUBSTRING(s.StaffName,0, CHARINDEX(' ',s.StaffName,0)) AS 'First Name',
    SUBSTRING(s.StaffName, CHARINDEX(' ', s.StaffName) + 1, LEN(s.StaffName) - CHARINDEX(' ', s.StaffName)) AS 'Last name',
    SUM(trd.Quantity) AS 'Cars Sold'
FROM Staffs s
    JOIN Transactions tr ON tr.StaffId = s.StaffId
    JOIN TransactionDetails trd on trd.TransactionId = tr.TransactionId
WHERE 
    s.StaffName LIKE '% %'
GROUP BY s.StaffName

HAVING 
    SUM(trd.Quantity) > (
        SELECT
    AVG(trd.Quantity)
FROM TransactionDetails trd 
    )


no 7
GO
select
    [Car ID] = right(c.CarID, 3),
    c.CarName,
    UPPER(b.CarBrandName) as [Brand],
    CONCAT('Rp. ', CarPrice) as Price,
    SUM(alias.Quantity) as [Total of Car That Has Been Sold]
	[Total of Car That Has Been Sold more than average of the sum] = sum(a.
from
    Car c,
    (select CarBrandID, CarBrandName from CarBrand) as b,
    (select 
        CarID, Quantity 
    from 
        TransactionHeader th join TransactionDetail td on th.TransactionID = td.TransactionID) as alias
where
    c.CarBrandID = b.CarBrandID and
    c.CarID = alias.CarID
group by 
    c.CarID, CarName, CarBrandName, CarPrice



GO
select
    [Car ID] = right(c.CarID, 3),
    c.CarName,
    UPPER(cb.CarBrandName) as [Brand],
    CONCAT('Rp. ', CarPrice) as Price,
    SUM(td.Quantity) as [Total of Car That Has Been Sold],
	[Total of Car That Has Been Sold more than average of the sum] = sum(a.[AVG])
from
    Car c 
	join CarBrand cb
	on c.CarBrandID = cb.CarBrandID
	join TransactionDetail td
	on c.CarID = td.CarID,
	(
		select
			[AVG] = avg(td.Quantity)
		from
			TransactionDetail td
	) as a
where
    c.CarPrice > 200000000
	and
	c.CarName like '%o%'
group by 
    c.CarID, 
	c.CarName, 
	cb.CarBrandName, 
	c.CarPrice

--- no 3
SELECT
    StaffId = REPLACE(s.StaffID, 'ST', 'Staff '),
    s.StaffName,
    [Total Transaction Handled] = COUNT(th.StaffID),
    [Maximum Quantity in One Transaction] = MAX(td.CarID)
FROM
    Staff s
    JOIN TransactionHeader th ON th.StaffID = s.StaffID
    JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
WHERE
    s.StaffName LIKE '% %' 
    AND MONTH(th.TransactionDate) = 4
GROUP BY
    s.StaffID,
    s.StaffName
HAVING
    COUNT(th.StaffID) > 1
ORDER BY
    COUNT(td.CarID) DESC