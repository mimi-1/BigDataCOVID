# Epidemic tracking big data project
Assignment_2 for big data 1 course  Working with HBase/Hive/Zeppelin

Loading aggregated historical data
----------------------------------
John Hopkins University collects everyday reports on COVID-19 on https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports. There are separate csv file for everyday situation on COVID in most countries in the world. Starting march 1st, 2020, all scv files have the same format. We use them as aggregated historical data in hive
1. Bash script : _grd.sh_ (get raw data) 

creates the _rawdata_ directory in hosting system, loads data into the 
hdfs. The script checks if the file exists in _rawdata_ directory and do nothing if it exists.
Can be used for initial download and subsequent updates

2. SQL script _hive.sql_ 

creates table as ORC in hive and loads data from multiple scv files in HDFS downloaded by bash script. No partitionaing or clustering.
Script can be used to upgrade data as well (inserts only rows that do not exists) 

Loading epidemic cases to hbase
----------------------------------

1. script get_hbase.sh contains bash commands to upload raw scv file from Lancet git repository to hdfs
2. script  CSV_TO_HIVE_TOHBASE.hql loads data from scv to hdfs with transformation. It generates row-keys . It still doesnt load full data yet

