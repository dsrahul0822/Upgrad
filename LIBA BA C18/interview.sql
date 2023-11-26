/*Ques1. Company wants to fire a few of their agents' basic minimum order 
amount. Write a sql query to find 5 agents which have the least order 
amount. Output should have agent_name, total_ord_amount and ranking.*/

select * from orders;
select * from agents;
select * from customer;

select * from (
select agent_name, tot_ord_amt, rank() over(order by tot_ord_amt asc) rnk
from (
select a.agent_name, sum(o.ord_amount) tot_ord_amt from agents a 
inner join orders o 
on a.agent_code = o.agent_code
group by a.agent_name) tbl) tbl1
where rnk<6;


/*Ques2: Company wants to find the name of a customer from every 
country who has a minimum outstanding amount. Write a sql to find 
the name of the customer who has the minimum outstanding amount from 
every country. Output should have cust_country and cust_name.
Note: Data provided by an agent whose name is Mukesh is not reliable, 
so ignore the data for this agent.*/

select * from (
select cust_country,cust_name, outstanding_amt,
rank() over(partition by cust_country order by outstanding_amt asc) rnk 
from customer where agent_code not in (
select agent_code from agents where agent_name='Mukesh')
order by cust_country) tbl
where rnk=1;


/*Ques3: Company wants to change the comission for the agents' 
basis advance payment they collected. Write a sql query which 
creates a new column updated_commision on the basis below rules.
If the average advance amount collected is less than 750, 
the new comission will be 0.75 times the old comission.
If the average advance amount collected is more than equal to 750 
and less than equal to 1000, the new comission will be 0.9 times 
the old comission.
If the average advance amount collected is more than 1000, the 
new commission will be 1.2 times the old comission.
Print agent_code,new comission as updated_comission.
*/

select * from agents;

select * from orders;

select * from agents a inner join (
select a.agent_code,agent_name, avg(advance_amount) from agents a 
inner join orders o
on a.agent_code = o.agent_code
group by a.agent_code,agent_name) tbl
on a.agent_code=tbl.agent_code;

select 
agent_name,
commission,
avg_adv_amt,
case 
	when avg_adv_amt<750 then 0.75*commission
    when avg_adv_amt>=750 and avg_adv_amt<=1000 then 0.9*commission
    else 1.2*commission
end
updated_commission
from (
select agent_name,commission, avg(advance_amount) avg_adv_amt from agents a 
inner join orders o
on a.agent_code = o.agent_code
group by agent_name,commission) tbl;


