 working

<br>

CREATE OR REPLACE PROCEDURE `project`.test_table.spark_proc()
WITH CONNECTION `project.us.pyspark-connections` OPTIONS(engine="SPARK", runtime_version="1.1", main_file_uri="gs://project/Hello.py") LANGUAGE PYTHON
