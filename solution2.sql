--1
SELECT Customer_Details.Customer_Name, 
Mutual_Fund_Transaction_Table.NAV_Value*Mutual_Fund_Transaction_Table.No_of_Units AS Transaction_Value 
FROM Customer_Details 
INNER JOIN Mutual_Fund_Transaction_Table 
ON Customer_Details.Customer_id=Mutual_Fund_Transaction_Table.Customer_id
WHERE Transaction_Status="Success"
AND Transaction_Type="Purchase"
AND Transaction_Value=max(Transaction_Value);

--2
SELECT count(*) 
FROM Mutual_Fund_Transaction_Table 
WHERE Transaction_Status="Success"
AND MONTH(Transaction_Time)=4  AND YEAR(Transaction_Time)=2019;

--3
SELECT count(*)
FROM CustomAS_Details 
INNER JOIN Mutual_Fund_Transaction_Table
WHERE month(Customer_Details.Customer_Join_Time)=1
AND Customer_Details.Banned=0
GROUP BY Mutual_Fund_Transaction_Table.Customer_id
HAVING COUNT(*)>4;

--4
SELECT *, Mutual_Fund_Transaction_Table.NAV_Value*Mutual_Fund_Transaction_Table.No_of_Units AS Transaction_Value 
FROM Customer_Details 
INNER JOIN Mutual_Fund_Transaction_Table 
ON Customer_Details.Customer_id=Mutual_Fund_Transaction_Table.Customer_id
WHERE Customer_Details.Gender="Male"
ORDER BY Transaction_Value DESC
LIMIT 5;

--5
CREATE TABLE GNV_RETENTION AS
SELECT month(Transaction_Time) months,count(Customer_id)  number_of_customers
FROM Mutual_Fund_Transaction_Table
WHERE year(Transaction_Time)=2019
GROUP BY 1
HAVING month(Transaction_Time)<7
ORDER BY 1;

DECLARE @i INT =1;
SELECT @value=  number_of_customers FROM GNV_RETENTION WHERE months=1;
SELECT @c=Count(*) FROM GNV_RETENTION
WHILE @i<=@c
BEGIN
    UPDATE TABLE GNV_RETENTION SET months=@i+@value WHERE months=@1
    SET @i=@i+1
END;