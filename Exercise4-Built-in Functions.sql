USE SoftUni

--01. Find Names of All Employees by First Name

SELECT FirstName,LastName FROM Employees
	WHERE FirstName LIKE 'Sa%'


--02. Find Names of All Employees by Last Name

SELECT FirstName,LastName FROM Employees
	WHERE LastName LIKE '%ei%'

--03. Find First Names of All Employees

SELECT FirstName FROM Employees
	WHERE DepartmentID IN (3,10) and YEAR(HireDate) between 1995 and 2005

--04. Find All Employees Except Engineers

SELECT FirstName,LastName FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%'

--05. Find Towns with Name Length

SELECT [Name] FROM Towns
	WHERE LEN([Name]) IN (5, 6)
	ORDER BY [Name]

--06. Find Towns Starting With

SELECT * FROM Towns
	WHERE [Name] LIKE 'M%' OR [Name] LIKE 'K%' OR [Name] LIKE 'B%' OR [Name] LIKE 'E%'
	ORDER BY [Name]


SELECT * FROM Towns
	WHERE [Name] LIKE '[MKBE]%'


SELECT * FROM Towns
	WHERE SUBSTRING([Name],1,1) IN ('M','K','B','E')

--07. Find Towns Not Starting With

SELECT * FROM Towns
	WHERE [Name] NOT LIKE 'R%' AND [Name] NOT LIKE 'B%' AND [Name] NOT LIKE 'D%'
	ORDER BY [Name]

--08. Create View Employees Hired After 2000 Year

CREATE VIEW [V_EmployeesHiredAfter2000] AS
	SELECT FirstName, LastName 
	FROM Employees
	WHERE YEAR(HireDate) > 2000

SELECT * FROM V_EmployeesHiredAfter2000

--09. Length of Last Name


SELECT FirstName, LastName FROM Employees
	WHERE LEN(LastName) = 5

-- 10. Rank Employees by Salary

SELECT EmployeeID,FirstName,LastName,Salary ,DENSE_RANK() OVER   
    (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY Salary DESC

--11. Find All Employees with Rank 2

SELECT * FROM (SELECT EmployeeID,FirstName,LastName,Salary ,
	DENSE_RANK() 
	OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000) AS [RankTable]
	WHERE [Rank] = 2
	ORDER BY Salary DESC

--12. Countries Holding 'A' 3 or More Times

USE Geography

SELECT CountryName AS [Country Name], IsoCode AS [ISO Code] FROM Countries
	WHERE CountryName LIKE '%a%a%a%'
	ORDER BY IsoCode

--13. Mix of Peak and River Names

SELECT p.PeakName, r.RiverName,LOWER(CONCAT(p.PeakName, SUBSTRING(r.RiverName,2, LEN(r.RiverName)- 1))) AS [Mix] FROM Peaks AS p, Rivers as r
	WHERE RIGHT(p.PeakName, 1 ) = LEFT(r.RiverName,1)
	ORDER BY [Mix]

--14. Games From 2011 and 2012 Year
USE Diablo

SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start] FROM Games
	WHERE YEAR([Start]) IN (2011, 2012)
	ORDER BY [Start], [Name]

--15. User Email Providers

SELECT Username, Email FROM Users


--16. Get Users with IP Address Like Pattern

SELECT Username, IpAddress AS [IP Address] FROM Users
	WHERE IpAddress LIKE '___.1_%._%.___'
	ORDER BY Username