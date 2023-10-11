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



