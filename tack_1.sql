create database company
go
use company
go
create schema x1
go
--1.	Create a table named "Employees" with columns for ID (integer), Name (varchar), and Salary (decimal).
create table x1.Employees(
	id int primary key identity(1,1),
	name varchar(60) not null ,
	salare decimal not null
)
--2.	Add a new column named "Department" to the "Employees" table with data type varchar(50).
alter table x1.Employees
add Department varchar(60) not null

--3.	Remove the "Salary" column from the "Employees" table.
alter table x1.Employees
drop column salare
go

--4.	Rename the "Department" column in the "Employees" table to "DeptName".

EXEC sp_rename 'x1.Employees.Department', 'DeptName'

--5.	Create a new table called "Projects" with columns for ProjectID (integer) and ProjectName (varchar).
create table x1.Projects(
	ProjectID int primary key identity(1,1),
	ProjectName varchar(59) not null
)

--6.	Add a primary key constraint to the "Employees" table for the "ID" column.

--7.	Create a foreign key relationship between the "Employees" table (referencing "ID") and the "Projects" table (referencing "ProjectID").

alter table x1.Employees
add ProjectID int,
foreign key(ProjectID) references x1.Projects(ProjectID)

--8.	Remove the foreign key relationship between "Employees" and "Projects."
SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('x1.Employees')
go
ALTER TABLE x1.Employees
DROP CONSTRAINT FK__Employees__Proje__398D8EEE;

alter table x1.Employees
drop column ProjectID
go

--9.	Add a unique constraint to the "Name" column in the "Employees" table.

ALTER TABLE x1.Employees
ADD CONSTRAINT UQName UNIQUE (name)

--10.	Create a table named "Customers" with columns for CustomerID (integer),
--FirstName (varchar), LastName (varchar), and Email (varchar), and Status (varchar).
create table x1.Customers(
	CustomerID int primary key identity(1,1),
	FirstName varchar(50)not null,
	LastName varchar(50)not null,
	Email varchar(90)not null,
	Status varchar(50) not null
) 
--11.	Add a unique constraint to the combination of "FirstName" and "LastName" columns in the "Customers" table.

ALTER TABLE x1.Customers
ADD CONSTRAINT f_Name UNIQUE (FirstName)
go
ALTER TABLE x1.Customers
ADD CONSTRAINT l_Name UNIQUE (LastName)
go

--12.	Add a default value of 'Active' for the "Status" column in the "Customers" table,
--where the default value should be applied when a new record is inserted.
ALTER TABLE x1.Customers
ADD  DEFAULT 'Active' FOR Status;


--13.	Create a table named "Orders" with columns for OrderID (integer),
--CustomerID (integer), OrderDate (datetime), and TotalAmount (decimal).
create table x1.Orders(
	OrderID int primary key identity(1,1),
	CustomerID int,
	OrderDate datetime2,
	TotalAmount decimal not null
)

--14.	Add a check constraint to the "TotalAmount" column in the "Orders" table to ensure that it is greater than zero.
--جربت دي يا هندسه اداني ايرور معرفتش احلها الي ب الطريقه التنيا وانا عارف ان مينفعش عشان لو في داتا بس عملت كدا عشان مفيش داتا 
--alter table x1.Orders
--alter column TotalAmount decimal not null CHECK(TotalAmount > 0)

alter table x1.Orders
drop column TotalAmount
go
alter table x1.Orders
add TotalAmount decimal not null CHECK(TotalAmount > 0)
go

--15.	Create a schema named "Sales" and move the "Orders" table into this schema.
create schema Sales
go
ALTER SCHEMA Sales TRANSFER x1.Orders;

--16.	Rename the "Orders" table to "SalesOrders."
exec sp_rename 'Sales.Orders','SalesOrders'