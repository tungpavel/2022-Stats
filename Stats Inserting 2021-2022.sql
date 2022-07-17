create TABLE #2021_stats(
ACW float,
Advisor_Name varchar(100),
OB_Average int,
IN_Average int,
Adherence float,
months DATE)

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Jan_2021].ACW,
[Jan_2021].name,
[Jan_2021]."OB average",
[Jan_2021]."IN Average",
[Jan_2021].Adherence,
[Jan_2021].date
From [stats_2021].[dbo].[Jan_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Feb_2021].ACW,
[Feb_2021].name,
[Feb_2021]."OB average",
[Feb_2021]."IN Average",
[Feb_2021].Adherence,
[Feb_2021].date
From [stats_2021].[dbo].[feb_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[mar_2021].ACW,
[mar_2021].name,
[mar_2021]."OB average",
[mar_2021]."IN Average",
[mar_2021].Adherence,
[mar_2021].date
From [stats_2021].[dbo].[mar_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[apr_2021].ACW,
[apr_2021].name,
[apr_2021]."OB average",
[apr_2021]."IN Average",
[apr_2021].Adherence,
[apr_2021].date
From [stats_2021].[dbo].[apr_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[may_2021].ACW,
[may_2021].name,
[may_2021]."OB average",
[may_2021]."IN Average",
[may_2021].Adherence,
[may_2021].date
From [stats_2021].[dbo].[may_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[June_2021].ACW,
[June_2021].name,
[June_2021]."OB average",
[June_2021]."IN Average",
[June_2021].Adherence,
[June_2021].date
From [stats_2021].[dbo].[June_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Jul_2021].ACW,
[Jul_2021].name,
[Jul_2021]."OB average",
[Jul_2021]."IN Average",
[Jul_2021].Adherence,
[Jul_2021].date
From [stats_2021].[dbo].[Jul_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Aug_2021].ACW,
[Aug_2021].name,
[Aug_2021]."OB average",
[Aug_2021]."IN Average",
[Aug_2021].Adherence,
[Aug_2021].date
From [stats_2021].[dbo].[Aug_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Sep_2021].ACW,
[Sep_2021].name,
[Sep_2021]."OB average",
[Sep_2021]."IN Average",
[Sep_2021].Adherence,
[Sep_2021].date
From [stats_2021].[dbo].[Sep_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Oct_2021].ACW,
[Oct_2021].name,
[Oct_2021]."OB average",
[Oct_2021]."IN Average",
[Oct_2021].Adherence,
[Oct_2021].date
From [stats_2021].[dbo].[Oct_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Nov_2021].ACW,
[Nov_2021].name,
[Nov_2021]."OB average",
[Nov_2021]."IN Average",
[Nov_2021].Adherence,
[Nov_2021].date
From [stats_2021].[dbo].[Nov_2021]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[Dec_2021].ACW,
[Dec_2021].name,
[Dec_2021]."OB average",
[Dec_2021]."IN Average",
[Dec_2021].Adherence,
[Dec_2021].date
From [stats_2021].[dbo].[Dec_2021]

-- remove 0
UPDATE #2021_stats SET Adherence=NULL WHERE Adherence=0

-- Change names

--Select advisor_name
--From #2021_stats
--where advisor_name like 'hele%'

--update #2021_stats
--set advisor_name = 'Shaun E'
--Where Advisor_Name like 'Shau%'

Select *,
SUM(OB_Average) OVER (PARTITION BY Advisor_Name ORDER BY months) as RollingOB
From #2021_stats
	Where ACW is not null 
	and Advisor_name is not null
	and OB_Average is not null
	and IN_Average is not null
	and Advisor_Name not like '%ave%' 
Order by rollingOB desc

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[adviser stats].[dbo].[Sheet1$].ACW,
[adviser stats].[dbo].[Sheet1$].name,
[adviser stats].[dbo].[Sheet1$]."OB average",
[adviser stats].[dbo].[Sheet1$]."IN Average",
[adviser stats].[dbo].[Sheet1$].Adherence,
[adviser stats].[dbo].[Sheet1$].date
From [stats_2021].[dbo].[Dec_2021]
Where not(Advisor_Name in (select Advisor_Name from #2021_stats))

--SELECT *
--FROM [adviser stats].[dbo].[Sheet1$]

INSERT INTO #2021_stats (ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
[adviser stats].[dbo].[Sheet1$].ACW,
[adviser stats].[dbo].[Sheet1$].Advisor_Name,
[adviser stats].[dbo].[Sheet1$]."OB_Average",
[adviser stats].[dbo].[Sheet1$]."IN_Average",
[adviser stats].[dbo].[Sheet1$].Adherence,
[adviser stats].[dbo].[Sheet1$].months
From [adviser stats].[dbo].[Sheet1$]
Where not exists(select #2021_stats.Advisor_Name from #2021_stats)


-- insert together only if advisor is in both 2021 and 2022
INSERT INTO [stats_2021].[dbo].[2022_jan_june](ACW, Advisor_Name, OB_Average, IN_Average, Adherence, months)
SELECT 
#2021_stats.ACW,
#2021_stats.Advisor_Name,
#2021_stats."OB_Average",
#2021_stats."IN_Average",
#2021_stats.Adherence,
#2021_stats.months
From #2021_stats
WHERE #2021_stats.Advisor_Name in (Select [stats_2021].[dbo].[2022_jan_june].Advisor_Name from [stats_2021].[dbo].[2022_jan_june])

Select *
from [stats_2021].[dbo].[2022_jan_june]
order by advisor_name, months
