create table orders_2024 (
OrderID varchar(100),
CustomerID varchar(100),
ProductID int,
OrderDate date,
Quantity int,
Revenue	DECIMAL(10, 2),
COGS DECIMAL(10, 2),
SourceFile varchar(100)
);


copy order_2024 (
OrderID ,
CustomerID ,
ProductID ,
OrderDate ,
Quantity ,
Revenue	,
COGS ,
SourceFile
)
from 'C:\Users\Anurag\Desktop\SQL Projects\Pricing Analysis\Data\Orders_2024.csv'
delimiter ','
csv header;
)
;

create table orders_2023 (
OrderID varchar(100),
CustomerID varchar(100),
ProductID int,
OrderDate date,
Quantity int,
Revenue	DECIMAL(10, 2),
COGS DECIMAL(10, 2),
SourceFile varchar(100)
);


copy orders_2023 (
OrderID ,
CustomerID ,
ProductID ,
OrderDate ,
Quantity ,
Revenue	,
COGS ,
SourceFile
)
from 'C:\Users\Anurag\Desktop\SQL Projects\Pricing Analysis\Data\Orders_2023.csv'
delimiter ','
csv header;


create table orders_2025 (
OrderID varchar(100),
CustomerID varchar(100),
ProductID int,
OrderDate date,
Quantity int,
Revenue	DECIMAL(10, 2),
COGS DECIMAL(10, 2),
SourceFile varchar(100)
);


copy orders_2025 (
OrderID ,
CustomerID ,
ProductID ,
OrderDate ,
Quantity ,
Revenue	,
COGS ,
SourceFile
)
from 'C:\Users\Anurag\Desktop\SQL Projects\Pricing Analysis\Data\Orders_2025.csv'
delimiter ','
csv header;

create table customers (
customerID varchar(100),
region varchar(100),
customer_join_date date
);

copy customers (
CustomerID ,
region ,
customer_join_date
)
from 'C:\Users\Anurag\Desktop\SQL Projects\Pricing Analysis\Data\customers.csv'
delimiter ','
csv header;


create table products (
ProductID int,
ProductName varchar(100),
ProductCategory varchar(100),
Price DECIMAL(10, 2),
Base_Cost DECIMAL(10, 2)
);

copy products (
ProductID ,
ProductName ,
ProductCategory ,
Price,
Base_Cost
)
from 'C:\Users\Anurag\Desktop\SQL Projects\Pricing Analysis\Data\products.csv'
delimiter ','
csv header;

with all_orders as (
	select
	OrderID ,
	CustomerID ,
	ProductID ,
	OrderDate ,
	Quantity ,
	Revenue	,
	COGS 
	from orders_2023
	union all
	select
	OrderID ,
	CustomerID ,
	ProductID ,
	OrderDate ,
	Quantity ,
	Revenue	,
	COGS 
	from orders_2024
	union all
	select
	OrderID ,
	CustomerID ,
	ProductID ,
	OrderDate ,
	Quantity ,
	Revenue	,
	COGS 
	from orders_2025
	)

-- Combining data of all years in a single table --

select
ao.OrderID ,
cus.region,
ao.CustomerID ,
ao.ProductID ,
ao.OrderDate ,
cus.customer_join_date,
ao.Quantity ,
ao.Revenue	,
case when ao.revenue is null then prod.price * ao.quantity else ao.revenue end as Cleaned_revenue,
ao.revenue - ao.cogs as profit,
ao.COGS,
prod.productname, 
prod.productcategory,
prod.price,
prod.base_cost
from all_orders ao
left join customers cus --left join so that no value of the main table is missed, just as a precaution --
on ao.customerid = cus.customerid
left join products prod
on ao.productid = prod.productid
where ao.customerid is not null















