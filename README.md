
CREATE TABLE inventory(
store_id INT,
product_id int NOT NULL,
stock_on_hand INT NOT NULL

);

DROP TABLE inventory;
CREATE TABLE products (
product_id SERIAL primary key,
product_name VARCHAR(50) NOT NULL,
product_category VARCHAR(50) NOT NULL,
product_cost FLOAT,
product_price FLOAT
);

CREATE TABLE sales (
sales_id SERIAL primary key,
DATE  DATE NOT NULL,
store_id INT  NOT NULL,
product_id INT,
units INT,
   FOREIGN KEY(store_id) REFERENCES stores(store_id),
	FOREIGN KEY(product_id) REFERENCES products(product_id)
);

CREATE TABLE stores (
store_id SERIAL primary key,
store_name VARCHAR(50) NOT NULL,
store_city VARCHAR(50)   NOT NULL,
store_location VARCHAR(50) NOT NULL,
store_open_date  DATE

);
  
   SELECT * FROM SALES;
   SELECT * FROM PRODUCTS;
   SELECT * FROM STORES;
  SELECT * FROM INVENTORY;
   
  SELECT 
      SUM(stock_on_hand) AS No_of_Unsold_products,
	  sum(product_cost) as Total_price_cost,
	 SUM(total_left) AS Money_Tied_Up
  FROM (
    SELECT 
	      products.product_category,
         --stores.store_name,
          products.product_cost,
		 inventory.stock_on_hand,
	   (stock_on_hand * product_cost) AS total_left
  FROM inventory  
   JOIN stores ON inventory.store_id = stores.store_id
   JOIN products ON inventory.product_id = products.product_id);
   
		
--QUESTION 1. WHICH PRODUCT CATEGORIES DRIVE THE BIGGEST PROFITS? 		
 
 SELECT Product_category,
  sum(total_profit_made) AS SUM_PROFIT
    from (
   SELECT 
 DISTINCT products.product_category,
 products.product_cost,
 products.product_price,
 sales.units,
((product_price - product_cost) * sales.units) AS Total_profit_made
  FROM sales
  JOIN 
  products ON sales.product_id = products.product_id) AS SUBQUERY
  GROUP BY 1
  ORDER BY sum_profit DESC;
   /*
   From the code above, it's evident that the product_category that drives the highest profit is 'GAMES' with a grand profit
   $3,427 and  it was followed by the product_category "TOYS" with a grand profit of $2,154 and so on until the last product_category	 
   */

-- QUESTION 1B. IS THIS SAME ACROSS ALL STORE LOCATION 
   SELECT  
  product_category,
  store_location,  
  SUM(Total_profit_made) AS Grand_profit
  FROM
  ( SELECT
   DISTINCT products.product_category,
   stores.store_location,
 products.product_cost,
 products.product_price,
 sales.units,
((product_price - product_cost) * sales.units) AS Total_profit_made
  FROM sales 
   JOIN stores ON sales.store_id = stores.store_id
   JOIN products ON sales.product_id = products.product_id
     ) AS SUBQUERY
  GROUP BY 1,2
  order by 1, 3 DESC;
   /*
       From the above code , we analyzed to check if the product_category still drives highest profit across all the 
	   store locations. It was observed that the different product category has  higher profits in different locations
	   . It is clear that 'art and crafts' product category has highest profit at DOWNTOWN.Moreover, electronics has  highest profit at
	   AIRPORT.And, games has highest profit at DOWNTOWN  and so on.
   */
   --QUESTION 2A. HOW MUCH MONEY IS TIED UP IN INVENTORY  AT THE TOYS STORE?
     
  SELECT 
      SUM(stock_on_hand) AS No_of_Unsold_products,
	  sum(product_cost) as Total_price_cost,
	 SUM(total_left) AS Money_Tied_Up
  FROM (
    SELECT 
	      products.product_category,
          products.product_cost,
		 inventory.stock_on_hand,
	   (stock_on_hand * product_cost) AS total_left
  FROM inventory  
   JOIN stores ON inventory.store_id = stores.store_id
   JOIN products ON inventory.product_id = products.product_id);
   /* from the code above we can see that the number of stock not sold is 29,742 and amounted to the grand 
     total of money been tied up to be over $300K.
   */
   
   --QUESTION 2B. HOW LONG WILL IT TAKE THE NUMBER OF STOCK ON HAND TO BE SOLD OUT?
   
  SELECT 
  SUM(total_unit_sold) as sold_unit
  from(
  SELECT 
      date,
	  --store_id,
	  sum(units) as total_unit_sold  
	  from sales	  
	 where date between '2017-01-01' and '2017-01-31'
	 -- where date between '2017-02-01' and '2017-02-28'
	 --  where date between '2017-03-01' and '2017-03-31'
	 -- where date between '2017-04-01' and '2017-04-30'
	     group by 1);
   
   select distinct date from sales;
  
   /*
       With a very close observation of the sales table,i observed that the maven toys store  usually makes
	   a huge sale above 30K+ stocks each month. Consequently, the total  stock on hand which is 29,742
	   will be sold out either in  less than a month or in a month max.  
   */
   
  --QUESTION 3. ARE SALES BEING LOST WITH OUT OF STOCK PRODUCT  AT CERTAIN LOCATION 
   
    SELECT * FROM SALES;
   SELECT * FROM PRODUCTS;
   SELECT * FROM STORES;
  SELECT * FROM INVENTORY;
   
  SELECT 
       store_name,
	   store_location,
	  -- SUM(SALES.UNITS * PRODUCTS.PRODUCT_PRICE) AS TOTAL_SALES,
	   COUNT(product_id) AS product_count
  from (
   SELECT
  distinct  stores.store_name,
	   SUM(SALES.UNITS * PRODUCTS.PRODUCT_PRICE) AS TOTAL_SALES,
   stores.store_location,
   products.product_cost,
   products.product_price,
   sales.product_id,
   products.product_name 
  FROM sales 
   JOIN stores ON sales.store_id = stores.store_id
   JOIN products ON sales.product_id = products.product_id
	  GROUP BY 1
     ) AS SUBQUERY
    GROUP BY 1,2,3
	order by product_count ASC;
   
 /*
      YES AND YES. SOME STORES DON'T HAVE THE COMPLETE PRODUCTS IN THEIR VARIOUS STORE LOCATION. LET'S TAKE
	  AN INSTANCE, THE MAVEN TOYS PUEBLA3 AT THE RESIDENTIAL LOCATION  HAS A TOTAL PRODUCTS OF 24 WITH A TOTAL OF 11 STOCK OUT OF HAND.
	  MOREOVER, MAVEN TOYS SANTIAGO1 AT THE DOWNTOWN LOCATION  HAS A TOTAL PRODUCTS OF 30 WITH 5 PRODUCTS
	  NOT STOCKED. HOWEVER, THIS DOESNT AFFECT THEIR SALES GIVEN THAT  EACH STORE MAKES THEIR PROFIT AND SALES 
	  WELL IN THEIR VARIOUS STORE LOCATIONS.       
 */

/*Since each location offers all 35 products, attention is
paid to individual stores.

An initial observation shows that not every store has 
offered all 35 products from January 2017 – September 2018. 
Of the 50 stores, 40% of them offered only 30 products or less. 
One may assume that stores which offered every product will generally 
have more sales, but this is not necessarily the case. The top two 
selling stores, Ciudad de Mexico 2 ($554,553) and Guadalajara 3 ($449,354)
only offered 30 products. Additionally, of the top 10 selling stores,
5 of them offered only 30 products.

An observation of products reveals that of the 50 stores, 24 stores
did not offer the Monopoly product, 23 stores did not offer the Chutes
& Ladders product, 22 stores did not offer the Uno Card Game product, 
and 20 stores did not offer the Classic Dominoes as well as the Mini 
Basketball Hop product. Further analysis also shows that these items 
were among the worst 10 selling products, with none exceeding $100,000 
in sales.

Offering these additional products at stores may not significantly 
increase sales as these products were not proven to have great demand.*/

SELECT DISTINCT st.store_location,
st.STORE_name, 
--SUM(s.units) AS units_sold, 
i.stock_on_hand,
SUM(s.units * p.product_price) AS units_sold
FROM sales AS s
JOIN products p ON s.Product_ID = p.Product_ID
JOIN stores AS st ON s.store_id = st.store_id
JOIN inventory i ON s.store_id = i.store_id AND s.product_id = i.product_id
WHERE i.stock_on_hand = 0
GROUP BY 1,2,3
ORDER BY 4 DESC;



select store_name,
       store_location,
	   total_unit_sold_per_store,
	   count(product_id) as number_of_product
	   from(
select 
        st.store_name,
		st.store_location,
		s.product_id,
		--p.product_price,
		--p.product_name,
		--s.units,
		sum(s.units * p.product_price) AS TOtal_unit_sold_per_store
 from sales s
  join stores st  on st.store_id = s.store_id
join products p on p.product_id = s.product_id
	   group by 1,2,3)
  group by 1,2,3
  order by 3 desc



SELECT * FROM PRODUCTS;
SELECT * FROM SALES;
SELECT * FROM INVENTORY;
SELECT * FROM STORES;




CREATE TEMPORARY TABLE SaleProfitCalc AS
SELECT 
    s.sales_id, s.date, s.store_id, s.product_id, s.units, 
    p.product_cost, p.product_price,
    (p.product_cost)*s.units AS cost_price,
    (p.product_price)*s.units AS sales,
    (((p.product_price)*s.units)-((p.product_cost)*s.units))AS profit

FROM 
sales s
JOIN products p 
ON s.product_id=p.product_id;
  select * from SaleProfitCalc;
  



SELECT 
    p.product_category,
    SUM(spc.units) AS units_sold,
    SUM(spc.sales)AS sales,
    SUM(spc.profit)AS profit
FROM
    SaleProfitCalc spc
        JOIN
    products p ON p.product_id = spc.product_id
GROUP BY p.product_category;

SELECT 
    p.product_category,
	--s.date,
	--i.stock_on_hand,
	SUM(s.units)
	--sum(i.stock_on_hand) as total_stock_on_hand,
	 --sum(s.units) as total_unit_sold
	 from products p
	 join sales s on s.product_id = p.product_id
	join inventory i ON i.product_id = p.product_id
	where p.product_category = 'Toys'
	 Group by 1;
	 
	 SELECT * FROM PRODUCTS;
SELECT * FROM SALES;
SELECT * FROM INVENTORY;
SELECT * FROM STORES;
-- TOTAL STOCK ON HAND
select 
sum(stock_on_hand) as total_stock
from inventory;
--- TOTAL UNIT SOLD FOR TOY
	 
	 SELECT P.PRODUCT_CATEGORY,
	        SUM(S.UNITS) AS SUM_UNITS
			FROM PRODUCTS P
			JOIN  SALES S ON P.PRODUCT_Id  = s.product_id
			--group by 1
			where product_category = 'Toys'
				group by 1;
	 
	SELECT 
	product_category,
	sum(total_unit_sold) as totalUnit,
	sum(total_stock_on_hand) as totalStock
	from (
	 SELECT 
	DISTINCT(P.PRODUCT_CATEGORY),
	--s.DATE ,
	(s.UNITs) as total_unit_sold,
	(i.STOCK_ON_HAND) as total_stock_on_hand
	FROM 
	  products p
	 join sales s on s.product_id = p.product_id
	 join inventory i  ON p.product_id = i.product_id
	 
	group by 1,2,3)
	group by 1;
	
	
	DROP TEMPORARY TABLE UnitsSoldDaily;
CREATE TEMPORARY TABLE UnitsSoldDaily AS
  SELECT
  s.date,
  p.product_id,
  st.store_id,
  SUM(s.units) AS units_sold
  FROM
  sales s
  JOIN stores st
  ON st.store_id=s.store_Id
  JOIN products p ON
  p.product_id=s.product_id
  GROUP BY p.product_id,st.store_id,s.date;
  SELECT * FROM unitssolddaily
  
  
  SELECT SUM( i.stock_on_hand) AS total_inventory_value
  FROM products p
  JOIN inventory i ON p.product_id = i.product_id;
  
  
SELECT distinct  st.store_location, p.product_name, s.units AS units_sold, i.stock_on_hand
FROM sales AS s
JOIN products p ON s.Product_ID = p.Product_ID
JOIN stores AS st ON s.store_id = st.store_id
JOIN inventory i ON s.store_id = i.store_id AND s.product_id = i.product_id
WHERE i.stock_on_hand = 0;
  
  
	
	
	
	CREATE TEMPORARY TABLE UnitsSoldMonthlyYearly AS
 SELECT 
       EXTRACT('YEAR' FROM usd.date) AS Year, 
	CASE 
		WHEN EXTRACT('MONTH' FROM usd.date)=1 THEN 'January'
		WHEN EXTRACT('MONTH' FROM usd.date)=2 THEN 'February'
		WHEN EXTRACT('MONTH' FROM usd.date)=3 THEN 'March'
	WHEN EXTRACT('MONTH' FROM usd.date)=4 THEN 'April'
		WHEN EXTRACT('MONTH' FROM usd.date)=5 THEN 'May'
		WHEN EXTRACT('MONTH' FROM usd.date)=6 THEN 'June'
	WHEN EXTRACT('MONTH' FROM usd.date)=7 THEN 'July'
		WHEN EXTRACT('MONTH' FROM usd.date)=8 THEN 'August'
		WHEN EXTRACT('MONTH' FROM usd.date)=9 THEN 'September'
	WHEN EXTRACT('MONTH' FROM usd.date)=10 THEN 'October'
	WHEN EXTRACT('MONTH' FROM usd.date)=11 THEN 'November'
		ELSE 'December'
    END AS Months,
	p.product_category,
	st.store_id,
    SUM(usd.units_sold) AS total_units_sold
 FROM UnitsSoldDaily usd
 JOIN products p ON p.product_id=usd.product_id
 JOIN stores st ON st.store_id=usd.store_id
 GROUP BY 1, 2,p.product_id, st.store_id;
 
 drop table UnitsSoldMonthlyYearly;
 select * from UnitsSoldMonthlyYearly
 
	 select months,
	 sum(total_units_sold)
	 from UnitsSoldMonthlyYearly
	 where product_category= 'Toys'
	 group by months
	 
	 
  
  
  SELeCT * FROM products;
SELECT * FROM stores;
SELECT * FROM sales;
SELECT * FROM inventory;
