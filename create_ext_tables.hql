--Set hive variables for dynamic partition
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
--Set hive varible to work with quoted identifiers
set hive.support.quoted.identifiers=none;

CREATE DATABASE IF NOT EXISTS ${hive_db_name};
USE ${hive_db_name};

--Create an external table and point to downloaded hdfs file
DROP TABLE IF EXISTS ${hive_ext_table_raw_data};

CREATE EXTERNAL TABLE ${hive_ext_table_raw_data} (FIPS int,
 Admin2 string,
 Province string,
 Country string,
 Last_update string,
 Lat float,
 Longt float,
 Confirmed int,
 Deaths int,
 Recovered int,
 Active int,
 Combined_Key string,
 Incidence_Rate float,
 Case_fatality_Ratio float)
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
 STORED AS TEXTFILE LOCATION  '${hdfs_dir_raw_data}'
 tblproperties ('skip.header.line.count'='1');

--Update existing internal hive table with the new data downloaded and stored in external hive table
Insert into table ${hive_table} partition(Last_update=${DATE_LAST}) select `(Last_update)?+.+` from ${hive_ext_table_raw_data};

