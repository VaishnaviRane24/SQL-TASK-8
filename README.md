# SQL-TASK-8


# Task 8 – Stored Procedures and Functions

## Overview
* This task focuses on creating **stored procedures** and **functions** in MySQL to modularize SQL logic. 
* It demonstrates how to encapsulate business rules for updating employee salaries and calculating bonuses.

## Tools Used

* **MySQL Workbench**
* SQL (Structured Query Language)

## Database Structure

### Table: Employees

* `EmployeeID` (PK, Auto Increment)
* `FirstName`
* `LastName`
* `DepartmentID`
* `Salary`
* `Status` (`Active` / `Inactive`)

Sample employees were inserted with different departments, salaries, and statuses.

## Stored Procedure

### `UpdateEmployeeSalary`

**Parameters:**

* `p_DepartmentID` (IN) → Department to filter employees
* `p_SalaryIncreasePercent` (IN) → Percentage increase in salary
* `p_EmployeeUpdated` (OUT) → Number of employees updated

**Logic:**

* Validates inputs (non-null department, positive salary increase).
* Updates salaries for **active employees** in the given department.
* Returns the number of updated employees using `ROW_COUNT()`.

**Usage:**

```sql
SET @UpdateCount = 0;
CALL UpdateEmployeeSalary(1, 10.00, @UpdateCount);
SELECT @UpdateCount AS EmployeeUpdated;
```

---

## Function

### `CalculateEmployeeBonus`

**Parameters:**

* `p_Salary` → Employee salary

**Returns:**

* Bonus amount based on salary:

  * ≥ 60,000 → 10% bonus
  * ≥ 30,000 → 5% bonus
  * Otherwise → 2% bonus

**Usage:**

```sql
SELECT
    EmployeeID,
    FirstName,
    Salary,
    CalculateEmployeeBonus(Salary) AS Bonus
FROM Employees;
```

---

## Key Learnings

* Difference between **procedures (reusable blocks with IN/OUT params)** and **functions (return single values)**.
* Use of **DELIMITER** to define blocks.
* Error handling with `SIGNAL`.
* Applying conditional logic (`IF…ELSEIF…ELSE`) inside functions.
* Modular SQL design for better maintainability.

## Files Included

* `SQL-TASK-8.sql` – SQL script with table creation, procedure, function, and test queries.
* `README.md`: This file, explaining the task and approach
---
