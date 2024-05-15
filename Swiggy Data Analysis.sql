Select * from swiggy;

--WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

select top 1 city,count(distinct restaurant_name) 
as restaurant_count from swiggy
group by city
order by restaurant_count desc;

--HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

select count(distinct restaurant_name) 
as high_rated_restaurants
from swiggy where rating>4.5;

--HOW MANY RESTAURANTS HAVE THE WORD "TANDOOR" IN THEIR NAME?

select count(distinct restaurant_name) as tandoori_restaurants
from swiggy where restaurant_name like '%Tandoor%';

--HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?

select count(distinct restaurant_name) as pizza_restaurants
from swiggy where restaurant_name like '%Pizza%';

--WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

select city, avg(rating) as average_rating
from swiggy group by city;

--WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS?

select top 1 cuisine,count(*) as cuisine_count
from swiggy
group by cuisine
order by cuisine_count desc;

--FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE

select distinct top 5 restaurant_name,cost_per_person
from swiggy where cuisine!='Indian'
order by cost_per_person desc;

--WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?

select distinct restaurant_name,
menu_category,max(price) as highestprice
from swiggy where menu_category='Recommended'
group by restaurant_name,menu_category;

--FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

select distinct restaurant_name,cost_per_person
from swiggy where cost_per_person>(select avg(cost_per_person) from swiggy);

--RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

select distinct a.restaurant_name,a.city,b.city
from swiggy a inner join swiggy b 
on a.restaurant_name=b.restaurant_name and
a.city<>b.city;

--WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?

select distinct top 1 restaurant_name,menu_category
,count(item) as no_of_items from swiggy
where menu_category='Main Course' 
group by restaurant_name,menu_category
order by no_of_items desc;

--LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.

SELECT restaurant_name,(COUNT(CASE WHEN veg_or_nonveg = 'Veg' THEN 1 END) * 100.0 / COUNT(*)) AS vegetarian_percentage
FROM swiggy GROUP BY restaurant_name
HAVING (COUNT(CASE WHEN veg_or_nonveg = 'Veg' THEN 1 END) * 100.0 / COUNT(*)) = 100.00
ORDER BY restaurant_name;

--WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct top 5 restaurant_name,
count(distinct menu_category) as no_of_categories
from swiggy
group by restaurant_name
order by no_of_categories desc;

--WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select distinct top 1 restaurant_name,
(count(case when veg_or_nonveg='Non-veg' then 1 end)*100
/count(*)) as nonvegetarian_percentage
from swiggy
group by restaurant_name
order by nonvegetarian_percentage desc;
