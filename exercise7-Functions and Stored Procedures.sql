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

CREATE OR ALTER PROC usp_GetTownsStartingWith @searchString NVARCHAR(50)
AS
BEGIN
	SELECT [Name] FROM Towns
	WHERE [Name] LIKE @searchString+'%'
END

EXEC usp_GetTownsStartingWith b

--04. Employees from Town
CREATE OR ALTER PROC usp_GetEmployeesFromTown @townName NVARCHAR(50)
AS
BEGIN
	SELECT [FirstName], [LastName] FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
WHERE t.[Name] = @townName
END

EXEC usp_GetEmployeesFromTown 'Sofia'

--05. Salary Level Function

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18, 4))
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @salaryLevel VARCHAR(50);

    IF (@salary < 30000)
        SET @salaryLevel = 'Low';
    ELSE IF (@salary >= 30000 AND @salary <= 50000)
        SET @salaryLevel = 'Average';
    ELSE
        SET @salaryLevel = 'High';

    RETURN @salaryLevel;
END;

SELECT FirstName,LastName,Salary, dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level]
FROM Employees



--06. Employees by Salary Level

CREATE OR ALTER PROC usp_EmployeesBySalaryLevel @levelOfsalary VARCHAR(50)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelOfsalary
END 

EXEC usp_EmployeesBySalaryLevel 'low'
EXEC usp_EmployeesBySalaryLevel 'Average'
EXEC usp_EmployeesBySalaryLevel 'high'

-- 07. Define Function

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(50), @word NVARCHAR(50))
RETURNS BIT
AS
BEGIN
DECLARE @result BIT = 1
DECLARE @cnt INT = 1;

		WHILE @cnt < (LEN(@word) + 1)
		BEGIN
		   IF CHARINDEX(SUBSTRING(@setOfLetters, @cnt , 1), @word) > 0
		   SET @cnt = @cnt + 1;
		   ELSE
		   SET @result = 0
		   RETURN @result
		END;
RETURN @result
END

SELECT 'oistmiahf' AS [SetOfLetter],
'Sofia' AS [Word],
dbo.ufn_IsWordComprised('oistmiahf', 'Sofia') AS [Result]

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves') AS [Result]
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob') AS [Result]
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy') AS [Result]


