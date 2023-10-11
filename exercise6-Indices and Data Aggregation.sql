USE Gringotts

--01. Records’ Count
SELECT COUNT(*) AS [Count] FROM WizzardDeposits 

--02. Longest Magic Wand

SELECT MAX(MagicWandSize) AS [LongestMagicWand] FROM WizzardDeposits

--03. Longest Magic Wand per Deposit Groups
SELECT * FROM WizzardDeposits

SELECT DepositGroup, MAX(MagicWandSize) AS [LongestMagicWand] 
FROM WizzardDeposits
GROUP BY DepositGroup

--04. Smallest Deposit Group per Magic Wand Size 

SELECT * FROM WizzardDeposits

SELECT TOP(2) DepositGroup FROM 
			(
			 SELECT DepositGroup, AVG(MagicWandSize) AS [AverageWandSize] FROM WizzardDeposits
			 GROUP BY DepositGroup
			) AS [AverageWandSizeQuery]
ORDER BY AverageWandSize

--05. Deposits Sum

SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
	FROM WizzardDeposits
GROUP BY DepositGroup

--06. Deposits Sum for Ollivander Family

SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--07. Deposits Filter

SELECT * FROM (
				SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum] 
					FROM WizzardDeposits
					WHERE MagicWandCreator = 'Ollivander family'
				GROUP BY DepositGroup
) AS [TotalSumQuery]
WHERE TotalSum < 150000
ORDER BY TotalSum DESC

--08. Deposit Charge

SELECT DepositGroup,MagicWandCreator, MIN(DepositCharge) FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator


--09. Age Groups
SELECT * FROM WizzardDeposits

SELECT AgeGroup, COUNT(*) AS [WizzardCount] FROM (
SELECT 
	CASE
		WHEN Age <= 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]'
	END AS [AgeGroup],*
FROM WizzardDeposits) AS [AgeGroupQuery]
GROUP BY AgeGroup

--10. First Letter

SELECT DISTINCT SUBSTRING(FirstName,1,1) AS [FirstLetter] FROM WizzardDeposits
GROUP BY FirstName

--11. Average Interest

SELECT 
		DepositGroup,
		isDepositExpired,
		AVG(DepositInterest) AS [AverageInterest] 
FROM WizzardDeposits
WHERE DepositStartDate > '01-01-1985'
GROUP BY DepositGroup,isDepositExpired
ORDER BY DepositGroup DESC,isDepositExpired

--12. *Rich Wizard, Poor Wizard

SELECT SUM([DIFFERENCE]) AS [SumDifference] FROM
	(
		SELECT 
			FirstName AS [Host Wizard],
			DepositAmount AS [Host Wizard Deposit],
			LEAD(FirstName) OVER(ORDER BY Id ASC) as [Guest Wizard],
			LEAD(DepositAmount) OVER(ORDER BY Id ASC) as [Guest Wizard Deposit],
			DepositAmount - LEAD(DepositAmount) OVER(ORDER BY Id ASC) AS [Difference]
		FROM WizzardDeposits
	) AS [LeadingQuery]
WHERE [Guest Wizard] IS NOT NULL


-- 13. Departments Total Salaries

USE SoftUni

SELECT DepartmentID, SUM(salary) AS [TotalSalary] FROM Employees AS e
GROUP BY DepartmentID
ORDER BY DepartmentID

--14. Employees Minimum Salaries

SELECT
	DepartmentID,
	MIN(Salary) AS [MinimumSalary] 
FROM Employees
WHERE DepartmentID IN (2,5,7) AND HireDate > '01-01-2000'
GROUP BY DepartmentID

--15. Employees Average Salaries

SELECT * INTO NewTable FROM Employees
WHERE Salary > 30000

DELETE FROM NewTable WHERE ManagerID = 42

UPDATE NewTable SET Salary += 5000 WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS [AverageSalary] FROM NewTable
GROUP BY DepartmentID

--16. Employees Maximum Salaries

SELECT * FROM (
SELECT DepartmentID, MAX(salary) AS [MaxSalary] FROM Employees
GROUP BY DepartmentID) AS [MaxSalaryQuery]
WHERE MaxSalary NOT BETWEEN 30000 AND 70000


--17. Employees Count Salaries

SELECT COUNT(salary) AS [Count] FROM Employees
WHERE ManagerID IS NULL


--18. *3rd Highest Salary 

SELECT DepartmentID, Salary AS [ThirdHighestSalary] FROM (
				SELECT DepartmentID,Salary ,
					DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS [SalaryRank]
				FROM Employees
				GROUP BY DepartmentID, Salary
) AS [SalaryQuery]
WHERE SalaryRank = 3

--19. **Salary Challenge

SELECT TOP(10) e1.FirstName,
		e1.LastName,
		e1.DepartmentID
FROM Employees as e1
WHERE e1.Salary > (
					SELECT AVG(Salary) AS [AverageSalary]
					FROM Employees AS eAvgSalary
					WHERE eAvgSalary.DepartmentID = e1.DepartmentID
					GROUP BY DepartmentID
				  ) 
ORDER BY DepartmentID
