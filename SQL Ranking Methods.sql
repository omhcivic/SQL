 ---Create Employee Table 
 
 CREATE TABLE Employee
  (EmployeeID smallint NOT NULL,
  Name nvarchar(50) NOT NULL,
  DeptID smallint NULL,
  Salary integer NULL
  );

 INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(1,'Mia','5',50000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(2,'Adam','2',50000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(3,'Sean','5',60000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(4,'Robert','2',50000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(5,'Jack','2',45000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(6,'Neo','5',60000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(7,'Jennifer','2',55000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(8,'Lisa','2',85000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(9,'Martin','2',35000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(10,'Terry','5',90000)
  INSERT INTO Employee(EmployeeID,Name,DeptID,Salary)
  VALUES(12,'David','5',60000);

-- List the employees by DeptID and rank in desc order by Salary 

--Option 1
 -- Row Number
SELECT * ,
Row_Number() OVER (PARTITION BY DeptID ORDER BY Salary) AS RANK1
FROM Employee

--Option 2
--Rank
SELECT * ,
RANK() OVER(PARTITION BY DeptID ORDER BY Salary) AS RANK2
FROM Employee

--Option 3
--Dense Rank

SELECT * 
, DENSE_RANK() OVER(PARTITION BY DeptID ORDER BY Salary) AS RANK3
FROM Employee
