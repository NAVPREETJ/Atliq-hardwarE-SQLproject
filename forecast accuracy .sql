set sql_mode="";
create temporary table forcast_accuracy_2021
with cte1 as 
(SELECT 
s.customer_code as customer_code,
sum(s.forecast_quantity) as total_forecast_quantity,
sum(s.sold_quantity) as total_sold_quantity, 
sum((forecast_quantity-sold_quantity)) as net_err,
sum(forecast_quantity-sold_quantity)*100/sum(forecast_quantity)as net_err_pct,
sum(abs(forecast_quantity-sold_quantity))as abs_err,
sum(abs(forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
FROM gdb0041.fact_act_est s
where fiscal_year=2021
group by customer_code)

select
e.*,c.market,c.customer,
if (abs_err_pct>100,0,100-abs_err_pct) as forecast_accuracy
from cte1 e
join dim_customer c 
using(customer_code)
order by forecast_accuracy desc;
 
 
select
	f_2020.customer_code,
	f_2020.customer,
	f_2020.market,
	f_2020.forecast_accuracy as forecast_acc_2020,
	f_2021.forecast_accuracy as forecast_acc_2021
from forcast_accuracy_2020 f_2020
join forcast_accuracy_2021 f_2021
using(customer_code)
where f_2020.forecast_accuracy>f_2021.forecast_accuracy
order by forecast_acc_2020 desc

