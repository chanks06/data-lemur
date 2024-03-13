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