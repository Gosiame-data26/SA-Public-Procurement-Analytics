# Data Dictionary

## Overview

This document describes the key fields used in the South African Public
Procurement Analytics project.

| Field | Description | Analytical Use |
|---|---|---|
| TenderID | Unique identifier for a tender | Tender counting and identification |
| BuyerName | Organisation responsible for the procurement | Buyer-level analysis |
| TenderStatus | Current status of the tender | Status distribution |
| ProcurementClassification | Classification of the procurement | Classification analysis |
| TenderStartDate | Date the tender process started | Trend analysis |
| TenderEndDate | Date the tender process ended | Duration analysis |
| TenderDurationDays | Duration of the tender in days | Performance analysis |
| BuyerID | Identifier associated with the buyer | Buyer relationships |
| TenderDescription | Description of the procurement | Procurement context |

## Derived Fields

### Duration Category

Tender duration was grouped into the following categories:

- 0–7 Days
- 8–14 Days
- 15–30 Days
- 31+ Days

These categories were used to analyse the distribution of procurement
tender durations.

## Key Measures

The Power BI dashboard includes measures for:

- Total Tenders
- Total Buyers
- Total Awards
- Total Contracts
- Average Tender Duration
- Longest Tender Duration
- Shortest Tender Duration
- Tenders Open ≤ 7 Days
- % of Tenders Open ≤ 7 Days
- Top 10 Tender Share
