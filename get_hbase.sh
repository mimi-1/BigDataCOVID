
#creates hbase table

echo -e "create 'epidemic_tracker','classification','location','patient','desc','travel_history','meta'"|hbase shell -n


# get raw detailed data  into currect directory 
wget --continue --timestamping https://raw.githubusercontent.com/beoutbreakprepared/nCoV2019/master/latest_data/latestdata.csv

#load file into hbase

hdfs dfs -put latestdata.csv /tmp 
