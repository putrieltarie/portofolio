USE portofolio_supermarket;
SELECT*FROM bakery LIMIT 5;
DESC bakery;
DROP VIEW IF EXISTS Transaction_Bakery;

CREATE VIEW Transaction_Bakery AS
SELECT 
    TransactionNo, 
    Items, 
    DateTime, 
	MONTHNAME(DateTime) AS Month, 
    DAYNAME(DateTime) AS Day, 
	Daypart, 
    DayType,
    CASE 
        WHEN HOUR(DateTime) = 1 THEN '1-2'
        WHEN HOUR(DateTime) = 7 THEN '7-8'
        WHEN HOUR(DateTime) = 8 THEN '8-9'
        WHEN HOUR(DateTime) = 9 THEN '9-10'
        WHEN HOUR(DateTime) = 10 THEN '10-11'
        WHEN HOUR(DateTime) = 11 THEN '11-12'
        WHEN HOUR(DateTime) = 12 THEN '12-13'
        WHEN HOUR(DateTime) = 13 THEN '13-14'
        WHEN HOUR(DateTime) = 14 THEN '14-15'
        WHEN HOUR(DateTime) = 15 THEN '15-16'
        WHEN HOUR(DateTime) = 16 THEN '16-17'
        WHEN HOUR(DateTime) = 17 THEN '17-18'
        WHEN HOUR(DateTime) = 18 THEN '18-19'
        WHEN HOUR(DateTime) = 19 THEN '19-20'
        WHEN HOUR(DateTime) = 20 THEN '20-21'
        WHEN HOUR(DateTime) = 21 THEN '21-22'
        WHEN HOUR(DateTime) = 22 THEN '22-23'
        WHEN HOUR(DateTime) = 23 THEN '23-24'
    END AS TimeRange
FROM bakery;

SELECT*FROM Transaction_Bakery;

-- BEST SELLING PRODUCT
SELECT Items, COUNT(Items) AS Total FROM Transaction_Bakery
GROUP BY Items
ORDER BY Total DESC
LIMIT 10;

-- DI SAAT HARI APA PALING BANYAK PERGI KE BAKERY --
SELECT Day, COUNT(DISTINCT TransactionNo) AS Total_Transaction
FROM Transaction_Bakery
GROUP BY Day
ORDER BY Total_Transaction DESC;

-- DI SAAT JAM BERAPA APA TRANSAKSI DILAKUKAN--
SELECT TimeRange, COUNT(DISTINCT TransactionNo) AS Total_Transaction
FROM Transaction_Bakery
GROUP BY TimeRange
ORDER BY Total_Transaction DESC;

-- DI SAAT JAM BERAPA APA TRANSAKSI DILAKUKAN--
SELECT Daypart, COUNT(DISTINCT TransactionNo) AS Total_Transaction
FROM Transaction_Bakery
GROUP BY DayPart
ORDER BY Total_Transaction DESC;


-- CARA MANUAL UNTUK TAHU PEMBELIAN ITEM APA YANG PALING BANYAK DI PAGI SIANG, SORE, MALAM
SELECT Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
GROUP BY Daypart, Items
ORDER BY Daypart, Jumlah_Order DESC;

SELECT Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE Daypart = 'Morning'
GROUP BY Items
ORDER BY Jumlah_Order DESC
LIMIT 5;

SELECT Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE Daypart = 'Evening'
GROUP BY Items
ORDER BY Jumlah_Order DESC
LIMIT 5;


SELECT Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE Daypart = 'Night'
GROUP BY Items
ORDER BY Jumlah_Order DESC
LIMIT 5;

SELECT Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE Daypart = 'Afternoon'
GROUP BY Items
ORDER BY Jumlah_Order DESC
LIMIT 5;

WITH RankedOrders AS (
    SELECT Daypart, Items, COUNT(*) AS Jumlah_Order,
           ROW_NUMBER() OVER (PARTITION BY Daypart 
           ORDER BY COUNT(*) DESC) AS rn
    FROM bakery
    GROUP BY Daypart, Items
)
SELECT Daypart, Items, Jumlah_Order
FROM RankedOrders
WHERE rn <= 5
ORDER BY DayPart, Jumlah_Order DESC;

SELECT*FROM Transaction_Bakery
LIMIT 5;

-- CARA MANUAL UNTUK TAHU PEMBELIAN ITEM APA YANG PALING BANYAK DI PAGI SIANG, SORE, MALAM TAHUN 206 dan 2017 --

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2016 AND Daypart = 'Afternoon'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2016 AND Daypart = 'Morning'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2017 AND Daypart = 'Evening'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2016 AND Daypart = 'Night'
GROUP BY Items
ORDER BY Jumlah_Order DESC;


-- DILIHAT DARI TAHUNNYA 2017 --
SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2017 AND Daypart = 'Afternoon'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2017 AND Daypart = 'Morning'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2017 AND Daypart = 'Evening'
GROUP BY Items
ORDER BY Jumlah_Order DESC;

SELECT DateTime, Daypart, Items, COUNT(*) AS Jumlah_Order
FROM bakery
WHERE YEAR(DateTime) = 2017 AND Daypart = 'Night'
GROUP BY Items
ORDER BY Jumlah_Order DESC;


 -- Saat Weekend dan Weekdays item apa yang banyak dibeli --
 WITH RankedOrders AS (
 SELECT DayType, Items, COUNT(*) AS Jumlah_Order,
           ROW_NUMBER() OVER (PARTITION BY DayType ORDER BY COUNT(*) DESC) AS rn
    FROM bakery
    GROUP BY DayType, Items
)
SELECT DayType, Items, Jumlah_Order
FROM RankedOrders
WHERE rn <= 5
ORDER BY DayType,Jumlah_Order DESC;

-- Saat Weekend dan Weekdays transaksi jam berapa yang gacor

SELECT DayType, Daypart, COUNT(*) as frekuensi
FROM bakery
GROUP BY DayType, DayPart
ORDER BY DayType, frekuensi DESC;

-- Item terbesar yang terjual dalam tiap bulan per tahun --
WITH RankedOrders AS (
    SELECT YEAR(DateTime) AS Tahun, MONTH(DateTime) AS Bulan, Items, COUNT(*) AS Jumlah_Order,
           ROW_NUMBER() OVER (PARTITION BY YEAR(DateTime), MONTH(DateTime) ORDER BY COUNT(*) DESC) AS rn
    FROM bakery
    GROUP BY YEAR(DateTime), MONTH(DateTime), Items
)
SELECT Tahun, Bulan, Items, Jumlah_Order
FROM RankedOrders
WHERE rn = 1
ORDER BY Tahun, Jumlah_Order DESC;


SELECT 
    YEAR(DateTime) AS Tahun, 
    MONTH(DateTime) AS Bulan, 
    COUNT(DISTINCT TransactionNo) AS Total_Transaksi
FROM bakery
GROUP BY YEAR(DateTime), MONTH(DateTime)
ORDER BY Tahun, Bulan;