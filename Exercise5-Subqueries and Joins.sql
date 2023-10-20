
-- 01. Employee Address

SELECT TOP(5) e.EmployeeID AS [EmoployeeId],
	   e.JobTitle,
	   e.AddressID,
	   adr.AddressText 

FROM Employees as e
JOIN Addresses as adr ON e.AddressID = adr.AddressID
ORDER BY adr.AddressID

-- 02. Addresses with Towns

SELECT TOP(50) e.FirstName, e.LastName, t.Name , a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName

--03. Sales Employees

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS [DepartmentName]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID

SELECT * FROM Departments