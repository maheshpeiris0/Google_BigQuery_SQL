CREATE OR REPLACE PROCEDURE friendly-plane-294914.test_table.spark_proc()
WITH CONNECTION `project.us.pyspark-connections`
OPTIONS(engine="SPARK", runtime_version="1.1", main_file_uri="gs://bucket/revenue-pyspark.py")
LANGUAGE PYTHON

<br>
