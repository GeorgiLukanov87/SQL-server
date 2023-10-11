USE Gringotts

--01. Records� Count
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
