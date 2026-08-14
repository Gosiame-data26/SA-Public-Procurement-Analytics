# Project Notes

## Business Problem

Public procurement generates large volumes of tender information, making
it difficult to quickly identify procurement activity, buyer concentration
and tender-duration patterns.

The objective of this project was to transform procurement data into an
interactive analytical dashboard that can support procurement monitoring
and decision-making.

## Analytical Questions

The analysis aimed to answer:

1. How many tenders are recorded?
2. Which buyers issue the most tenders?
3. What is the distribution of tender statuses?
4. Which procurement classifications have the highest tender volumes?
5. What is the average tender duration?
6. Which buyers have the longest average tender durations?
7. How many tenders remain open for 7 days or less?
8. How are tenders distributed across duration categories?

## Data Preparation

The data was investigated and prepared using SQL Server before being
analysed in Power BI.

Data quality checks included:

- Missing values
- Duplicate tender IDs
- Invalid tender durations
- Missing buyer information
- Missing procurement classifications

## Analysis

SQL was used for data exploration and analytical queries.

Power BI was then used to develop an interactive dashboard containing
summary KPIs, charts, filters and performance indicators.

## Key Findings

The completed dashboard highlights:

- Overall tender volume
- Buyer concentration
- Procurement classification patterns
- Tender status distribution
- Tender-duration patterns
- Buyers with high average tender durations
- Short-duration procurement activity

## Limitations

The analysis is dependent on the available procurement records and fields
contained within the source dataset.

The dashboard should therefore be interpreted as an analytical view of the
available data rather than a complete representation of all South African
public procurement activity.

## Future Improvements

Potential extensions include:

- Supplier-level analysis
- Award-value analysis
- Geographic procurement analysis
- Year-over-year procurement trends
- Supplier concentration metrics
- Procurement cycle-time monitoring
- Automated data refresh
