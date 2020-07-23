-- find duplicate records in a table
SELECT EmpName,Salary, COUNT(*) AS CNT  
    FROM tblEmployee  
    GROUP BY EmpName,Salary 
    HAVING COUNT(*)>1  

-- delete all the duplicate records in a table
WITH cte AS (
    SELECT 
        EmpName,Salary,
        ROW_NUMBER() OVER (
            PARTITION BY 
               EmpName,Salary
            ORDER BY 
               EmpName,Salary
        ) row_num
     FROM 
        tblEmployee
)
DELETE FROM cte WHERE row_num > 1;



-- find the manager name for the employee 
    --where empid and managerid are on the same table
SELECT e.EmpId, e.EmpName, m.EmpName 
    FROM tblEmployee e
    LEFT JOIN tblEmployee m 
        on e.ManagerId = m.EmpId


-- find the second highest salary
Select max(Salary) as Salary
    FROM tblEmployee
    WHERE Salary <(Select max(Salary) from tblEmployee) 
 -- 1. Inner Query - Get the highest salary
 -- 2. Outer Query - Get the highest salary excluding the highest salary 
                    -- gives the second highest salary

-- find the employee with the second highest salary
SELECT * FROM tblEmployee where Salary in 
(SELECT max(Salary) as Salary
    FROM tblEmployee
    WHERE Salary < (Select max(Salary) FROM tblEmployee)  )


-- 3rd and Nth highest salary
SELECT MIN(Salary) FROM				-- OUTER QUERY 
( SELECT DISTINCT TOP 3 Salary		-- INNER QUERY
	FROM tblEmployee
	ORDER BY Salary DESC
)  AS O
-- Here 3 can be changed to N ; can be applied for any number. 
-- 1. Inner Query - Get the highest 3 salaries
-- 2. Outer Query - Get the minimum salary from those salaries


-- query to find maximum salary from each department
SELECT DeptId, MAX(Salary) as Salary 
    FROM tblEmployee 
    GROUP BY DeptId  


--alternative for TOP clause in SQL
SELECT TOP 3 * FROM tblEmployee
--Alternative
SET ROWCOUNT 3  
Select * from tblEmployee
SET ROWCOUNT 0 

-- showing single row from a table twice in the results
SELECT deptname FROM tblDepartment d WHERE d.deptname='IT'  
UNION ALL
SELECT deptname FROM tblDepartment d WHERE d.deptname='IT'  

-- find departments that have less than 3 employees
SELECT e.DeptId,d.DeptName 
    FROM tblEmployee e
    JOIN tblDepartment d on e.DeptId = d.DeptId
    GROUP BY e.DeptId,d.DeptName HAVING COUNT(EmpId) < 3



