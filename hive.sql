--script can be be run in hive for beggining and to update data.
--creating permanent ORC table
CREATE TABLE IF NOT EXISTS as2.epidemic_daily(
desease_code STRING,
state STRING,
country STRING,
report_date DATE,
last_update STRING,
confirmed INT,
deaths INT,
recovered INT,
latitude STRING,
longitude STRING ) 
STORED AS ORC;

---creating temporary table from csv files and loading data to orc hive

CREATE TEMPORARY EXTERNAL TABLE IF NOT EXISTS as2.covid_ex(
state STRING,
country STRING,
last_update STRING,
confirmed INT,
deaths INT,
recovered INT,
latitude STRING,
longitude STRING ) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/user/maria_dev/as2'
TBLPROPERTIES("skip.header.line.count"="1");

--adds new data every time script is runing 
INSERT OVERWRITE TABLE as2.epidemic_daily
SELECT "COVID-19" desease_code,
		state,
		country,
		CAST(SUBSTRING(last_update,0,10) as DATE) report_date,
		last_update,
		confirmed,
		deaths,
		recovered,
		latitude,
		longitude
FROM as2.covid_ex;

---Checking :
select * from as2.epidemic_daily 
where country='Canada'AND state like '%ON%';