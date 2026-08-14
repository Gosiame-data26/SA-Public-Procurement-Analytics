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
