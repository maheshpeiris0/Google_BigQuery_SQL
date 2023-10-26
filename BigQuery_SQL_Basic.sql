

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


-- max values

SELECT income_100000_124999 FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  order by 1 desc LIMIT 3

SELECT * FROM
(SELECT income_100000_124999, RANK() OVER(ORDER BY income_100000_124999 DESC) AS rank FROM `bigquery-public-data.census_bureau_acs.cbsa_2007_1yr`  ) where rank<=3



