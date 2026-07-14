# [Olist E-Commerce Performance Analysis]
> *Uncovering the Drivers of Revenue, Customer Churn, and Logistics Inefficiencies to Drive Data‑Informed Business Decisions.*

---

## Project Type Flags

- Data Cleaning
- Exploratory Data Analysis (EDA)
- SQL Analysis
- Data Visualization

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Objectives](#2-objectives)
3. [Project Scope & Tools](#3-project-scope--tools)
4. [Data Workflow](#4-data-workflow)
5. [ERD - Entity Relationship Diagram](#5-erd--entity-relationship-diagram)
6. [Key Insights](#6-key-insights)
7. [Recommendations](#7-recommendations)
8. [Author](#8-author)

---

## 1. Project Overview

Olist is a Brazilian marketplace connecting sellers to customers across multiple product categories. As an online platform, it faces common e‑commerce challenges: understanding revenue drivers, reducing customer churn, optimizing delivery logistics, and identifying profitable product segments. Part of he analysis of this project revealed that the over-estimation of the delivery days prompted some of the customers to cancel their orders which caused the business a potential profit. This project was motivated by the need to turn raw transactional data into actionable business intelligence.

**Problem Statement:** How can Olist increase revenue, improve customer retention, and reduce logistics inefficiencies?  
Specifically:  
- Which products and regions drive revenue?  
- Why do customers not return after their first purchase?  
- What is causing orders cancellations by customers?
- How do freight costs vary by region and product category, and what does that imply for profitability?


**Approach:** I performed end‑to‑end analysis using SQL (MySQL Workbench) for data extraction, cleaning and analysis, Power BI for interactive dashboards. The project included RFM segmentation, geospatial distance calculations, and a detailed review of sales, customer behaviour, product performance, logistics, and payment patterns. All filtered to delivered orders for accurate revenue metrics.

**Outcome:** 
- **Sales & Revenue:** Identified top‑performing products and regions, discovered that revenue growth stalled in late 2018 due to no data, with R$95,235 lost to cancellations.
- **Customer Behaviour:** Conversion rate at 10%, 90% churn rate. All customers are one‑time buyers; RFM segmentation revealed “High‑Value New” and “At Risk” segments for targeted retention.
- **Logistics:** 93% on‑time delivery but over‑estimated delivery days caused R$10,650 freight revenue loss. Sellers concentrated in Sao Paulo, leading to more than 20-day deliveries and high freight costs in remote regions.
- **Actionable Recommendations:** Adjust delivery estimation algorithm, launch loyalty programs, rationalize product portfolio, and recruit sellers in underserved areas.

  The SQL Queries used to analyze and aggregate the data for this project can be found here: (https://tinyurl.com/pufb695a)

  Dashboard visuals can be found here: (https://tinyurl.com/bdh8a72h)

  The interactive dashboard can be found here: [Microsoft Power BI](https://tinyurl.com/mu4t7sj9)


---

## 2. Objectives

- **Primary Objective:** To identify the key drivers of revenue, customer churn, and logistics inefficiencies in the Olist marketplace
- **Secondary Objective 1:** To quantify sales performance
- **Secondary Objective 2:** To evaluate customer retention and logistics effectiveness

---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | Olist Brazilian E‑commerce Dataset (public), Analysis covers Revenue, Customer behaviour, Logistics and Product category performance |
| **Out of Scope** | Sellers' profitability, Customer demographics and Marketing spend data were excluded |
| **Time Period** | Sep 2016 - Oct 2018 |
| **Granularity** | order_items (each product in an order), reviews (each review).  **Order‑level:** orders (each order), payments (each payment method). **Customer‑level:** customers (for RFM and churn).  **monthly aggregates** for time‑series charts (revenue trends, growth rates). |

### Tools & Technologies

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage | CSV files |
| Data Processing | SQL, Excel |
| Analysis | SQL queries |
| Visualization | Power BI |
| Version Control | GitHub |
| Documentation | Markdown |

---

## 4. Data Workflow

Data Source
      >
Ingestion
      >
Cleaning & Transformation
      >
Analysis & Modelling
      >
Visualisation & Reporting

1. **Source:**  The Olist Brazilian E‑commerce dataset (publicly available on Kaggle).
   **Format:** 9 interconnected CSV files.
   **Tables used:** orders, order_items, products, customers, sellers, geolocation, order_payments, order_reviews, marketing_qualified_leads, closed_deals.  
   **Time period:** September 2016 – October 2018.

2. **Ingestion:** **CSV → SQL:** CSV files were imported into MySQL Workbench using LOAD IMPORT WIZARD.  
                  Also loaded into Power BI via “Get Data → Text/CSV” 

3. **Cleaning:** **Missing dates:** Replaced `"NULL"` with `n/a` in delivery date columns.  
   **Data types:** Converted price, freight_value, payment_value to DECIMAL; date columns to DATETIME.  
   **Duplicates:** Removed duplicate order rows.  
   **Null categories:** Filled empty product_category_name with `"n/a"`.  
   **Outliers:** Flagged orders with price = 0 or negative for investigation (excluded from revenue metrics).

4. **Transformation:** DeliveryDays (delivered date – purchase date)   EstDeliveryDays (estimated delivery date – purchase date)  
   -Distance_km (Haversine formula between seller and customer geolocations)  
   - Revenue R$ - InstallmentGroup (1 = “Full payment”, 2‑3 = “Short term”, 4‑6 = “Medium”, 7-12 = “Long”, 13+ = “Extended”)  
   - **Aggregated tables:**  
   - RFM table (customer‑level: Recency, Frequency, Monetary)  
   - SalesMonthly (revenue, orders, AOV by month)  
   - CategoryPerformance (revenue, units, freight % by product category)  
   - **Star schema:** Built Date table related to orders on order_purchase_timestamp.

5. **Analysis:** **Exploratory Data Analysis (EDA):** Distribution plots, time series (SQL + Power BI).  
   - **RFM segmentation:** Ntile (Recency, Frequency, Monetary) to identify customer segments.
   - **Geospatial analysis:** Distance calculation to compare estimated delivery days vs. actual distance (scatter plot).  
   - **Statistical summaries:** Median, Ntiles, averages for delivery times, freight costs, review scores.
   - **Business KPI measures (DAX):**  - Total Revenue, Total Orders, AOV, OnTimeDeliveryRate, Churn Rate, Revenue per Lead, etc.  
   - **Hypothesis testing:** Proved that over‑estimated delivery days for short distances drive cancellations in São Paulo.

6. **Output:** **Interactive Power BI dashboard** (4 pages) 
  - Executive Summary (KPIs, revenue trend, top products)  
  - Sales & Revenue (monthly / yearly, category, region)  
  - Customer Behaviour (RFM segments, churn rate, conversion funnel)  
  - Product Performance (price vs. volume matrix, review scores)  
  - Logistics & Delivery (on‑time rate, map of delivery days, freight % by region/category)  
  - Payment & Marketing (payment distribution, conversion rate by channel, revenue per lead)  
  - **SQL scripts** (GitHub) – all queries used for extraction, cleaning, and analysis.  
  - **Executable DAX measures** (ready to copy into any Power BI model).  
  - **This documentation** – complete pipeline, findings, and recommendations.

---

## 5. ERD - Entity Relationship Diagram

 https://tinyurl.com/bdz3svf9

**Core schema of the Olist dataset** – orders as the central fact table (99,441 records) connected to customers, payments, reviews, and order items, which join to products and sellers. Geolocation links to customers and sellers via zip codes. Marketing leads join to closed deals.

---

## 6. Key Insights

**Insight 1: Revenue is volume‑driven, not price‑driven – most products are low‑price, low‑volume.**

 **Findings:** A scatter plot of price vs. quantity (bubble size = total revenue) showed that the vast majority of products cluster in the bottom‑left quadrant (low price, low volume). Only a handful of products drive revenue through high volume (bottom‑right) or high price (top‑left). The top 10 products by revenue and units sold account for a disproportionate share of sales (Health_Beauty, Watches_Gifts, Bed_Bath_Table, Sports_Leisure, Computer_Accessories, Furniture_Decor, Cool_Stuff, Housewares, Auto, Garden_Tools). 
 Visuals(https://tinyurl.com/ycxn9tau)
 Visuals(https://tinyurl.com/53b8zcc4)

 **Meaning:** Olist’s catalog is dominated by slow‑moving, low‑value items. The business relies on a few “hero” products. This creates vulnerability: if those products face stockouts or competition, overall revenue could drop significantly. Rationalising the portfolio, discontinue or discount bottom‑left products, promote heavy‑hitters, and experiment with bundling to move volume.

 


**Insight 2: 90% of customers never return, zero repeat purchases, over‑estimated delivery days and geographic concentration.**

**Findings:** Churn rate is 90% (customers with no purchase in the last 90 days). All customers are one‑time buyers and most of the converted leads from the total leads generated (B2B customers) were from an unknown channel (16.65%) . Cancellations in Sao Paulo (the largest market) are strongly correlated with estimated delivery days being far too high, even when the seller is geographically close. Scatter plot of distance (km) vs. estimated delivery days shows a cluster of canceled orders at short distance (<500 km) with high estimates (>15 days) which cost the Brazilian e-commerce R$95,235 in potential revenue.
Visuals(https://tinyurl.com/23errwv3)
Visuals(https://tinyurl.com/4z2b2vca)

 **Meaning:** The delivery estimation algorithm is broken for short distances. Customers trust the platform but are forced to cancel when they see unrealistic long promises. The lack of repeat purchases also signals no loyalty programme, no post‑purchase engagement, and no incentive to return. Fixing the estimate logic (e.g., reduce to 3‑5 days for short distances) could recover a significant portion of lost revenue and potentially improve retention. Also, add tracking parameters to uncover real source of generated leads for optimization

 


**Insight 3: Freight costs eat disproportionately into revenue for remote regions and heavy product categories.**

**Findings:** Freight cost as a percentage of product price is 2× higher in northern states (AM, RR, PA) than in Sao Paulo, even for identical products. Heavy categories (furniture, electronics) have freight percentages >20% in remote areas. Despite that, sellers are heavily concentrated in Sao Paulo, forcing long, expensive shipments.
Visuals(https://tinyurl.com/4z2b2vca)

**Meaning:** The current logistics model is unfair to both customers and sellers in remote regions. Olist is missing out on potential demand because shipping is prohibitively expensive and slow. Opening regional fulfilment centres (e.g., Manaus, Fortaleza) and incentivising local sellers could slash delivery times and freight costs, making those markets profitable.




**Insight 4: Credit cards dominate, but 52% of orders use instalments and long‑term instalments carry higher default risk.**

**Findings:** 75% of orders use credit cards, and 52% of orders are paid in instalments (1‑12+ instalments). Orders with 7+ instalments (12% of total) have 40% higher average order value but also show a higher rate of cancelled payments (as inferred from payment approval delays and cancellations). Full payment (1 instalment) accounts for 48% of orders.
Visuals(https://tinyurl.com/ycxn9tau)

**Meaning:** While instalments drive higher basket sizes, they also introduce financial risk. Olist should implement tiered fraud checks: flag orders with >6 instalments, high value, and new accounts for manual review. Also, offering a small discount for full payment could improve cash flow and reduce default exposure. The data supports that most customers can afford to pay upfront – 48% already do.

---

## 7. Recommendations

**1. Sales & Product Strategy**
- Since	customers are more inclined towards not too cost and not too cheap products hence, the top performing products being volume based. Promote top‑performing products by Featuring the 10 revenue‑driving Stock Keeping Units on homepage and in retargeting campaigns to stabilize and increase revenue. 
- Rationalize the catalog; Discontinue or discount bottom‑left quadrant products (low price, low volume) to reduce inventory costs and simplify operations. 

**2. Customer Retention & Churn Reduction**

- Though, the e-comm brand always acquire more customers which increases its revenue yearly but it struggles with one-time buyers and most of the products have a long replacement cycle. Launch a loyalty program to encourage repeat purchase and post-purchase email sequence can also be established to keep the brand on the top of mind
- Fix delivery estimation algorithm for short distances by reducing the estimates from 10–15 days to 5–7 days. This directly addresses the main reason for cancellations in São Paulo. It would help recover lost freight revenue and lower cancellations.

**3. Logistics & Freight Optimization**
- Open regional fulfilment centres; Pilot in Manaus (Amazonas) and Fortaleza (Ceará) to serve the North and Northeast. It would cut delivery time from >20 days to <7 days, reduce freight cost %. 
- Recruit sellers in underserved states to reduce average distance per order and improve delivery speed. some of the distant regions make more purchase.

**4. Payment & Risk Management**
- Offer a small discount for full payment (1-2%) to Incentivize customers to pay upfront, improve cash flow and reduce default risk. 

**5. Marketing & Lead Conversion**
- Shuffling between two channel is what is best but the best performing channel is unknown. The “unknown” channel should be investigated by adding a tracking parameter to all marketing campaigns to identify the source that currently drives 16% conversion (the highest) and scale the best‑performing channel while it substitutes with Paid search (12%) and can as well replace with Organic search (11%) to reduce cost of marketing.

---

## 8. Author

**[Eritosin Salami]**
[Data Analyst]

- 🔗 [www.linkedin.com/in/eritosin-salami]
- 💼 [https://github.com/EritosinSalami]
- 📧 [salamieritosinlearn@gmail.com]

---

*Last updated: [June 2026]*
