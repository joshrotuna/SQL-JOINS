-- SalesOrders Database
-- INNER JOINS

-- 01 - List customers and the dates they placed an order
SELECT CustFirstName, CustLastName, OrderDate
FROM customers 
JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID;

-- 02 - Show me customers and employees who share the same last name
SELECT CustLastName, CustFirstName, EmpFirstName, EmpLastName
FROM Customers
JOIN Employees
	ON Customers.CustLastName = Employees.EmpLastName;

-- 03 - Show me customers and employees who live in the same city
SELECT CustFirstName, CustLastName, EmpFirstName, EmpLastName, CustCity, EmpCity 
FROM Customers cust
JOIN Employees emp
	ON cust.CustCity = emp.EmpCity;


-- 04 - Generate a list of employees and the customers for whom they booked an order

SELECT 
	EmpFirstName, 
	EmpLastName, 
	CustFirstName, 
	CustLastName, 
	OrderNumber,
	Customers.CustomerID,
	Orders.CustomerID,
	Orders.EmployeeID,
	Employees.EmployeeID
FROM Customers
JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID
JOIN Employees
	ON Orders.EmployeeID = Employees.EmployeeID ;


-- 05 - Display all orders with the order date, the products in each order, 
-- and the amount owed for each product, in order number sequence
	
SELECT 
	OrderDate, 
	Order_Details.OrderNumber, 
	QuantityOrdered, 
	QuotedPrice,
	QuantityOrdered * QuotedPrice AS AmountOwed,
	Products.ProductNumber,
	ProductName
FROM Orders
JOIN Order_Details 
	ON Orders.OrderNumber = Order_Details.OrderNumber 
Join Products
	ON Order_Details.ProductNumber = Products.ProductNumber;

	

-- 06 - Show me the vendors and the products they supply to us 
-- 		for products that cost less than $100. 
--      Sort by the vendor name then the wholesale price.
SELECT 
	VendName,
	ProductName, 
	Products.ProductNumber, 
	WholesalePrice
FROM Products
JOIN Product_Vendors
	ON Products.ProductNumber = Product_Vendors.ProductNumber 
JOIN Vendors
	ON Product_Vendors.vendorID = Vendors.VendorID 
WHERE Product_Vendors.WholesalePrice < 100
Order BY VendName;


-- 07 - Display customer names who have a sales rep (employees) in the same ZIP Code. Include the employee name.
SELECT CustFirstName, CustLastName, CustZipCode, EmpFirstName, EmpLastName
FROM Customers
JOIN Employees 
	ON Customers.CustZipCode = Employees.EmpZipCode ;



-- LEFT JOINS

-- 08 - Display customers who do NOT have a sales rep (employees) in the same ZIP Code
SELECT CustFirstName, CustLastName, CustZipCode, EmpFirstName, EmpLastName, EmpZipCode 
FROM Customers
LEFT JOIN Employees 
	ON Customers.CustZipCode = Employees.EmpZipCode 
WHERE Employees.EmpZipCode IS NULL;


-- 09 - Are there any products that have never been ordered?
SELECT Order_Details.ProductNumber, ProductName, Order_Details.QuantityOrdered 
FROM Products
LEFT JOIN Order_Details 
	ON Products.ProductNumber = Order_Details
	.ProductNumber 
WHERE Order_Details.ProductNumber IS NULL;


	
	

