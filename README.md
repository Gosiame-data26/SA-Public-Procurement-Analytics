# SA Public Procurement Analytics

## Power BI | SQL Server | Data Analysis

An end-to-end data analytics project analysing South African public procurement tender data to identify procurement activity, buyer concentration, tender status patterns and tender-duration trends.

The project demonstrates the use of **SQL Server, Power BI, DAX and data visualisation** to transform raw procurement data into actionable business insights.

---

## Dashboard Preview

### Procurement Overview

![Procurement Overview](Screenshots/Procurement%20Overview.png)

### Procurement Performance

![Procurement Performance](Screenshots/Procurement%20Performance.png)

---

# Business Problem

Public procurement involves large volumes of tender information across different organisations, classifications and procurement stages.

Without effective analysis, it can be difficult to quickly identify:

- Which organisations issue the most tenders
- How procurement activity is distributed
- Which procurement classifications dominate
- How long tender processes typically remain open
- Which buyers have relatively long tender durations
- How many tenders are open for short periods

This project converts procurement data into an interactive analytical dashboard designed to support **procurement monitoring, performance analysis and decision-making**.

---

# Analytical Questions

The analysis focuses on the following questions:

1. How many tenders are recorded?
2. How many buyers are represented?
3. What is the distribution of tender statuses?
4. Which buyers issue the most tenders?
5. Which procurement classifications have the highest tender volumes?
6. What is the average tender duration?
7. Which buyers have the highest average tender duration?
8. How are tenders distributed across duration categories?
9. How many tenders are open for 7 days or less?
10. What proportion of tenders are open for 7 days or less?

---

# Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL Server | Data exploration, querying and validation |
| SQL | Data analysis and aggregation |
| Power BI | Dashboard development and visualisation |
| DAX | Analytical measures and KPIs |
| Power Query | Data preparation and transformation |
| GitHub | Version control and portfolio documentation |

---

# Project Structure

```text
SA-Public-Procurement-Analytics
│
├── Data
│   └── README.md
│
├── Documentation
│   ├── project_notes.md
│   └── data_dictionary.md
│
├── PowerBI
│   ├── SA_Public_Procurement_Analytics.pbix
│   └── README.md
│
├── SQL
│   ├── 01_Data_Exploration.sql
│   ├── 02_Procurement_Performance.sql
│   └── 03_Data_Quality_Checks.sql
│
├── Screenshots
│   ├── Procurement Overview.png
│   ├── Procurement Performance.png
│   └── README.md
│
└── README.md
