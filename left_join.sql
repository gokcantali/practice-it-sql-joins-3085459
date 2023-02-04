create view customer_email_a as
select CustomerKey, EmailAddress
from DimCustomer
where EmailAddress like '%a%@adventure-works.com';

create view customer_address_us as
select DC.CustomerKey, DC.AddressLine1, DC.AddressLine2, DC.GeographyKey
from DimCustomer as DC
join DimGeography as DG on DC.GeographyKey = DG.GeographyKey
where DG.CountryRegionCode = 'US';


select DC.CustomerKey, DC.FirstName, DC.LastName, CEA.EmailAddress, CAU.GeographyKey
from DimCustomer as DC
left outer join customer_email_a as CEA
on DC.CustomerKey = CEA.CustomerKey
left outer join customer_address_us as CAU
on DC.CustomerKey = CAU.CustomerKey;

select DP.ProductKey, SUM(FIS.SalesAmount) from DimProduct as DP
left outer join FactInternetSales as FIS
on DP.ProductKey = FIS.ProductKey
group by DP.ProductKey;

select DP.ProductKey, DP.EnglishProductName,
FIS.OrderDate, FIS.OrderQuantity, FIS.SalesAmount
from DimProduct as DP
left outer join FactInternetSales as FIS
on DP.ProductKey = FIS.ProductKey;

select DR.ResellerKey, DR.AddressLine1, DR.AddressLine2,
DG.CountryRegionCode, DP.EnglishProductName, DPS.EnglishProductSubcategoryName
from DimReseller as DR
join DimGeography as DG
on DR.GeographyKey = DG.GeographyKey
left outer join FactResellerSales as FRS
on DR.ResellerKey = FRS.ResellerKey
join DimProduct as DP
on FRS.ProductKey = DP.ProductKey
join DimProductSubcategory as DPS
on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
where DG.CountryRegionCode = 'US';