-- 1.Get number of monthly active customers.


SELECT * 
FROM rental r  ;
	
	
SELECT customer_id,return_date  
FROM rental r  ;

-- monthly customer

SELECT customer_id,return_date,
	DATE_FORMAT(convert(return_date, date), '%m') AS Activity_Month,
	DATE_FORMAT(convert(return_date, date), '%y') AS Activity_year
FROM rental r  ;

-- Getting the number of monthly active customers.

with cte_monthly_customer as (
	SELECT customer_id,return_date,
	DATE_FORMAT(convert(return_date, date), '%m') AS Activity_Month,
	DATE_FORMAT(convert(return_date, date), '%y') AS Activity_year
FROM rental r  
)
select Activity_year, Activity_Month, count(distinct customer_id) as Active_users
from cte_monthly_customer
group by Activity_year, Activity_Month;


-- 2.Active users in the previous month.

with cte_monthly_customer as (
	SELECT customer_id,return_date,
	DATE_FORMAT(convert(return_date, date), '%m') AS Activity_Month,
	DATE_FORMAT(convert(return_date, date), '%y') AS Activity_year
FROM rental r
), cte_active_users as (
	select Activity_year, Activity_Month, count(distinct customer_id) as Active_users
	from cte_monthly_customer
	group by Activity_year, Activity_Month
)
select Activity_year, Activity_month, Active_users, 
   lag(Active_users) over (order by Activity_year, Activity_Month) as Last_month
from cte_active_users;

-- 3. Percentage change in the number of active customers.

with cte_monthly_customer as (
	select cte_monthly_customer, convert(return_date, date) as Activity_date,
		date_format(convert(return_date,date), '%m') as Activity_Month,
		date_format(convert(return_date,date), '%Y') as Activity_year
	from rental r 
), cte_active_users as (
	select Activity_year, Activity_Month, count(distinct customer_id) as Active_users
	from cte_monthly_customer
	group by Activity_year, Activity_Month
), cte_active_users_prev as (
	select Activity_year, Activity_month, Active_users, 
	   lag(Active_users) over (order by Activity_year, Activity_Month) as Last_month
	from cte_active_users)
select *,
	(Active_users - Last_month) as Difference,
    concat(round((Active_users - Last_month)/Active_users*100), "%") as Percent_Difference
from cte_active_users_prev;

-- 4. Retained customers every month.

with cte_monthly_customer as (
	select cte_monthly_customer, convert(return_date, date) as Activity_date,
		date_format(convert(return_date,date), '%m') as Activity_Month,
		date_format(convert(return_date,date), '%Y') as Activity_year
	from rental r
), recurrent_transactions as (
	select distinct 
		account_id as Active_id, 
		Activity_year, 
		Activity_month
	from cte_monthly_customer
	order by Active_id, Activity_year, Activity_month
)
select rec1.Active_id, rec1.Activity_year, rec1.Activity_month, rec2.Activity_month as Previous_month
from recurrent_transactions rec1
join recurrent_transactions rec2
on rec1.Activity_year = rec2.Activity_year -- To match the similar years. It is not perfect, is we wanted to make sure that, for example, Dez/1994 would connect with Jan/1995, we would have to do something like: case when rec1.Activity_month = 1 then rec1.Activity_year + 1 else rec1.Activity_year end
and rec1.Activity_month = rec2.Activity_month+1 -- To match current month with previous month. It is not perfect, if you want to connect Dezember with January we would need something like this: case when rec2.Activity_month+1 = 13 then 12 else rec2.Activity_month+1 end;
and rec1.Active_id = rec2.Active_id -- To get recurrent users.
order by rec1.Active_id, rec1.Activity_year, rec1.Activity_month;



select account_id, convert(date, date) as Activity_date,
		date_format(convert(date,date), '%m') as Activity_Month,
		date_format(convert(date,date), '%Y') as Activity_year
	from bank.trans;
    

























