-- DATABASE CREATION & VERIFICATION --

CREATE DATABASE SAPublicProcurement;
GO

USE SAPublicProcurement;
GO

SELECT DB_NAME() AS CurrentDtabase;
GO

-- STAGING TABLE CREATION --

CREATE TABLE Stg_OCDS_Releases
(
    [ocid] NVARCHAR(100),
    [id] NVARCHAR(100),
    [date] DATETIME2,
    [tag] NVARCHAR(100),
    [initiationType] NVARCHAR(100),
    [tender_id] NVARCHAR(100),
    [tender_title] NVARCHAR(500),
    [tender_description] NVARCHAR(MAX),
    [tender_status] NVARCHAR(100),
    [tender_procurementMethod] NVARCHAR(100),
    [tender_procurementMethodDetails] NVARCHAR(500),
    [tender_mainProcurementCategory] NVARCHAR(100),
    [tender_additionalProcurementCategories] NVARCHAR(500),
    [tender_value_amount] DECIMAL(18,2),
    [tender_value_currency] NVARCHAR(10),
    [tender_minValue] DECIMAL(18,2),
    [tender_maxValue] DECIMAL(18,2),
    [tender_tenderPeriod_startDate] DATETIME2,
    [tender_tenderPeriod_endDate] DATETIME2,
    [tender_submissionMethod] NVARCHAR(500),
    [tender_submissionMethodDetails] NVARCHAR(MAX),
    [tender_documents] NVARCHAR(MAX),
    [tender_procuringEntity_id] NVARCHAR(100),
    [tender_procuringEntity_name] NVARCHAR(500),
    [buyer_id] NVARCHAR(100),
    [buyer_name] NVARCHAR(500),
    [awards_id] NVARCHAR(100),
    [awards_title] NVARCHAR(500),
    [awards_status] NVARCHAR(100),
    [awards_date] DATETIME2,
    [awards_value_amount] DECIMAL(18,2),
    [awards_value_currency] NVARCHAR(10),
    [awards_suppliers_name] NVARCHAR(500),
    [contracts_id] NVARCHAR(100),
    [contracts_status] NVARCHAR(100),
    [contracts_period_startDate] DATETIME2,
    [contracts_period_endDate] DATETIME2,
    [contracts_milestones_id] NVARCHAR(100),
    [contracts_milestones_title] NVARCHAR(500),
    [contracts_milestones_type] NVARCHAR(100),
    [contracts_milestones_description] NVARCHAR(MAX),
    [contracts_milestones_dueDate] DATETIME2
);
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Stg_OCDS_Releases';
GO

SELECT COUNT(*) AS NumberOfRows
FROM Stg_OCDS_Releases;
GO

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Stg_OCDS_Releases'
ORDER BY ORDINAL_POSITION;
GO

-- TABLE DROPPING DUE TO A MISMATCH IN SQL COLUMNS AND ORIGINAL/SOURCE EXCEL DATASET COLUMNS

USE SAPublicProcurement;
GO

DROP TABLE IF EXISTS Stg_OCDS_Releases;
GO

USE SAPublicProcurement;
GO

CREATE TABLE Stg_OCDS_Releases
(
    [ocid] NVARCHAR(255),
    [id] NVARCHAR(255),
    [date] DATETIME2,
    [tag] NVARCHAR(100),
    [initiationType] NVARCHAR(100),
    [publishedDate] DATETIME2,
    [publisher] NVARCHAR(500),
    [uri] NVARCHAR(1000),
    [license] NVARCHAR(500),
    [planning_rationale] NVARCHAR(MAX),
    [planning_budget_description] NVARCHAR(MAX),
    [tender_id] NVARCHAR(255),
    [tender_title] NVARCHAR(500),
    [tender_description] NVARCHAR(MAX),
    [tender_status] NVARCHAR(100),
    [tender_classification] NVARCHAR(100),
    [tender_period_start_date] DATE,
    [tender_period_end_date] DATETIME2,
    [tender_eligibility_criteria] NVARCHAR(MAX),
    [tender_contractperiod_startdate] DATE,
    [tender_contractperiod_enddate] DATE,
    [tender_document_urls] NVARCHAR(MAX),
    [bidders] NVARCHAR(MAX),
    [awards_id] NVARCHAR(255),
    [award_status] NVARCHAR(100),
    [awards_date] DATE,
    [awards_suppliers_name] NVARCHAR(500),
    [contracts_id] NVARCHAR(255),
    [contracts_title] NVARCHAR(500),
    [contract_description] NVARCHAR(MAX),
    [contracts_period_start_date] DATE,
    [contracts_period_end_date] DATE,
    [contracts_status] NVARCHAR(100),
    [contracts_milestones_id] NVARCHAR(255),
    [contracts_milestones_title] NVARCHAR(500),
    [contracts_milestones_type] NVARCHAR(100),
    [contracts_milestones_description] NVARCHAR(MAX),
    [contracts_milestones_duedate] DATE,
    [publisher_name] NVARCHAR(500),
    [buyer_id] NVARCHAR(255),
    [buyer_name] NVARCHAR(500)
);
GO

-- TABLE COLUMNS VERIFICATION FOR PROPER IMPORTING OF DATA

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Stg_OCDS_Releases'
ORDER BY ORDINAL_POSITION;
GO

-- DATA IMPORT VALIDATION 

SELECT COUNT(*) AS TotalRows
FROM Stg_OCDS_Releases;
GO

SELECT TOP 10 *
FROM Stg_OCDS_Releases;
GO

SELECT COUNT(DISTINCT tender_id) AS Unique_Tenders
FROM Stg_OCDS_Releases;
GO

-- CHECKING FOR DUPLICATES/TENDERS THAT APPREAR MORE THAN ONCE

SELECT
    tender_id,
    COUNT(*) AS NumberOfRecords
FROM Stg_OCDS_Releases
GROUP BY tender_id
HAVING COUNT(*) > 1
ORDER BY NumberOfRecords DESC;
GO

SELECT COUNT(*) AS MissingTenderIDs
FROM Stg_OCDS_Releases
WHERE tender_id IS NULL
   OR LTRIM(RTRIM(tender_id)) = '';

SELECT
    tender_id,
    COUNT(*) AS NumberOfRecords
FROM Stg_OCDS_Releases
GROUP BY tender_id
HAVING COUNT(*) > 1
ORDER BY NumberOfRecords DESC;

SELECT
    tender_status,
    COUNT(*) AS NumberOfRecords
FROM Stg_OCDS_Releases
GROUP BY tender_status
ORDER BY NumberOfRecords DESC;

SELECT
    tender_classification,
    COUNT(*) AS NumberOfRecords
FROM Stg_OCDS_Releases
GROUP BY tender_classification
ORDER BY NumberOfRecords DESC;

SELECT
    COUNT(*) AS TotalRecords,

    SUM(CASE WHEN tender_id IS NULL
              OR LTRIM(RTRIM(tender_id)) = ''
             THEN 1 ELSE 0 END) AS MissingTenderID,

    SUM(CASE WHEN tender_title IS NULL
              OR LTRIM(RTRIM(tender_title)) = ''
             THEN 1 ELSE 0 END) AS MissingTenderTitle,

    SUM(CASE WHEN tender_description IS NULL
              OR LTRIM(RTRIM(tender_description)) = ''
             THEN 1 ELSE 0 END) AS MissingDescription,

    SUM(CASE WHEN tender_status IS NULL
              OR LTRIM(RTRIM(tender_status)) = ''
             THEN 1 ELSE 0 END) AS MissingStatus,

    SUM(CASE WHEN tender_classification IS NULL
              OR LTRIM(RTRIM(tender_classification)) = ''
             THEN 1 ELSE 0 END) AS MissingClassification,

    SUM(CASE WHEN tender_period_start_date IS NULL
             THEN 1 ELSE 0 END) AS MissingStartDate,

    SUM(CASE WHEN tender_period_end_date IS NULL
             THEN 1 ELSE 0 END) AS MissingEndDate,

    SUM(CASE WHEN buyer_id IS NULL
              OR LTRIM(RTRIM(buyer_id)) = ''
             THEN 1 ELSE 0 END) AS MissingBuyerID,

    SUM(CASE WHEN buyer_name IS NULL
              OR LTRIM(RTRIM(buyer_name)) = ''
             THEN 1 ELSE 0 END) AS MissingBuyerName

FROM Stg_OCDS_Releases;
GO

SELECT COUNT(*) AS InvalidTenderPeriods
FROM Stg_OCDS_Releases
WHERE tender_period_start_date IS NOT NULL
  AND tender_period_end_date IS NOT NULL
  AND tender_period_end_date < tender_period_start_date;
GO

USE SAPublicProcurement;
GO

-- CLEAN TENDERS TABLE

CREATE TABLE Tenders
(
    TenderID NVARCHAR(255) NOT NULL,
    ReleaseID NVARCHAR(255),
    OCID NVARCHAR(255),
    ReleaseDate DATETIME2,
    PublishedDate DATETIME2,
    TenderTitle NVARCHAR(500),
    TenderDescription NVARCHAR(MAX),
    TenderStatus NVARCHAR(100),
    ProcurementClassification NVARCHAR(100),
    TenderStartDate DATE,
    TenderEndDate DATETIME2,
    TenderDurationDays INT,
    TenderDocumentURLs NVARCHAR(MAX),
    BuyerID NVARCHAR(255),
    BuyerName NVARCHAR(500),

    CONSTRAINT PK_Tenders PRIMARY KEY (TenderID)
);
GO

-- POPULATE TENDERS TABLE

WITH RankedTenders AS
(
    SELECT
        ocid,
        id,
        date,
        publishedDate,
        tender_id,
        tender_title,
        tender_description,
        tender_status,
        tender_classification,
        tender_period_start_date,
        tender_period_end_date,
        tender_document_urls,
        buyer_id,
        buyer_name,

        ROW_NUMBER() OVER
        (
            PARTITION BY tender_id
            ORDER BY date DESC, id DESC
        ) AS RowNumber

    FROM Stg_OCDS_Releases

    WHERE tender_id IS NOT NULL
      AND LTRIM(RTRIM(tender_id)) <> ''
)

INSERT INTO Tenders
(
    TenderID,
    ReleaseID,
    OCID,
    ReleaseDate,
    PublishedDate,
    TenderTitle,
    TenderDescription,
    TenderStatus,
    ProcurementClassification,
    TenderStartDate,
    TenderEndDate,
    TenderDurationDays,
    TenderDocumentURLs,
    BuyerID,
    BuyerName
)

SELECT
    tender_id AS TenderID,
    id AS ReleaseID,
    ocid AS OCID,

    date AS ReleaseDate,
    publishedDate AS PublishedDate,

    tender_title AS TenderTitle,
    tender_description AS TenderDescription,

    tender_status AS TenderStatus,

    CASE
        WHEN tender_classification IS NULL
             OR LTRIM(RTRIM(tender_classification)) = ''
        THEN 'Unknown / Not Provided'
        ELSE tender_classification
    END AS ProcurementClassification,

    tender_period_start_date AS TenderStartDate,
    tender_period_end_date AS TenderEndDate,

    CASE
        WHEN tender_period_start_date IS NOT NULL
         AND tender_period_end_date IS NOT NULL
        THEN DATEDIFF
        (
            DAY,
            tender_period_start_date,
            CAST(tender_period_end_date AS DATE)
        )
        ELSE NULL
    END AS TenderDurationDays,

    tender_document_urls AS TenderDocumentURLs,

    buyer_id AS BuyerID,
    buyer_name AS BuyerName

FROM RankedTenders

WHERE RowNumber = 1;
GO

SELECT COUNT(*) AS TotalTenders
FROM Tenders;
GO

SELECT COUNT(DISTINCT TenderID) AS UniqueTenderIDs
FROM Tenders;
GO

SELECT
    COUNT(*) AS TotalTenderRecords,
    COUNT(DISTINCT BuyerID) AS UniqueBuyerIDs,
    COUNT(DISTINCT BuyerName) AS UniqueBuyerNames
FROM Tenders;
GO

SELECT COUNT(*) AS MissingBuyerIDs
FROM Tenders
WHERE BuyerID IS NULL
   OR LTRIM(RTRIM(BuyerID)) = '';
GO

SELECT
    BuyerID,
    COUNT(DISTINCT BuyerName) AS NumberOfBuyerNames
FROM Tenders
WHERE BuyerID IS NOT NULL
  AND LTRIM(RTRIM(BuyerID)) <> ''
GROUP BY BuyerID
HAVING COUNT(DISTINCT BuyerName) > 1
ORDER BY NumberOfBuyerNames DESC;
GO

USE SAPublicProcurement;
GO

-- CREATING BUYERS TABLE

CREATE TABLE Buyers
(
    BuyerID NVARCHAR(255) NOT NULL,
    BuyerName NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Buyers
        PRIMARY KEY (BuyerID)
);
GO

USE SAPublicProcurement;
GO

DROP TABLE IF EXISTS Buyers;
GO

CREATE TABLE Buyers (
    BuyerID NVARCHAR(255) NOT NULL,
    BuyerName NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Buyers
        PRIMARY KEY (BuyerID)
);
GO

-- POPULATING BUYERS TABLE

INSERT INTO Buyers (
    BuyerID,
    BuyerName
)
SELECT DISTINCT
    BuyerID,
    BuyerName
FROM Tenders
WHERE BuyerID IS NOT NULL
  AND LTRIM(RTRIM(BuyerID)) <> ''
  AND BuyerName IS NOT NULL
  AND LTRIM(RTRIM(BuyerName)) <> '';
GO

SELECT COUNT(*) AS TotalBuyers
FROM Buyers;

SELECT TOP 20
    BuyerID,
    BuyerName
FROM Buyers
ORDER BY BuyerName;
GO

ALTER TABLE Tenders
ADD CONSTRAINT FK_Tenders_Buyers
FOREIGN KEY (BuyerID)
REFERENCES Buyers(BuyerID);
GO

SELECT COUNT(*) AS UnmatchedBuyers
FROM Tenders T
LEFT JOIN Buyers B
    ON T.BuyerID = B.BuyerID
WHERE T.BuyerID IS NOT NULL
  AND B.BuyerID IS NULL;
GO


SELECT
    B.BuyerName,
    COUNT(T.TenderID) AS NumberOfTenders
FROM Buyers B
INNER JOIN Tenders T
ON B.BuyerID = T.BuyerID
GROUP BY B.BuyerName
ORDER BY NumberOfTenders DESC;
GO

USE SAPublicProcurement;
GO

SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('Tenders', 'Buyers');
GO

SELECT
    T.TenderID,
    T.TenderTitle,
    B.BuyerName
FROM Tenders T
INNER JOIN Buyers B
    ON T.BuyerID = B.BuyerID;
    GO

-- AWARDS TABLE CREATION

SELECT
    awards_id,
    COUNT(*) AS NumberOfRecords
FROM Stg_OCDS_Releases
WHERE awards_id IS NOT NULL
  AND LTRIM(RTRIM(awards_id)) <> ''
GROUP BY awards_id
HAVING COUNT(*) > 1
ORDER BY NumberOfRecords DESC;
GO

USE SAPublicProcurement;
GO

CREATE TABLE Awards (
    AwardID NVARCHAR(255) NOT NULL,
    TenderID NVARCHAR(255) NOT NULL,
    AwardStatus NVARCHAR(100),
    AwardDate DATE,
    SupplierName NVARCHAR(500),

    CONSTRAINT PK_Awards
        PRIMARY KEY (AwardID),

    CONSTRAINT FK_Awards_Tenders
        FOREIGN KEY (TenderID)
        REFERENCES Tenders(TenderID)
);
GO

WITH LatestReleases AS
( SELECT
  *,
  ROW_NUMBER() OVER (
  PARTITION BY tender_id
  ORDER BY date DESC, id DESC
  ) AS RowNumber

  FROM Stg_OCDS_Releases

  WHERE tender_id IS NOT NULL
)
INSERT INTO Awards (
    AwardID,
    TenderID,
    AwardStatus,
    AwardDate,
    SupplierName
)
SELECT
    awards_id AS AwardID,
    tender_id AS TenderID,
    award_status AS AwardStatus,
    awards_date AS AwardDate,
    awards_suppliers_name AS SupplierName
FROM LatestReleases
WHERE RowNumber = 1
  AND awards_id IS NOT NULL
  AND LTRIM(RTRIM(awards_id)) <> '';
GO

-- VALIDATING THE POPULATED DATA

SELECT COUNT(*) AS TotalAwards
FROM Awards;
GO

SELECT
    AwardID,
    TenderID,
    AwardStatus,
    AwardDate,
    SupplierName
FROM Awards
ORDER BY AwardDate;
GO

SELECT COUNT(*) AS UnmatchedAwards
FROM Awards A
LEFT JOIN Tenders T
    ON A.TenderID = T.TenderID
WHERE T.TenderID IS NULL;
GO

SELECT
    AwardID,
    COUNT(*) AS NumberOfRecords
FROM Awards
GROUP BY AwardID
HAVING COUNT(*) > 1;
GO

-- CONTRACTS TABLE CREATION

USE SAPublicProcurement;
GO

CREATE TABLE Contracts (
    ContractID NVARCHAR(255) NOT NULL,
    TenderID NVARCHAR(255) NOT NULL,
    ContractTitle NVARCHAR(500),
    ContractDescription NVARCHAR(MAX),
    ContractStartDate DATE,
    ContractEndDate DATE,
    ContractStatus NVARCHAR(100),

    CONSTRAINT PK_Contracts
        PRIMARY KEY (ContractID),

    CONSTRAINT FK_Contracts_Tenders
        FOREIGN KEY (TenderID)
        REFERENCES Tenders(TenderID)
);
GO

WITH LatestReleases AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY tender_id
            ORDER BY date DESC, id DESC
        ) AS RowNumber

    FROM Stg_OCDS_Releases

    WHERE tender_id IS NOT NULL
)

INSERT INTO Contracts
(
    ContractID,
    TenderID,
    ContractTitle,
    ContractDescription,
    ContractStartDate,
    ContractEndDate,
    ContractStatus
)

SELECT
    contracts_id AS ContractID,
    tender_id AS TenderID,
    contracts_title AS ContractTitle,
    contract_description AS ContractDescription,
    contracts_period_start_date AS ContractStartDate,
    contracts_period_end_date AS ContractEndDate,
    contracts_status AS ContractStatus

FROM LatestReleases

WHERE RowNumber = 1
  AND contracts_id IS NOT NULL
  AND LTRIM(RTRIM(contracts_id)) <> '';
GO

SELECT COUNT(*) AS TotalContracts
FROM Contracts;
GO

SELECT
    ContractID,
    TenderID,
    ContractTitle,
    ContractStartDate,
    ContractEndDate,
    ContractStatus
FROM Contracts
ORDER BY ContractStartDate;
GO

SELECT COUNT(*) AS UnmatchedContracts
FROM Contracts C
LEFT JOIN Tenders T
    ON C.TenderID = T.TenderID
WHERE T.TenderID IS NULL;
GO

-- ANALYTICAL SQL 

USE SAPublicProcurement;
GO

SELECT
    B.BuyerID,
    B.BuyerName,
    COUNT(T.TenderID) AS NumberOfTenders
FROM Buyers B
INNER JOIN Tenders T
    ON B.BuyerID = T.BuyerID
GROUP BY B.BuyerID,
         B.BuyerName
ORDER BY NumberOfTenders DESC;
GO

-- TOP 10 BUYERS

SELECT TOP 10
    B.BuyerName,
    COUNT(T.TenderID) AS NumberOfTenders
FROM Buyers B
INNER JOIN Tenders T
    ON B.BuyerID = T.BuyerID
GROUP BY B.BuyerName
ORDER BY NumberOfTenders DESC;
GO

-- PROCUREMENT CLASSIFICATION

SELECT
    ProcurementClassification,
    COUNT(*) AS NumberOfTenders
FROM Tenders
GROUP BY ProcurementClassification
ORDER BY NumberOfTenders DESC;
GO

-- PROCUREMENT STATUS

SELECT
    TenderStatus,
    COUNT(*) AS NumberOfTenders
FROM Tenders
GROUP BY TenderStatus
ORDER BY NumberOfTenders DESC;
GO

SELECT
    TenderStatus,
    COUNT(*) AS NumberOfTenders,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS PercentageOfTenders
FROM Tenders
GROUP BY TenderStatus
ORDER BY NumberOfTenders DESC;
GO

-- AVERAGE TENDER DURATION

SELECT
    AVG(CAST(TenderDurationDays AS DECIMAL(10,2)))
        AS AverageTenderDurationDays
FROM Tenders
WHERE TenderDurationDays IS NOT NULL;
GO

-- SHORTEST AND LONGEST TENDER DURATION PERIODS

SELECT
    MIN(TenderDurationDays) AS ShortestTenderPeriod,
    MAX(TenderDurationDays) AS LongestTenderPeriod,
    AVG(CAST(TenderDurationDays AS DECIMAL(10,2)))
        AS AverageTenderPeriod
FROM Tenders
WHERE TenderDurationDays IS NOT NULL;
GO

SELECT
    T.TenderID,
    T.TenderTitle,
    B.BuyerName,
    T.TenderStartDate,
    T.TenderEndDate,
    T.TenderDurationDays
FROM Tenders T
INNER JOIN Buyers B
    ON T.BuyerID = B.BuyerID
WHERE T.TenderDurationDays <= 7
  AND T.TenderDurationDays >= 0
ORDER BY T.TenderDurationDays ASC;
GO

-- TOTAL PROCUREMENT VOLUME

SELECT
    COUNT(*) AS TotalTenders
FROM Tenders;
GO

-- TOP 10 PROCUREMENT CONCENTRATION
WITH BuyerVolume AS (
    SELECT TOP 10
        B.BuyerID,
        B.BuyerName,
        COUNT(T.TenderID) AS NumberOfTenders
    FROM Buyers B
    INNER JOIN Tenders T
    ON B.BuyerID = T.BuyerID
    GROUP BY
        B.BuyerID,
        B.BuyerName
    ORDER BY
        NumberOfTenders DESC
)

SELECT
    SUM(NumberOfTenders) AS Top10TenderVolume,
    CAST(
        SUM(NumberOfTenders) * 100.0
        / (SELECT COUNT(*) FROM Tenders)
        AS DECIMAL(5,2)
    ) AS Top10PercentageOfAllTenders
FROM BuyerVolume;
GO

/*== TENDER DURATION ANALYSIS ==*/
-- AVERAGE DURATION BY CLASSIFICATION --

SELECT
    ProcurementClassification,
    COUNT(*) AS NumberOfTenders,
    MIN(TenderDurationDays) AS MinimumDurationDays,
    MAX(TenderDurationDays) AS MaximumDurationDays,
    CAST(
        AVG(CAST(TenderDurationDays AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AverageDurationDays
FROM Tenders
WHERE TenderDurationDays IS NOT NULL
  AND TenderDurationDays >= 0
GROUP BY ProcurementClassification
ORDER BY AverageDurationDays DESC;
GO