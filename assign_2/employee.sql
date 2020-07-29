USE EMPLOYEES;

DROP TABLE IF EXISTS Assigned_Main;
DROP TABLE IF EXISTS Project_Main;
DROP TABLE IF EXISTS Employee_Department;
DROP TABLE IF EXISTS Employee_Main;
DROP TABLE IF EXISTS Department_Location;
DROP TABLE IF EXISTS Department_Main;

CREATE TABLE Department_Main(
	deptID   INT          NOT NULL,
    deptName VARCHAR(100) NOT NULL,
	primary key (deptID)
);

CREATE TABLE Department_Location(
	deptID     INT          NOT NULL,
    address    VARCHAR(100) NOT NULL,
    city       VARCHAR(50)  NOT NULL,
    region     VARCHAR(50)  NOT NULL,
    postalCode VARCHAR(20)  NOT NULL,
	primary key (deptID, address, city, region, postalCode),
    foreign key (deptID)
		references Department_Main(deptID)
);

CREATE TABLE Employee_Main(
	empID      INT          NOT NULL,
    firstName  VARCHAR(50)  NOT NULL,
    middleName VARCHAR(50),
    lastName   VARCHAR(50)  NOT NULL,
    job        VARCHAR(100) NOT NULL,
    salary     INT          NOT NULL,
	primary key (empID)
);

CREATE TABLE Employee_Department(
	empID  INT NOT NULL,
    deptID INT NOT NULL,
	primary key (deptID, empID),
    foreign key (empID)
		references Employee_Main(empID)
);

CREATE TABLE Project_Main(
	projID INT          NOT NULL,
    title  VARCHAR(100) NOT NULL,
    budget INT          NOT NULL,
    funds  INT          NOT NULL,
	primary key (projID)
);

CREATE TABLE Assigned_Main(
	empID  INT          NOT NULL,
    projID INT          NOT NULL,
    role   VARCHAR(100) NOT NULL,
	primary key (projID, empID, role),
    foreign key (empID)
		references Employee_Main(empID),
    foreign key (projID)
		references Project_Main(projID)
);

INSERT INTO Department_Main(deptID, deptName)
	SELECT DISTINCT deptID, deptName FROM Department;

INSERT INTO Department_Location(deptID, address, city, region, postalCode)
	SELECT deptID,
		SUBSTRING_INDEX(location, ',', 1) as address,
		SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1) as city,
        SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 3), ',', -1) as region,
        SUBSTRING_INDEX(location, ',', -1) as postalCode
	FROM (SELECT DISTINCT deptID, location FROM Department) A;

INSERT INTO Employee_Main(empID, firstName, middleName, lastName, job, salary)
	SELECT empID,
		SUBSTRING_INDEX(empName, ' ', 1) as firstName,
        CASE WHEN LENGTH(empName) - LENGTH(REPLACE(empName, ' ', '')) = 2 THEN
			SUBSTRING_INDEX(SUBSTRING_INDEX(empName, ' ', 2), ' ', -1)
		ELSE NULL END as middleName,
        SUBSTRING_INDEX(empName, ' ', -1) as lastName,
        job, salary
	FROM (SELECT DISTINCT empID, empName, job, salary FROM Employee) A;

INSERT INTO Employee_Department(empID, deptID)
	SELECT DISTINCT empID, deptID FROM Employee;

INSERT INTO Project_Main(projID, title, budget, funds)
	SELECT DISTINCT projID, title, budget, funds FROM Project;

INSERT INTO Assigned_Main(empID, projID, role)
	SELECT DISTINCT empID, projID, role FROM Assigned;

DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Assigned;
