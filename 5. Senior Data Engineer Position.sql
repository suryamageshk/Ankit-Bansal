-- Script:
CREATE TABLE [emp_salary]
(
    emp_id INTEGER  NOT NULL,
    name NVARCHAR(20)  NOT NULL,
    salary NVARCHAR(30),
    dept_id INTEGER
);

INSERT INTO emp_salary 
(emp_id, name, salary, dept_id)
VALUES
(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

-- Question: Write a SQL to return all employee whose salary is same in same department
WITH cte AS (
  SELECT 
    dept_id, 
    salary 
  FROM 
    emp_salary 
  GROUP BY 
    dept_id, 
    salary 
  HAVING 
    COUNT(1) > 1
) 
SELECT 
  E.* 
FROM 
  emp_salary AS E 
  INNER JOIN cte AS C ON E.dept_id = C.dept_id 
  AND E.salary = C.salary;

