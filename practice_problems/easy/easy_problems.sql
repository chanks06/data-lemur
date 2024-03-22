"""
Pharmacy Analytics (Part 1) [CVS Health SQL Interview Question]


CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

Definition:

cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
Total Profit = Total Sales - Cost of Goods Sold
If you like this question, try out Pharmacy Analytics (Part 2)!

pharmacy_sales Table:
Column Name	Type
product_id	integer
units_sold	integer
total_sales	decimal
cogs	decimal
manufacturer	varchar
drug	varchar

"""

-- My Solution: 

SELECT drug, (total_sales - cogs) as total_profit FROM pharmacy_sales 
order by total_profit desc limit 3;

"""
Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question]

CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with the highest losses displayed at the top.

If you like this question, try out Pharmacy Analytics (Part 3)!

pharmacy_sales Table:
Column Name	Type
product_id	integer
units_sold	integer
total_sales	decimal
cogs	decimal
manufacturer	varchar
drug	varchar
"""

--My Solution: 

-- SELECT manufacturer, FROM pharmacy_sales;

--okay first I want to find the drugs that resulted in a loss, that is if total_profit < 0 
--SELECT manufacturer, drug, (total_sales - cogs) as total_profit FROM pharmacy_sales 
--where (total_sales - cogs)  < 0;

-- okay now lets group by manufacturer and sum the total_profit

SELECT manufacturer, count(drug), sum(abs(total_sales - cogs)) as total_loss FROM pharmacy_sales 
where (total_sales - cogs)  < 0
group by manufacturer
order by total_loss desc; 


"""
Pharmacy Analytics (Part 3) [CVS Health SQL Interview Question]



"""





"""
Data Science Skills [LinkedIn SQL Interview Question]

Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

Assumption:

There are no duplicates in the candidates table.

candidates Table:
Column Name	Type
candidate_id	integer
skill	varchar
candidates Example Input:
candidate_id	skill
123	Python
123	Tableau
123	PostgreSQL
234	R
234	PowerBI
234	SQL Server
345	Python
345	Tableau
Example Output:
candidate_id
123

"""

--MY SOLUTION 

select candidate_id from candidates 
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(skill) >= 3
order by candidate_id;


"""
Histogram of Tweets [Twitter SQL Interview Question]

Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.
tweets Table:
Column Name	Type
tweet_id	integer
user_id	integer
msg	string
tweet_date	timestamp

Example Output:
tweet_bucket	users_num
1	2
2	1

The query groups the users by the number of tweets they posted and displays the number of users in each group.

"""


with cte_1 as
(select count(*) as tweet_bucket from tweets
WHERE EXTRACT(YEAR FROM tweet_date) = 2022
group by user_id)


-- this query gives us the the number of tweets per user.

-- now I have to bin the number of users per tweet count 

select width_bucket(tweet_bucket,0,4,2) as tweet_bucket, count(tweet_bucket) as users_num from cte_1
group by tweet_bucket;


"""
Page With No Likes [Facebook SQL Interview Question]

Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.
pages Table:
Column Name	Type
page_id	integer
page_name	varchar
pages Example Input:
page_id	page_name
20001	SQL Solutions
20045	Brain Exercises
20701	Tips for Data Analysts
page_likes Table:
Column Name	Type
user_id	integer
page_id	integer
liked_date	datetime
page_likes Example Input:
user_id	page_id	liked_date
111	20001	04/08/2022 00:00:00
121	20045	03/12/2022 00:00:00
156	20001	07/25/2022 00:00:00



"""

--My solution 

SELECT p.page_id FROM page_likes as pl
right join pages as p
on p.page_id = pl.page_id
where pl.liked_date is null
order by p.page_id asc; 

"""
Unfinished Parts [Tesla SQL Interview Question]

Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.

Assumptions:

    parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
    An unfinished part is one that lacks a finish_date.

This question is straightforward, so let's approach it with simplicity in both thinking and solution.

Effective April 11th 2023, the problem statement and assumptions were updated to enhance clarity.
parts_assembly Table
Column Name	Type
part	string
finish_date	datetime
assembly_step	integer
parts_assembly Example Input
part	finish_date	assembly_step
battery	01/22/2022 00:00:00	1
battery	02/22/2022 00:00:00	2
battery	03/22/2022 00:00:00	3
bumper	01/22/2022 00:00:00	1
bumper	02/22/2022 00:00:00	2
bumper		3
bumper		4
Example Output
part	assembly_step
bumper	3
bumper	4
"""

select part, assembly_step from parts_assembly 
where finish_date is null; 


"""
Laptop vs. Mobile Viewership [New York Times SQL Interview Question]
This is the same question as problem #3 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.
viewership Table
Column Name	Type
user_id	integer
device_type	string ('laptop', 'tablet', 'phone')
view_time	timestamp
viewership Example Input
user_id	device_type	view_time
123	tablet	01/02/2022 00:00:00
125	laptop	01/07/2022 00:00:00
128	laptop	02/09/2022 00:00:00
129	phone	02/09/2022 00:00:00
145	tablet	02/24/2022 00:00:00
Example Output
laptop_views	mobile_views
2	3
Explanation

Based on the example input, there are a total of 2 laptop views and 3 mobile views.

The dataset you are querying against may have different input & output - this is just an example!

"""

--I solved this problem by creating a common table expression for each category count (mobile vs. laptop), then select each aggregated column. I could also use the CASE WHEN function.

with cte_laptop as (
select count(user_id) as laptop_views from viewership
where device_type in ('laptop')
),

cte_mobile as (
select count(user_id) as mobile_views from viewership
where device_type in ('tablet','phone')
)

select laptop_views, mobile_views
from cte_laptop, cte_mobile


"""

Average Post Hiatus (Part 1) [Facebook SQL Interview Question]

Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?
posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_date	timestamp
post_content	text
posts Example Input:
user_id	post_id	post_date	post_content
151652	599415	07/10/2021 12:00:00	Need a hug
661093	624356	07/29/2021 13:00:00	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend
004239	784254	07/04/2021 11:00:00	Happy 4th of July!
661093	442560	07/08/2021 14:00:00	Just going to cry myself to sleep after watching Marley and Me.
151652	111766	07/12/2021 19:00:00	I'm so done with covid - need travelling ASAP!
Example Output:
user_id	days_between
151652	2
661093	21

"

--postgres doesn't having a datediff() function, use date_part to finding difference between dates, like so: 

select user_id, date_part('day',max(post_date) - min(post_date)) as days_between from posts 
where date_part('year', post_date) = '2021'
group by user_id 
having count(post_date) >= 2;