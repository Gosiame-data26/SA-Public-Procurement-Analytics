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