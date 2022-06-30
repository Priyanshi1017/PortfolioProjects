Select JobTitle,Avg(Salary) as 'Average Salary' ,Count(Jobtitle) 'Number of Salesman' From SQLtutorialLocal.dbo.EmployeeDemographics
Full OUTER JOIN SQLtutorialLocal.dbo.EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'salesman'
Group by JobTitle


Select Jobtitle,salary
From SQLtutorialLocal.dbo.EmployeeSalary
where JobTitle = 'Salesman'




--Select * from SQLtutorialLocal.dbo.EmployeeDemographics
Select * from SQLtutorialLocal.dbo.EmployeeSalary

Select FirstName,LastName,Age,
CASE
When age = 38 then 'stanley'
When Age>30 THEN 'old'
When Age between 26 and 30 then 'baby'
When age = 38 then 'stanley'
Else 'young'
END

From EmployeeDemographics
order by age


select Firstname,Lastname,Gender,Salary,
count(gender) over (partition by Gender) as TotalGender
from 
EmployeeDemographics dem join EmployeeSalary sal
on dem.EmployeeID = sal.EmployeeID 

select Jobtitle,
avg(salary) as AverageSal
from EmployeeSalary
where Jobtitle = 'Salesman'
Group by Jobtitle

with CTE_Employee as
(select Jobtitle,
avg(salary) as AverageSalary
from EmployeeDemographics join EmployeeSalary
 on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where Jobtitle is not null
Group by Jobtitle
)
select * from CTE_Employee
select Jobtitle,AverageSalary from CTE_Employee
where AverageSalary in (select max(averagesalary) from CTE_Employee)

drop table if EXISTS #temp_Empsalary
create table #temp_Empsalary
(EmployeeId int,
Jobtitle VARCHAR(50),
Salary int)


Insert into #temp_Empsalary
Select * from Employeesalary
WHERE salary between 35000 and 50000 and Jobtitle is not null AND EmployeeID is not NULL

select * from #temp_Empsalary



create table #temp_2
(Jobtitle VARCHAR(50),
EmployeePerJob int,
AverageAge int,
AverageSalary int)

Insert into #temp_2
select Jobtitle,count(jobtitle),Avg(age),Avg(salary) 
from EmployeeDemographics join EmployeeSalary
 on EmployeeDemographics.EmployeeId = Employeesalary.EmployeeID
Group by Jobtitle

select * from #temp_2

create table EmployeeErrors
(EmployeeID VARCHAR(50),
FirstName VARCHAR(50),
LastName VARCHAR(50)
)

Insert into EmployeeErrors VALUES
('1001  ','Jimbo','Halbert'),
('  1002','Pamela','Beasely'),
('1005','TOmy','Flinders-Fired')

select * from EmployeeErrors
--TRIM funtion
select EmployeeID, LTRIM(EmployeeID) as TrimmedID
from EmployeeErrors

select EmployeeID, RTRIM(EmployeeID) as TrimmedID
from EmployeeErrors

select EmployeeID, TRIM(EmployeeID) as TrimmedID
from EmployeeErrors

--Replace function
select LastName, Replace(LastName,'-Fired','') as LastNameFixed
from EmployeeErrors

--substring function
select d.Firstname,SUBSTRING(d.Firstname,1,3),e.Firstname,SUBSTRING(e.Firstname,1,3)
from EmployeeDemographics d join EmployeeErrors e
on SUBSTRING(d.Firstname,1,3) = SUBSTRING(e.Firstname,1,3)

--upper and lower function
select Firstname,UPPER(Firstname)
from EmployeeErrors
---
 

 -- SUBQUERY
 select * from EmployeeSalary
where EmployeeID in (select EmployeeID from EmployeeDemographics
                      where age>30)
                      
                      
--- adding primary key constraint with clustered index on table EmployeeDemographics with column EmployeeID
alter table EmployeeDemographics
add CONSTRAINT PK_EmployeeID Primary Key CLUSTERED(EmployeeID)
