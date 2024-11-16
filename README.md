# MAVEN TOYS ANALYSIS

![toys](https://github.com/user-attachments/assets/8ea1d099-76b7-4bbc-bdf0-24f5c7a84ab5)

# Introduction 
Maven Toys is a fun and creative toy company that goes beyond regular play. They believe in making toys that not only entertain but also inspire imagination. As a top player in the toy industry, their goal is to create special moments for kids. Now, they’re using data analysis to bring even more joy to families.

# Business Problem

In this project, I will be assuming the role of a BI consultant who has just been hired by this fictional company — Maven Toys. As they look to expand their business with new stores, they’ve brought me in to analyze interesting patterns and trends in their data  by answering some questions using SQL and help them make informed decisions.

# Business Objective

Maven Toys major objective is to expand their business with new stores. Based on historical data from January 2017 to September 2018, they have posed the following business questions to help them make a decision:

1. WHICH PRODUCT CATEGORIES DRIVE THE BIGGEST PROFITS?
   
1b. IS THIS SAME ACROSS ALL STORE LOCATION?

2.  HOW MUCH MONEY IS TIED UP IN INVENTORY  AT THE TOYS STORE?
   
2b.  HOW LONG WILL IT TAKE THE NUMBER OF STOCK ON HAND TO BE SOLD OUT?

3.  ARE SALES BEING LOST WITH OUT OF STOCK PRODUCT  AT CERTAIN LOCATION?

# Data Collection

The data used within this project is provided from the following link:
Maven Toys Sales | Kaggle

We are given four tables in CSV format which contain the following fields:

Products (35 unique products)

Product_ID - Unique ID given to each product offered
Product_Name - Unique name given to each product offered
Product_Category - Category group assigned to each product based on its characteristics/utility
Product_Cost - Expense incurred for making/attaining the product, in US dollars
Product_Price - Price at which the product is sold to customers, in US dollars
Stores (50 different stores)

Store_ID - Unique store ID given to each toy store
Store_Name - Unique store name given to each toy store
Store_City - City in Mexico where the store is located
Store_Location - Classification of location in the city where the store is located (Downtown,
Commercial, Residential, Airport)
Store_Open_Date - Date when the store was opened
Sales

Sale_ID - Unique Sale_ID for each transaction conducted in a store
Date - Date on which the transaction occurred
Store_ID - Unique store ID given to each toy store
Product_ID - Unique ID given to each product offered
Units - No of units of the product sold
Inventory:

Store_ID - Unique store ID given to each toy store
Product_ID - Unique ID given to each product offered
Stock_On_Hand - Stock quantity of the product in the store

# Insights 
## 1. Which product categories drive the biggest profits? Is this the same across store locations?

 The Toys and Electronics categories emerged as the most profitable product segments for Maven Toys from January 2017 to September 2018, generating $1.08 million and $1.0 million in profits, respectively. Together, they accounted for over 50% of the company's total profit.

Within the Toys category, Lego Bricks and Action Figures dominated profits, contributing a combined $646,433 with profit margins of 12.5% and 37.5%, respectively.

In the Electronics category, Colorbuds stood out as the most profitable product, returning $834,944 in profit, making it not only the leader in its category but also the most profitable product across the entire company. With an impressive profit margin of 53.4%, Colorbuds contributed 20.8% of Maven Toys' total profits.

At the store level, the trend of Toys and Electronics being the top-performing categories persisted:

Electronics led profitability at the Airport ($108,197) and Commercial ($287,574) locations.
Toys was the most profitable at Downtown ($630,029) and Residential ($136,214) locations.

## 2. How much money is tied up in inventory at the toy stores? How long will it last?

Maven Toys projects $410,000 in sales and $110,000 in profit across all stores based on the current inventory, assuming product costs and prices remain unchanged.

Currently, there are 29,742 units of products available across all stores. However, this inventory level is insufficient to meet the monthly customer demand, as the average monthly sales volume is approximately 52,000 units. It is important to note that stock adequacy varies by store location.

Despite a decline in units sold over the past three months, the overall trend shows an upward trajectory in the average number of units sold. Based on historical patterns, demand over the next three months is expected to surpass the current monthly average. If this trend persists, Maven Toys will need to secure inventory exceeding the monthly average to meet year-end demand effectively.

## 3. Are sales being lost with out-of-stock products at certain locations?

Although all 35 products are available at every location, a closer look at individual stores reveals significant variations in product offerings.

From January 2017 to September 2018, not all 50 stores offered the full range of 35 products. In fact, 40% of stores carried 30 or fewer products. While it may seem logical that offering every product would result in higher sales, this is not always the case. For instance, the top two selling stores, Ciudad de Mexico 2 ($554,553) and Guadalajara 3 ($449,354), offered only 30 products. Similarly, half of the top 10 performing stores offered 30 products or fewer.

Product-level analysis shows that certain items were frequently excluded:

Monopoly was not offered at 24 stores.
Chutes & Ladders was missing in 23 stores.
Uno Card Game was unavailable at 22 stores.
Both Classic Dominoes and Mini Basketball Hoop were absent in 20 stores.
These five products ranked among the 10 worst-selling items, with none generating over $100,000 in sales.

