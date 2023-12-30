
-- upper and lower
SELECT upper(name) AS Name FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` ;

--distinct

SELECT distinct status  FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` 

-- count
SELECT count(*) No_Close FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` where status='closed'

-- group by
SELECT status, count(*) No_Open FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` GROUP BY status

--date
SELECT DATE(modified_date) AS Date_only FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` 
-- extract year
SELECT EXTRACT(YEAR FROM(DATE(modified_date))) AS Year FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` 

-- concat
SELECT CONCAT(name," - ",address) AS Name_Address FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` 

SELECT name || address Name_Address FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` 

-- dubplication
SELECT address, count(*) as Duplication FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` group by address having count(*)>1

SELECT address, count(*) as Duplication FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` group by address having count(*)=1


-- max values

SELECT income_100000_124999 FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  order by 1 desc LIMIT 3

SELECT * FROM
(SELECT income_100000_124999, RANK() OVER(ORDER BY income_100000_124999 DESC) AS rank FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  ) where rank<=3


--RANK VALUE

SELECT * FROM
(SELECT income_100000_124999, RANK() OVER(ORDER BY income_100000_124999 DESC)  AS RANK_VALUE FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`) WHERE RANK_VALUE =3



-- LIKE

SELECT name , address  FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations`  WHERE address LIKE "%Street%"
-- END WITH Street - % at beginning
SELECT name , address  FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations`  WHERE address LIKE "%Street"
-- BEGIN WITH 1 - % at end

SELECT name , address  FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations`  WHERE address LIKE "1%"

SELECT name , address  FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` WHERE address LIKE "___ton%"


-- between

SELECT income_100000_124999 FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr` where income_100000_124999 between 1000 and 100000

-- IN

SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` WHERE status IN ('closed')

-- NOT IN

SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` WHERE status NOT IN ('closed')


-- IS NULL
SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` WHERE alternate_name IS  NULL

-- IS NOT NULL

SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations` WHERE alternate_name IS NOT NULL


-- UNION Remove Duplicates

-- UNION ALL    Keep Duplicates

INTERSECT
--The INTERSECT operator returns rows that are found in the results of both the left and right input queries. Unlike EXCEPT, the positioning of the input queries (to the left versus right of the INTERSECT operator) doesn't matter.

EXCEPT
--The EXCEPT operator returns rows from the left input query that are not present in the right input query.




-- FIND the 3rd highest value using self join

WITH RankedScore AS (
SELECT T1.income_100000_124999 AS income_100000_124999,
  COUNT(DISTINCT T2.income_100000_124999 ) AS Rank_Value
 FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  AS T1
 JOIN
 `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  AS T2
 ON
 T1.income_100000_124999 <= T2.income_100000_124999

 GROUP BY 
 T1.income_100000_124999

 HAVING  Rank_Value=3

)

-- EVEN NUMBER OF ROWS

WITH NumberedRow AS (
(SELECT *, ROW_NUMBER() OVER() AS row_num FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  )
)
SELECT * FROM NumberedRow WHERE MOD(row_num,2) = 0

-- ODD NUMBER OF ROWS

WITH NumberedRow AS (
(SELECT *, ROW_NUMBER() OVER() AS row_num FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  )
)
SELECT * FROM NumberedRow WHERE MOD(row_num,2) = 1


-- ROW_NUMBER() OVER(PARTITION BY)
SELECT geo_id, SUM(rent_40_to_50_percent) OVER(PARTITION BY geo_id ORDER BY median_rent DESC) as AVERAGE_RENT FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr` 

 
--https://sqlpad.io/tutorial/sql-window-functions/


-- CROSS JOIN  to get the min values of same table to each row

SELECT * FROM
(SELECT gameId, year,seasonType,gameStatus,attendance FROM `bigquery-public-data.baseball.games_post_wide` ) AS T1
CROSS JOIN
(SELECT MIN(attendance) AS Min_attendance FROM `bigquery-public-data.baseball.games_post_wide`  )
