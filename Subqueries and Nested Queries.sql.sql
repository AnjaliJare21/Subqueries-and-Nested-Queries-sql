CREATE DATABASE CompanyDB;
use CompanyDB;

-- table Departments
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name TEXT
);

-- table Employees
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    salary INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Departments VALUES
 (1, 'IT'),
 (2, 'HR'),
 (3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Anjali', 60000, 1),
(102, 'Rahul', 75000, 1),
(103, 'Sneha', 50000, 2),
(104, 'Amit', 40000, 3),
(105, 'Neha', 80000, 1);


SELECT name,
       salary,
       (SELECT AVG(salary) FROM Employees) AS avg_salary
FROM Employees;

-- subquery in WHERE using IN
SELECT name FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments WHERE dept_name = 'IT');

-- Subquery using EXISTS
SELECT dept_name
FROM Departments D
WHERE EXISTS (
    SELECT 1 FROM Employees E WHERE E.dept_id = D.dept_id
);

-- Correlated Subquery
SELECT name, salary
FROM Employees E1
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees E2
    WHERE E1.dept_id = E2.dept_id
);

-- Subquery in FROM (Derived Table)
SELECT dept_id, AVG(salary) AS avg_sal
FROM (
    SELECT * FROM Employees WHERE salary > 50000
) AS HighEarners
GROUP BY dept_id;

