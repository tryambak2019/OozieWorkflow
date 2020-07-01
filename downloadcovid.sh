#Download Covid data of yesterday and store it on hdfs
url_loc="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"

new_date=$(date +%m-%d-%Y -d "1 day ago")
new_file=$new_date.csv
new_file_path=/var/lib/hadoop-hdfs/oz2/${new_file}
new_url=$url_loc$new_file
wget $new_url -O ${new_file_path}
sudo chown cloudera:cloudera ${new_file_path}
chmod 777 ${new_file_path}


#Create a directory on hdfs to store download covid csv file
MYDIR=/oozie/coviddata/yestercoviddata/$(date +%m%d%Y -d "1 day ago")/
#echo $MYDIR

if hdfs dfs -test -e ${MYDIR} ; then
#echo -e "${MYDIR} exists on HDFS.\nDeleting existing ${MYDIR}"
hadoop fs -rm -r "${MYDIR}"
fi
#echo "Creating new ${MYDIR} on HDFS"
#echo $new_dir
hadoop fs -mkdir -p ${MYDIR}
hadoop fs -put -f ${new_file_path} ${MYDIR}
hadoop fs -ls -R ${MYDIR}

#Find a file on hadoop
#hdfs dfs -ls -R / | grep 06-25-2020.csv

echo "date_last=$(date +%m%d%Y -d '1 day ago')"
echo "hdfs_dir_raw_data=${MYDIR}"
