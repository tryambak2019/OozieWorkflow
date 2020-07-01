#Copy Oozie workflow, coordinator, etc. files to hdfs

MYDIR="/oozie/oz2/workflow"
if hdfs dfs -test -e "${MYDIR}"; then 
echo -e "${MYDIR} exists on HDFS.\nDeleting existing ${MYDIR}"
hadoop fs -rm -r "${MYDIR}"
fi
echo "Creating new ${MYDIR} on HDFS"
hadoop fs -mkdir -p hdfs://localhost:8020${MYDIR}

hadoop fs -put -f /var/lib/hadoop-hdfs/oz2/workflow.xml hdfs://localhost:8020${MYDIR}
hadoop fs -put -f /var/lib/hadoop-hdfs/oz2/coordinator.xml hdfs://localhost:8020${MYDIR}
hadoop fs -put -f /var/lib/hadoop-hdfs/oz2/downloadcovid.sh hdfs://localhost:8020${MYDIR}
hadoop fs -put -f /var/lib/hadoop-hdfs/oz2/hive-site.xml hdfs://localhost:8020${MYDIR}
hadoop fs -put -f /var/lib/hadoop-hdfs/oz2/create_ext_tables.hql hdfs://localhost:8020${MYDIR}

#Start Oozie orchestration
oozie job -oozie http://localhost:11000/oozie -config job.properties -run

#oozie job -oozie http://localhost:11000/oozie -kill 0000001-200527180851566-oozie-oozi-W

#Check currently running oozie jobs
#oozie jobs -oozie http://localhost:11000/oozie

#Check the status of a currently running job
#oozie job -oozie http://localhost:11000/oozie -info 0000011-200626162937212-oozie-oozi-W

