#credentials to connect to mysql
mysql_user=
mysql_password=
#credentials to connect to ftp
FTPUSER=
FTPPW=
FTPSERVER=
#directory that will be created on ftp and the one that will be deleted
TODAY=$(date +"%Y_%m_%d")
RMDATE=$(date +"%Y_%m_%d" -d '7 days ago') 
TMPDIR=/media/backups
mysql_backup_file=$TMPDIR/backup.sql
echo -n "Database dump"
mysqldump -u $mysql_user -p$mysql_password --all-databases > $mysql_backup_file && 
echo -n "Dump compression"
gzip $mysql_backup_file
echo -n "Uploading files via FTP... "
lftp << EOF
open sftp://${FTPUSER}:${FTPPW}@${FTPSERVER}
cd _SqlBackup/
mkdir ${TODAY}
cd ${TODAY}
mput -E ${TMPDIR}/*
cd ..
rm -rf ${RMDATE}
bye
EOF
echo "Done."
