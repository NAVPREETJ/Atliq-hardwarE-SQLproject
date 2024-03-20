with cte1 as
(SELECT 
c.region,c.customer,
round(sum(net_sales)/1000000,2)as net_sales_mln
FROM net_sales s
join dim_customer c
on s.customer_code=c.customer_code
where s.fiscal_year= 2021
group by c.region,c.customer
)
select * ,net_sales_mln*100/sum(net_sales_mln) 
over(partition by region) as pct_region_share
from cte1 
order by region,net_sales_mln desc 