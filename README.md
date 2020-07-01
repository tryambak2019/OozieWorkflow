# Oozie pipeline to automate download and ingest data to hive tables

An oozie pipeline to perform the following Actions. Schedule the job to run at everyday.

Action 1 - Execute script bash that downloads and store data for yesterday

Action 2 - Stores data in partitioned directory in HDFS

Action 3 - Create an external Hive table covid_ext that point to the above partition in HDFS

Action 4 - Copies data from covid_ext into previously created Hive Partitioned Internal Table covid