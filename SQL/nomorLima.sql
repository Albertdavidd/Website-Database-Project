--rafif no.5

--case no.1
SELECT CustomerName, UPPER(CustomerGender) AS UppercaseCustomerGender, [Total Transaction] = Quantity
FROM Customer c
JOIN TransactionDetail td ON td.Quantity = c.Quantity
WHERE CustomerName LIKE 'Mrs.% %'and CustomerGender='Female'

--case no.2
SELECT CarId, CarName, CarBrandName, CarPrice, [Total of Car That Has Been Sold ] = Quantity
FROM Car c
JOIN CarBrand cb ON cb.CarBrandName = c.CarBrandName
JOIN

--case no.3
SELECT REPLACE(StaffId, 'ST[0-9][0-9][0-9]', 'ST', 'Staff ') , StaffName, [Total Transaction Handled] = , [Maximum Quantity in One Transaction] = Quantity
FROM Staff s
JOIN TransactionDetail td ON td.Quantity = s.Quantity
WHERE StaffName LIKE 'Mrs.% %' and [Total Transaction Handled]>1
ORDER BY [Maximum Quantity in One Transaction] DESC

--case no.4
SELECT CustomerName, CustomerGender, [Total Purchase]=, [Total of Car That Has Been Purchased] =
FROM Customer c

WHERE CustomerEmail LIKE '%@gmail.com'AND [Total of Car That Has Been Purchased] > 2

--case no.5
SELECT REPLACE(VendorName, 'PT', 'PT', 'Perseroam Terbatas'), VendorPhoneNumber, PurchaseID

--case no.6

--case no.7

--case no.8

--case no.9
CREATE VIEW Vendor_Transaction_Handled_and_Minimum_View AS
SELECT VendorID, VendorName, [Total Transaction Handled] = , [Minimum Purchases in One Transaction] = 
FROM Class c 
JOIN Instructor i ON i.InstructorID = c.InstructorID
JOIN Course cr ON c.CourseID = cr.CourseID
WHERE Course_Name = 'Sistem Informasi'


--case no.10

Create View Staff_Total_Purchase_and_Max_Car_Purchase_View AS 

Select Distinct
	s.StaffID,
	s.StaffName,
	[StaffEmail] = upper(s.StaffEmail),
	[Total Purchase] = count(p.PurchaseID),
	[Maxiumum] = pd.Quantity
from
	Staff s
	join PurchaseHeader p
	on s.StaffID = p.StaffID
	join PurchaseDetail pd
	on p.PurchaseID = pd.PurchaseID,
	(
		select
			ph.PurchaseID,
			ph.StaffID,
			[Max] = max(Quantity)
		from
			PurchaseDetail pd
			join PurchaseHeader ph
			on pd.PurchaseID = ph.PurchaseID
		group by
		ph.PurchaseID,
		StaffID
	) as a
where
	s.StaffEmail like '%@yahoo.com'
	and
	s.StaffGender='Female'
	and
	pd.Quantity= (a.[Max])
group by 
	s.StaffID,
	s.StaffName,
	s.StaffEmail,
	pd.Quantity

	
select *
from
	PurchaseHeader

select*
from 
	Staff