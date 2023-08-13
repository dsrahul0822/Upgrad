/*Find the total order amount for each customer*/
SELECT CUST_CODE, SUM(ORD_AMOUNT) AS TotalOrderAmount FROM orders GROUP BY CUST_CODE;

/*List all customers who don't have any orders.*/
SELECT CUST_NAME FROM customer WHERE CUST_CODE NOT IN (SELECT DISTINCT CUST_CODE FROM orders);

/*Find the agent who has the maximum number of customers.*/
SELECT AGENT_CODE, COUNT(*) as NumberOfCustomers 
FROM customer 
GROUP BY AGENT_CODE 
ORDER BY NumberOfCustomers DESC LIMIT 1;

/*List all agents along with the total order amount of their customers.*/
SELECT a.AGENT_NAME, SUM(o.ORD_AMOUNT) AS TotalOrderAmount 
FROM agents a 
JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE 
GROUP BY a.AGENT_NAME;

/*Find all customers who have placed orders with agent 'A002'.*/
SELECT CUST_NAME 
FROM customer 
WHERE CUST_CODE IN (SELECT CUST_CODE FROM orders WHERE AGENT_CODE='A002');

/*List all customers from 'Bangalore' and their order amounts.*/
SELECT c.CUST_NAME, SUM(o.ORD_AMOUNT) AS TotalOrderAmount 
FROM customer c 
LEFT JOIN orders o ON c.CUST_CODE = o.CUST_CODE 
WHERE c.CUST_CITY = 'Bangalore' 
GROUP BY c.CUST_NAME;


/*Find the total outstanding amount for each country.*/
SELECT CUST_COUNTRY, SUM(OUTSTANDING_AMT) AS TotalOutstandingAmount 
FROM customer 
GROUP BY CUST_COUNTRY;

/*Find agents and the number of customers they serve, but only list agents serving more than 2 customers.*/
SELECT AGENT_CODE, COUNT(*) as NumberOfCustomers 
FROM customer 
GROUP BY AGENT_CODE 
HAVING NumberOfCustomers > 2;

/*List all agents and their customers.*/
SELECT a.AGENT_NAME, c.CUST_NAME 
FROM agents a 
LEFT JOIN customer c ON a.AGENT_CODE = c.AGENT_CODE;


/*List all customers and the names of their respective agents.*/
SELECT c.CUST_NAME, a.AGENT_NAME 
FROM customer c 
LEFT JOIN agents a ON c.AGENT_CODE = a.AGENT_CODE;


/*List all customers and the names of their respective agents.*/
SELECT CUST_NAME, OUTSTANDING_AMT 
FROM customer 
ORDER BY OUTSTANDING_AMT DESC LIMIT 1;


/*Find the total number of orders placed in the year '2008'.*/
SELECT COUNT(*) 
FROM orders 
WHERE YEAR(ORD_DATE) = 2008;

/*Find the customer from 'Chennai' who has the highest order amount.*/
SELECT c.CUST_NAME, MAX(o.ORD_AMOUNT) as MaxOrderAmount 
FROM customer c 
JOIN orders o ON c.CUST_CODE = o.CUST_CODE 
WHERE c.CUST_CITY = 'Chennai' 
GROUP BY c.CUST_NAME 
ORDER BY MaxOrderAmount DESC LIMIT 1;

/*List all customers who have not been served by any agent.*/
SELECT CUST_NAME 
FROM customer 
WHERE AGENT_CODE IS NULL;
