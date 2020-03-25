
#creates hbase table

echo -e "create 'epidemic_tracker','classification','location','patient','desc','travel_history','meta'"|hbase shell -n


# get raw detailed data  into currect directory 

url="https://raw.githubusercontent.com/beoutbreakprepared/nCoV2019/master/latest_data/latestdata.csv"
wget $url

#load file into hdfs

hdfs dfs -mkdir /tmp/as2
hdfs dfs -put latestdata.csv /tmp/as2 
