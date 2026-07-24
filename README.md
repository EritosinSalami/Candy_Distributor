# [Candy Distributor Sales Analysis]
>  The US Candy Distributor dataset contains sales and geospatial shipment data for a US national candy distributor. It covers customer orders, product details, factory locations, and regional sales targets. Using Power BI and a structured data warehouse, I explore sales trends, product performance, and geospatial patterns from factory to customer delivery. The goal is to generate actionable insights that help optimize product strategy, enhance regional performance, and support data-driven business decisions.

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [ProjectTools](#3-project-tools)
3. [Data Workflow](#4-data-workflow)
4. [ERD - Entity Relationship Diagram](#5-erd--entity-relationship-diagram)
5. [Key Insights](#6-key-insights)
6. [Recommendations](#7-recommendations)
7. [Author](#8-author)

---

## 1. Project Overview
The US candy distributor was missing out on potential revenue due to massive underlying costs on a particular product line and if fixed, would add $1,500+ in pure profit without selling a single extra unit.


**Problem Statement:** 
- What are the most efficient factory-to-customer shipping routes? 
- What are the least efficient factory-to-customer shipping routes? 
- Which product lines have the best product margin?
- Which product lines should be moved to a different factory to optimize profitability?


**Approach:** I performed a complete end-to-end analysis by building a Medallion-architecture data warehouse in SSMS, using SQL for data extraction, transformation, and cleaning and developed interactive dashboards in Power BI.


  The SQL Queries used to analyze and aggregate the data for this project can be found [here](https://tinyurl.com/pfekt7pm)

  Dashboard visuals can be found here:

  The interactive dashboard can be found here: [Microsoft Power BI]


---

## 2. Tools

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

## 3. Data Workflow

Data Source
      >
Ingestion
      >
Cleaning & Transformation
      >
Analysis & Modelling
      >
Visualisation & Reporting

---

## 4. ERD - Entity Relationship Diagram
![](https://tinyurl.com/5xm4jepu)
 
---

## 5. Key Insights and Recommendations

**Insights**
- **Lot’s O’ Nuts** consistently generates $2.46–$2.47 profit per unit across Atlantic, Pacific, and Interior regions while **Wicked Choccy’s** consistently generates $2.27–$2.29 profit per unit across its regions indicating their production efficiency.
- New York City, Los Angeles and Philadelphia are the absolute center routes for both factories (highest order volumes and total profit). **Lot’s O’ Nuts** successfully services Seattle (Pacific) and Houston (Interior) with high efficiency but **Wicked Choccy's** does not appear in Seattle or Houston.
- The fact that profit per unit is fixed at $0.25 regardless of city, region, or units sold with an order volume of exactly 1 means "**The Other Factory**" has a cost structure problem. Fulfilling a single order incurs massive fixed costs and these routes are actively losing money for the business.
- **Sugar takes** the crown for the highest profit margin at 68.10% with few orders. It contributes less than 0.3% of the total company profit. This margin is as a result of a statistical anomaly (a single high-priced bulk order and some products with extremely less raw material cost) meanwhile, **Chocolate** delivers massive absolute profit while maintaining high efficiency. it scales to thousands of orders without margin erosion.
- **Other** is drastically underperforming, sitting 22.5 % points below **Chocolate** and **Sugar**. It generates more orders (310) than **Sugar**, but due to the low margin, it only produces $4,380 in profit, less than 5% of **Chocolate**'s profit indicating hidden high cost even though it has the highest revenue per unit and profit per unit.
- **Secret Factory** is 25-30x more efficient per unit on a weighted basis compared to the two underperforming factories (**Sugar Shack** and **The Other Factory**) producing Other products.
<br>

 **Recommendations:** 
- The sales teams at **Lot’s O’ Nuts** and **Wicked Choccy's** should focus on pushing more units through the existing high-volume hubs (New York, Los Angeles and California) across the Atlantic, pacific and interior regions rather than hunting for new cities, to maximize total profit.
- **Wicked Choccy's** should consider expanding distribution to Seattle and Houston, since **Lot’s O’ Nuts** proves these routes are profitable ($2.47 per unit).
- Raw materials supply and long-term shipping contracts for **chocolate** must be secured and double down on marketing.
- **Other** isn't unprofitable, it just has massive underlying costs. Reduce the unit cost to boost its profit margin. The raw revenue is there, the cost structure is the problem. Fix the supply chain.
- Move **Sugar** from **Sugar Shack Factory**  and "**Other**" lines from **Sugar Shack** and **The Other Factory** to **Secret Factory** for profit improvement.
<br>

**NOTE**: shipping dates were corrupted and some of the customers had no distance data (longitude, latitude)

## 6. Author

**[Eritosin Salami]**
[Data Analyst]

- 🔗 [www.linkedin.com/in/eritosin-salami]
- 💼 [https://github.com/EritosinSalami]
- 📧 [salamieritosinlearn@gmail.com]

---

*Last updated: [June 2026]*
