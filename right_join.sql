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
from customer_email_a as CEA
left outer join DimCustomer as DC
on DC.CustomerKey = CEA.CustomerKey
left outer join customer_address_us as CAU
on DC.CustomerKey = CAU.CustomerKey;

select DP.ProductKey, SUM(FIS.SalesAmount)
from FactInternetSales as FIS
left outer join DimProduct as DP
on DP.ProductKey = FIS.ProductKey
group by DP.ProductKey;

select DP.ProductKey, DP.EnglishProductName,
FIS.OrderDate, FIS.OrderQuantity, FIS.SalesAmount
from FactInternetSales as FIS
left outer join DimProduct as DP
on DP.ProductKey = FIS.ProductKey;

select CAU.*, FIS.*
from customer_address_us as CAU
left outer join FactInternetSales as FIS
on CAU.CustomerKey = FIS.CustomerKey
union
select CAU.*, FIS.*
from FactInternetSales as FIS
left outer join customer_address_us as CAU
on CAU.CustomerKey = FIS.CustomerKey;

select DST.*, DOR.*
from DimSalesTerritory as DST
cross join DimOrganization as DOR;