
# GROUP BY

SELECT island,sex, AVG(body_mass_g) AS Average_Body FROM `bigquery-public-data.ml_datasets.penguins`  GROUP BY 1,2

# PIVOT TABLE


SELECT * FROM

(SELECT island,sex, body_mass_g FROM `bigquery-public-data.ml_datasets.penguins` ) 

PIVOT
(
  AVG(body_mass_g) AS Average_Body

  FOR island IN ('Dream','Biscoe','Torgersen')
)
