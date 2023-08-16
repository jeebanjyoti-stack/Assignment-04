create database Assesment04Db
use Assesment04Db

create table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float,
PTax as (0.10 * PPrice) persisted,
PCompany nvarchar(50) check (PCompany in ('SamSung', 'Apple', 'Redmi', 'HTC', 'RealMe', 'Xiaomi')),
PQty int default 10 check (PQty >= 1))

insert into Products (PName, PPrice, PCompany, PQty) values  ('Samsung Galaxy S21', 1000.00, 'SamSung', 20)
insert into Products (PName, PPrice, PCompany, PQty) values  ('iPhone 13 Pro', 1200.00, 'Apple', 15)
insert into Products (PName, PPrice, PCompany, PQty) values  ('Redmi Note 10', 250.00, 'Redmi', 12)
insert into Products (PName, PPrice, PCompany, PQty) values  ('HTC One X', 400.00, 'HTC', 8)
insert into Products (PName, PPrice, PCompany, PQty) values  ('Realme 8 Pro', 300.00, 'Realme', 25)
insert into Products (PName, PPrice, PCompany, PQty) values  ('Xiaomi Mi 11', 800.00, 'Xiaomi', 18)
insert into Products (PName, PPrice, PCompany, PQty) values  ('Samsung Galaxy A52', 400.00, 'SamSung', 10)
insert into Products (PName, PPrice, PCompany, PQty) values  ('iPhone SE', 600.00, 'Apple', 7)
insert into Products (PName, PPrice, PCompany, PQty) values  ('Redmi 9', 180.00, 'Redmi', 14)
insert into Products (PName, PPrice, PCompany, PQty) values  ('HTC Desire 12', 200.00, 'HTC', 5)

create procedure usp_ProductDisplay
 with encryption
 as
 begin
 select  PId, PName, PPrice + PTax as PPricewithTax, PCompany, PQty * (PPrice + PTax) as TotalPrice
 from Products
 end
 exec usp_ProductDisplay

 exec sp_helptext usp_ProductDisplay


create proc usp_TaxofPCompany
@companyName nvarchar(50),
@totalTax float output
with encryption
as
select @totalTax = SUM(PTax)
from Products
where PCompany = @companyName

declare @totalTax float
execute usp_TaxofPCompany 'HTC', @totalTax output
print @totalTax  

exec sp_helptext usp_TaxofPCompany


