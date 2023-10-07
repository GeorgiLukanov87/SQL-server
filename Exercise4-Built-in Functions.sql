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

SELECT EmployeeID,FirstName,LastName,Salary ,DENSE_RANK() OVER   
    (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY Salary DESC
