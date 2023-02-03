-- SQLite
select A.FirstName as EmployeeName, B.FirstName as ManagerName
from DimEmployee as A
join DimEmployee as B
on A.ParentEmployeeKey = B.EmployeeKey;