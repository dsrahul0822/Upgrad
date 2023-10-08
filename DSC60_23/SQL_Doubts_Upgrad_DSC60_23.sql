/*Q1: Company wants to fire a few of their agents' basic minimum order amount. 
Write a sql query to find 5 agents which have the least order amount. 
Output should have agent_name, total_ord_amount and ranking.*/

select * from agents;
select * from customer;
select * from orders;

select agent_name, sum(ord_amount) tot_ord_amt from agents inner join orders
on agents.agent_code = orders.agent_code
group by agent_name
order by tot_ord_amt
limit 5;

SELECT * FROM (
SELECT AGENT_NAME, TOT_ORD_AMT,
RANK() OVER(ORDER BY TOT_ORD_AMT ASC) RNK FROM (
select agent_name, sum(ord_amount) tot_ord_amt from agents inner join orders
on agents.agent_code = orders.agent_code
group by agent_name) TBL) FTBL
WHERE RNK<6;

/*Q2: Company wants to find the name of a customer from every country who has a minimum outstanding 
amount. Write a sql to find the name of the customer who has the minimum outstanding amount from 
every country. Output should have cust_country and cust_name. Note: Data provided by an agent 
whose name is Mukesh is not reliable, so ignore the data for this agent.*/
select * from (
select cust_country,cust_name,outstanding_amt,
rank() over(partition by cust_country order by outstanding_amt asc) rnk from customer
where agent_code not in (
select agent_code from agents where agent_name='Mukesh')
order by cust_country) tbl
where rnk=1;



/*Company wants to change the comission for the agents' basis advance payment they collected. 
Write a sql query which creates a new column updated_commision on the basis below rules.
If the average advance amount collected is less than 750, the new comission will be 0.75 times the 
old comission.
If the average advance amount collected is more than equal to 750 and less than equal to 1000, 
the new comission will be 0.9 times the old comission.
If the average advance amount collected is more than 1000, the new commission will be 1.2 times 
the old comission.
Print agent_code,new comission as updated_comission.
*/


select * from agents;
select * from orders;


select agents.agent_code,agents.agent_name,adv_amt,commission,
case when adv_amt<750 then 0.75*commission
when adv_amt>=750 and adv_amt<=1000 then 0.90*commission
else 1.2*commission
end updated_commission
 from agents inner join (
select agents.agent_code,agent_name, avg(advance_amount) adv_amt from agents 
inner join orders 
on agents.agent_code = orders.agent_code
group by agents.agent_code,agent_name) tbl
on agents.agent_code = tbl.agent_code;
10:45 we will resume

select agents.agent_code,agent_name,commission, avg(advance_amount) adv_amt from agents 
inner join orders 
on agents.agent_code = orders.agent_code
group by agents.agent_code,agent_name













CREATE TABLE TBL_TEST 
(EID INT,
ENAME VARCHAR(10),
SALARY INT);


INSERT INTO TBL_TEST VALUES 
(1,'A',1000),
(1,'A',1000),
(2,'B',1200),
(3,'C',1300),
(4,'D',1400),
(4,'D',1400),
(5,'E',1200),
(5,'E',1200),
(6,'F',1500),
(6,'F',1500),
(6,'F',1500);

SELECT * FROM TBL_TEST;

SELECT EID,ENAME,SALARY, RANK() OVER(ORDER BY SALARY ASC) RNK,
DENSE_RANK() OVER(ORDER BY SALARY DESC) DRNK,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) RNUM  
FROM TBL_TEST;









select agents.agent_code, agent_name, avg(advance_amount) from agents inner join 
orders on agents.agent_code = orders.agent_code 
group by agents.agent_code, agent_name;


