#created for assignment 2 by Maryna
# this script downloads all csv files from github up to date
#it uploads evry file to hdfs
# it skips files which are already downloaded


startdate=$(date -I -d "2020-03-01") || exit -1
enddate=$(date -I)     || exit -1

d="$startdate"
url="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"

rd_dir="rawdata"
hdfs_dir="/user/maria_dev/as2"

#create local directory if it doesn't exist
if  [ ! -d "$rd_dir" ]; then
 mkdir "$rd_dir"
 echo "Directiry $rd_dir is created"
fi

#create hdfs directory if it doesn't exists
if $(! hdfs dfs -test -d "$hdfs_dir") ; then 
 hdfs dfs -mkdir "$hdfs_dir"
 hdfs dfs -chmod 777 "$hdfs_dir"	
fi             
                       
# scan all csv files
while [ "$d" != "$enddate" ]; do 
  file_name="$(date -d "$d" +"%m-%d-%Y").csv"
  ##echo "file_name: $file_name"
  link_name="$url$file_name"
  loc_name="${rd_dir}/${file_name}"
  ##echo $loc_name
  ##d=$(date -I -d "$d + 1 day")

#download files which are not downloaded yet
  if [ ! -f "$loc_name"  ]; then
    wget --continue --timestamping -P $rd_dir $link_name
    hdfs dfs -put  "$loc_name" "$hdfs_dir"
  fi 
 d=$(date -I -d "$d + 1 day")

done
