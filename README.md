# End-to-End Sales Analytics, Cohort Analysis & Sales Forecasting

##  Project Overview
This repository contains an end-to-end data analytics and machine learning project built using a retail sales dataset.  
The project covers the complete analytics lifecycle — from data extraction and analysis using SQL, visualization using Tableau, to sales forecasting using Python and machine learning.



##  Business Objectives
- Analyze historical sales performance and identify key trends
- Understand customer retention behavior using cohort analysis
- Forecast future sales using machine learning models
- Present insights through interactive dashboards



##  Project Components

### 1 Sales Analytics (SQL + Tableau)
**Goal:** Understand sales performance across time, categories, and products.

**Key Work:**
- Analyzed monthly and yearly sales trends
- Identified top-performing products and categories
- Created KPI metrics such as total sales and total orders
- Built an interactive Tableau dashboard for business users

 SQL Queries: `sql/Sales analytics SQL file.sql`  
 Tableau Dashboard: Available in `tableau/README.md`



### 2 Customer Cohort Analysis (Advanced SQL + Tableau)
**Goal:** Analyze customer retention and repeat purchase behavior.

**Key Work:**
- Defined customer cohorts based on first purchase month
- Calculated cohort index using date arithmetic
- Computed retention percentages using SQL window functions
- Visualized retention patterns using a Tableau cohort heatmap

 SQL Queries: `sql/Cohort Analysis.sql`  
 Tableau Cohort Dashboard: Available in `tableau/README.md`

### 3 Sales Forecasting (Machine Learning)
**Goal:** Predict future sales using historical data.

**Key Work:**
- Aggregated monthly sales data using SQL
- Built a naive baseline model using previous month sales
- Developed a Linear Regression model for sales forecasting
- Evaluated model performance using Mean Absolute Error (MAE)
- Visualized actual vs predicted sales trends

 Notebook: `ml/sales_forecasting.ipynb`  
 Dataset: `ml/monthly_sales.csv`

##  Tools & Technologies
- **SQL (PostgreSQL)** – Data extraction, aggregation, cohort analysis
- **Python** – Pandas, Matplotlib, Scikit-learn
- **Tableau Public** – Interactive dashboards & cohort heatmaps
- **GitHub** – Version control and project documentation

##  Key Learnings
- Built professional SQL queries including joins, subqueries, and window functions
- Learned how to analyze customer retention using cohort analysis
- Implemented baseline and machine learning models for forecasting
- Understood the importance of comparing ML models with naive benchmarks
- Structured a clean, recruiter-friendly GitHub repository

##  Tableau Dashboards
Interactive dashboards can be accessed via Tableau Public links inside:




##  Author
**Sagar**  
Aspiring Data Analyst / Data Scientist  
Skilled in SQL, Python, Tableau, and Machine Learning
