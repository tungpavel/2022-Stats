--Find not nullS
SELECT *
FROM [Adviser Stats].dbo.[feb]
WHERE "OB average" is not null 
and "in average" is not null 
and adherence is not null 
and acw is not null 



--select all outbound
select [Jan].name, 
[Jan]."OB average" as "OB Jan",
[Feb]."OB average" as "OB Feb",
--[March]."OB average" as "OB March",
--[April]."OB average" as "OB April",
--[May]."OB average" as "OB May"
[Jan].date,
[Feb].date
From [Adviser Stats].dbo.[Jan]
JOIN [Adviser Stats].[dbo].[Feb]
ON [Feb].name = [Jan].name
WHERE [Jan].name is not null 
and [Jan]."OB average" is not null
and [Feb]."OB average" is not null



-- create a table
CREATE TABLE #OB_Avg_year (
ACW float,
Advisor_Name varchar(100),
OB_Average int,
IN_Average int,
Adherence float,
months DATE)

DROP TABLE #OB_Avg_year

--
SELECT *
FROM #OB_AVG_YEAR
order BY Advisor_name, months

-- add data into temp table
INSERT INTO #OB_Avg_year (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[June].ACW,
[June].name,
[June]."OB average",
[June]."IN Average",
[June].Adherence,
[June].date
From [Adviser Stats].dbo.[June]

DELETE
FROM #OB_Avg_year
where Advisor_name = 'Team Average/Total'

-- Rolling OB total, descending 
SELECT *,
SUM(OB_Average) OVER (PARTITION BY Advisor_Name ORDER BY months) as RollingOB
FROM #OB_Avg_year
ORDER BY 2

SELECT *,
SUM(OB_Average) OVER (PARTITION BY Advisor_Name) as RollingOB
FROM #OB_Avg_year
ORDER BY 7 desc


--SELECT *,
--SUM(OB_Average) OVER (ORDER BY Advisor_Name, OB_average, months) as RollingOB
--FROM #OB_Avg_year
--ORDER BY 7 desc

Create VIEW Stats_June2022 as
(
WITH Stats_June AS(
SELECT *,
SUM(OB_Average) OVER (PARTITION BY Advisor_Name ORDER BY months) as RollingOB
FROM #OB_Avg_year)
SELECT * FROM Stats_June

