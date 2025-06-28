-- Use the correct database
USE sampledb;
GO

-- Drop existing procedures if they exist
IF OBJECT_ID('sp_GetEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetEmployeesByDepartment;
IF OBJECT_ID('sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertEmployee;
GO

-- Drop tables if they exist
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
IF OBJECT_ID('Departments', 'U') IS NOT NULL
    DROP TABLE Departments;
GO

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

-- Create Employees table with auto-increment EmployeeID
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);
GO

-- Insert sample departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');
GO

-- Insert sample employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
('Suhana', 'Sharma', 1, 5000.00, '2020-01-15'),
('Jane', 'Smith', 2, 6000.00, '2019-03-22'),
('Rohit', 'Gaikwad', 3, 7000.00, '2018-07-30'),
('Shreyas', 'Shinde', 4, 5500.00, '2021-11-05');
GO

-- Create procedure to retrieve employees by department
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;
GO

-- Create procedure to insert a new employee (auto-generates EmployeeID)
CREATE PROCEDURE sp_InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
AS
BEGIN
    INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate)
    VALUES (@FirstName, @LastName, @DepartmentID, @Salary, @JoinDate);
END;
GO

--TEST: Insert a new employee using the procedure
EXEC sp_InsertEmployee 
    @FirstName = 'Alice', 
    @LastName = 'Williams', 
    @DepartmentID = 3, 
    @Salary = 7200.00, 
    @JoinDate = '2022-06-01';
GO

-- TEST: Retrieve all employees in the Finance department (DepartmentID = 2)
EXEC sp_GetEmployeesByDepartment @DeptID = 2;
GO
