/*

FAST FOOD DATA EXPLORATION

*/

select *
from FastFoodSales

----- DATA PREPARATION

---- excluding the rows where values are null

select *
from FastFoodSales
where transaction_type is not null

---- Create a sex column and populae it with the received by column to the table

alter table FastFoodSales
add sex as
	case
		when (received_by = 'Mr.') then 'M'
		Else 'F'
	end


---- Splitting the date column in to day, month and year 

select DATENAME(year, date), DATENAME(month, date), DATENAME(WEEKDAY, date)
from FastFoodSales


alter table FastFoodSales
add DATENAME(year, date), DATENAME(month, date), DATENAME(WEEKDAY, date)

---year
alter table FastFoodSales
add year int;

update FastFoodSales
set year = DATENAME(year, date)

----month
alter table FastFoodSales
add month varchar(50);

update FastFoodSales
set month = DATENAME(month, date)

----day
alter table FastFoodSales
add weekday varchar(50);

update FastFoodSales
set weekday = DATENAME(weekday, date)

select *
from FastFoodSales
where transaction_type is not null

---- You can now export data to make visualisation


----- EXPLORATORY DATA ANALYSIS

--1. total transaction amount in 2022 and 2023
--2. why transaction type is used more
--3. item name ordered in during weekends
--4. which month has the hightest transaction amount in 2023 as compared to 2023
--5. when do we recieve most of our orders(Morning, Afternoon, Evening and Night)
--6. when item type is oredr more in december
--7. who order the most at night
--8. breverages are taken more by which sex
--9. fast food is order more in which week day
--10. which item name makes more money


--1. total transaction amount in 2022 and 2023

select sum(transaction_amount)
from FastFoodSales
where year = 2022 and transaction_type is not null


select sum(transaction_amount)
from FastFoodSales
where year = 2023 and transaction_type is not null


--2. which transaction type is used more

select transaction_type, count(transaction_type) as count
from FastFoodSales
where transaction_type is not null
group by transaction_type


--3. most items name ordered in during weekends


select item_name,count(item_name) count
from FastFoodSales
where transaction_type is not null and weekday = 'Sunday' and weekday = 'Sunday'
group by item_name
order by count(item_name) desc


--4. which month has the hightest transaction amount in 2022 as compared to 2023

select month,  sum(transaction_amount) amount
from FastFoodSales
where transaction_type is not null and year = 2022 
group by month
order by amount desc

select month,  sum(transaction_amount) amount
from FastFoodSales
where transaction_type is not null and year = 2023
group by month
order by amount desc


--5. when do we recieve most of our orders(Morning, Afternoon, Evening and Night)

select time_of_sale, count(time_of_sale) sales_time_count
from FastFoodSales
where transaction_type is not null
group by time_of_sale
order by sales_time_count desc


--6. which item type is ordered more in december 2022 and march 2023

select item_type, count(item_type) count, sum(transaction_amount) amount
from FastFoodSales
where transaction_type is not null and month = 'December' and year = 2022
group by item_type
order by count desc

select item_type, count(item_type) count, sum(transaction_amount) amount
from FastFoodSales
where transaction_type is not null and month = 'March' and year = 2023
group by item_type
order by count desc


--7. who order the most at night

select sex, count(sex) count
from FastFoodSales
where transaction_type is not null and time_of_sale = 'Night'
group by sex
order by count desc


--8. breverages are taken more by which sex

select sex, count(sex) count
from FastFoodSales
where transaction_type is not null and item_type = 'Beverages'
group by sex
order by count desc

--9. fast food is order more in which week day

select weekday, count(weekday) count, item_name
from FastFoodSales
where transaction_type is not null
group by weekday, item_name
order by count desc

--10. which item name makes more money

select item_name, sum(transaction_amount) amount
from FastFoodSales
where transaction_type is not null
group by item_name
order by amount desc
