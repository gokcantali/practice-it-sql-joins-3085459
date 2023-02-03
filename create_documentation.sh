#!/bin/sh
sqlite3 AdventureWorks.db <<EOF
.mode html
.output adventureworks_docs.html
select "List of Database Tables";
select "-----------------------";
SELECT name FROM sqlite_master
WHERE type = 'table' and name NOT LIKE 'sqlite_%';
select "-----------------------";
select "DimCustomer Table";
PRAGMA table_info('DimCustomer');
select "DimCurrency Table";
PRAGMA table_info('DimCurrency');
select "FactResellerSales Table";
PRAGMA table_info('FactResellerSales');
.quit
EOF