DROP DATABASE IF EXISTS employee_management_system;

CREATE DATABASE employee_management_system;
USE employee_management_system;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    Status VARCHAR(50)
);

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, Status) VALUES
('Aarav', 'Roy', 1, 67000, 'Active'),
('Meera', 'Panday', 2, 86000, 'Active'),
('Rohan', 'Kapoor', 1, 60000, 'Inactive'),
('Ananya', 'Khan', 4, 58000, 'Active'),
('Kunal', 'Deshmukh', 2, 35000, 'Inactive'),
('Priya', 'Kadam', 1, 47000, 'Inactive');

-- PROCEDURE TO STORE UpdateEmployeeSalary
DELIMITER //

CREATE PROCEDURE UpdateEmployeeSalary (
	IN p_DepartmentID INT,
    IN p_SalaryIncreasePercent DECIMAL(10,2),
    OUT p_EmployeeUpdated INT
)
BEGIN
	SET p_EmployeeUpdated = 0 ; -- Initialize output parameter
    
    IF p_DepartmentID IS NULL OR p_SalaryIncreasePercent <=0 THEN
		SIGNAL SQLSTATE '35000'
        SET MESSAGE_TEXT = 'Invalide input: DepartmentID cannot be NULL AND SalaryIncreasePercent must be positive.';
	ELSE
			UPDATE Employees
            SET Salary = Salary + (Salary + p_SalaryIncreasePercent / 100)
            WHERE DepartmentID = p_DepartmentID AND Status = 'Active' ;
            
            SELECT ROW_COUNT() INTO p_EmployeeUpdated;
	END IF;
END //

DELIMITER ;

-- Create function : CalculateEmployeeBonus
DELIMITER //

CREATE FUNCTION CalculateEmployeeBonus (
	p_Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE v_Bonus DECIMAL(10,2);
    
    IF p_Salary >= 60000 THEN
		SET v_Bonus = p_Salary * 0.10;
	ELSEIF p_Salary >= 30000 THEN
		SET v_Bonus = p_Salary * 0.05;
	ELSE 
		SET v_Bonus = p_Salary * 0.02;
	END IF;
    
    RETURN v_Bonus;
END //

DELIMITER ;

SET @UpadateCount = 0;
CALL UpdateEmployeeSalary(1 , 10.00 , @UpadateCount);
SELECT @UpadateCount AS EmployeeUpdated;
SELECT * FROM Employees WHERE DepartmentID = 1;

SELECT
	EmployeeID,
    FirstName,
    Salary,
    CalculateEmployeeBonus(Salary) AS Bonus
FROM Employees;
