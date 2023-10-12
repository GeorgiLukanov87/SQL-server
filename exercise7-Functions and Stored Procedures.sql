--01. Employees with Salary Above 35000

CREATE OR ALTER PROC usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

--02. Employees with Salary Above Number

CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber @salaryLimit DECIMAL(18,4)
AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE Salary >= @salaryLimit
END

EXEC usp_GetEmployeesSalaryAboveNumber 2500

--03. Town Names Starting With




