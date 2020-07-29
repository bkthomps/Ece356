USE EMPLOYEES;

DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Assigned;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department(deptID INT,deptName VARCHAR(100),location VARCHAR(100));
CREATE TABLE Employee(empID INT,empName VARCHAR(100),job VARCHAR(100),deptID INT,salary INT);
CREATE TABLE Assigned(empID INT,projID INT,role VARCHAR(100));
CREATE TABLE Project(projID INT,title VARCHAR(100),budget INT,funds INT);

INSERT INTO Department(deptID, deptName, location) VALUES(3, 'marketing', '123 Fake Street, Waterloo, Ontario, N2N 2N2');             
INSERT INTO Department(deptID, deptName, location) VALUES(7, 'research', '124 Unreal Way, Guelph, Ontario, N3N 3N3');            
INSERT INTO Department(deptID, deptName, location) VALUES(12, 'software', '1 Bay Street, Toronto, Ontario, M5W 1E6'); 
INSERT INTO Department(deptID, deptName, location) VALUES(13, 'computing', '1 Bay Street, Toronto, Ontario, M5W 1E6'); 

INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(23, 'Mary Jane Smith', 'programmer', 12, 35000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(45, 'Kelly Kelly', 'engineer', 7, 37000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(56, 'Adam Andrew Herr', 'janitor', 7, 26000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(89, 'William William Williams', 'analyst', 12, 36000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(77, 'Bryan Hergot', 'secretary', 7, 28000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(66, 'Brian Hess', 'technician', 7, 32000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(92, 'Mary Mays', 'engineer', 7, 45000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(68, 'Joe Morris', 'secretary', 3, 23000);  
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(69, 'Maria Jones', 'engineer', 3, 32000); 

INSERT INTO Project(projID, title, budget, funds) VALUES(345, 'compiler', 500000, 250000); 
INSERT INTO Project(projID, title, budget, funds) VALUES(123, 'display', 650000, 370000); 

INSERT INTO Assigned(empID, projID, role) VALUES(23, 345, 'programmer');            
INSERT INTO Assigned(empID, projID, role) VALUES(66, 123, 'programmer');        
INSERT INTO Assigned(empID, projID, role) VALUES(77, 123, 'secretary');           
INSERT INTO Assigned(empID, projID, role) VALUES(45, 123, 'manager'); 
INSERT INTO Assigned(empID, projID, role) VALUES(89, 345, 'manager');     
INSERT INTO Assigned(empID, projID, role) VALUES(92, 123, 'engineer'); 
