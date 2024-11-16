
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
	   COUNT(product_id) AS product_count
  from (
   SELECT
  distinct  stores.store_name,
   stores.store_location,
   products.product_cost,
   products.product_price,
   sales.product_id,
   products.product_name 
  FROM sales 
   JOIN stores ON sales.store_id = stores.store_id
   JOIN products ON sales.product_id = products.product_id
     ) AS SUBQUERY
    GROUP BY 1,2
	order by product_count ASC;
   
 /*
      YES AND YES. SOME STORES DON'T HAVE THE COMPLETE PRODUCTS IN THEIR VARIOUS STORE LOCATION. LET'S TAKE
	  AN INSTANCE, THE MAVEN TOYS PUEBLA3 AT THE RESIDENTIAL LOCATION  HAS A TOTAL PRODUCTS OF 24 WITH A TOTAL OF 11 STOCK OUT OF HAND.
	  MOREOVER, MAVEN TOYS SANTIAGO1 AT THE DOWNTOWN LOCATION  HAS A TOTAL PRODUCTS OF 30 WITH 5 PRODUCTS
	  NOT STOCKED. HOWEVER, THIS DOESNT AFFECT THEIR SALES GIVEN THAT  EACH STORE MAKES THEIR PROFIT AND SALES 
	  WELL IN THEIR VARIOUS STORE LOCATIONS.       
 */


















  
  
  
  
  
  
  
  
  
  
  
  
