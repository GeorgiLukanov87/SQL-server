
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


--04. Employee Departments


SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS [DepartmentName]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE Salary > 15000
ORDER BY d.DepartmentID


--05. Employees Without Projects


SELECT TOP(3) e.EmployeeID,e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID


--06. Employees Hired After


SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptName]
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE (d.[Name] = 'Sales' OR d.[Name] = 'Finance') 
AND (HireDate > '1999.01.01')
ORDER BY HireDate ASC


--07. Employees With Project


SELECT TOP(5) e.EmployeeID,e.FirstName,p.[Name] AS [ProjectName] FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE (p.StartDate > '2002.08.13') AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC


--08. Employee 24


SELECT e.EmployeeID, e.FirstName,
	CASE
		WHEN DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS [PorjectName]
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24


--09. Employee Manager


SELECT 
	a1.EmployeeID,
	a1.FirstName,a2.ManagerID,
	a2.FirstName AS [ManagerName] 
	FROM Employees AS a1
LEFT JOIN Employees AS a2 ON a1.ManagerID = a2.EmployeeID
WHERE a2.ManagerID IN (3, 7)
ORDER BY a1.EmployeeID


--10. Employees Summary


SELECT TOP(50) e1.EmployeeID,
	CONCAT(e1.FirstName, ' ', e1.LastName) AS [EmployeeName],
	CONCAT(e2.firstName, ' ', e2.LastName) AS [ManagerName],
	d.[Name] AS [DepartmentName]
FROM Employees AS e1
LEFT JOIN Employees AS e2 ON e1.ManagerID = e2.EmployeeID
JOIN Departments AS d ON e1.DepartmentID = d.DepartmentID
ORDER BY e1.EmployeeID


--11. Min Average Salary

SELECT MIN([AverageSalary]) AS [MinAverageSalary] FROM(SELECT DepartmentID, AVG(Salary) AS [AverageSalary] 
FROM Employees
GROUP BY DepartmentID) AS [MinAvgSalaryQuery]


--12. Highest Peaks in Bulgaria


SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation FROM Countries AS c
JOIN  MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
JOIN Mountains AS m ON m.Id = mc.MountainId
JOIN Peaks AS p ON p.MountainId = mc.MountainId
WHERE p.Elevation > 2835 AND c.CountryName = 'Bulgaria'
ORDER BY p.Elevation DESC


--13. Count Mountain Ranges

SELECT CountryCode, COUNT(MountainId) AS [MountainRanges] FROM MountainsCountries AS c
WHERE c.CountryCode = 'BG' OR c.CountryCode = 'RU' OR c.CountryCode = 'US'
GROUP BY c.CountryCode
