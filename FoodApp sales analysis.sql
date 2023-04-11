use portproject;

drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'02-22-2023'),
(3,'03-21-2023');

select * from goldusers_signup;

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'02-02-2023'),
(2,'01-15-2023'),
(3,'03-11-2023');

select * from users;

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'01-19-2023',2),
(3,'12-18-2022',1),
(2,'03-20-2023',3),
(1,'10-23-2022',2),
(1,'03-19-2023',3),
(3,'12-20-2022',2),
(1,'11-09-2022',1),
(1,'05-20-2021',3),
(2,'09-24-2021',1),
(1,'03-11-2023',2),
(1,'03-11-2023',1),
(3,'11-10-2022',1),
(3,'12-07-2021',2),
(3,'12-15-2021',2),
(2,'11-08-2022',2),
(2,'09-10-2022',3);

select * from sales;

drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',799),
(2,'p2',899),
(3,'p3',549);

select * from product;



select * from goldusers_signup;
select * from users;
select * from sales;
select * from product;


Q1-Calculate the total amount customer spent on this foodapp?

select s.userid,sum(p.price) total_amt_spent from sales s inner join product p on s.product_id=p.product_id
group by s.userid;

Q2-How many days has each customer visited foodapp?

select userid,count(distinct created_date) different_days from sales group by userid; 

Q3-what was the first product purchased by each customer?

select * from
(select *,rank() over(partition by userid order by created_date) ranking from sales)
a where ranking =1;

Q4- What is the most purchased item on the menu and how many times was it purchased by all customer?

select userid,count(product_id) cnt from sales where product_id=(
select top 1 product_id from sales group by product_id order by count(product_id) desc)
group by userid;

Q5- Which item was most popular for each customer?

select * from (select *, rank() over(partition by userid order by cnt desc) rnk from 
(select userid, product_id,count(product_id) cnt from sales group by userid, product_id) a) b 
where rnk = 1;

Q6- Which item was purchased first by customers after they become a member?

select * from  (select gu.*,rank() over (partition BY userid order by created_date ) rnk
from (select a.userid, a.created_date, a.product_id,b.gold_signup_date
from sales a inner join goldusers_signup b on a.userid = b.userid
and created_date >= gold_signup_date) gu)d where  rnk = 1; 

Q7- Rank all the transactions of the customers?

select*,rank() over(partition BY userid order by created_date ) rnk
FROM sales; 

Q8- Which item was purchased just before the customer became a member?

select * from (select c.*,rank() over (partition by userid order by created_date desc ) rnk
from (select a.userid,a.created_date,a.product_id,b.gold_signup_date from   sales a
inner join goldusers_signup b on a.userid = b.userid and created_date <= gold_signup_date) c)d
where  rnk = 1; 