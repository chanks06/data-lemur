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

