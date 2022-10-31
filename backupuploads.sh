#folder to backup
folderunder=/var/www/html/app_mitgliederverwaltung/storage/app
folder=uploads
#credentials to connect to ftp
FTPUSER=
FTPPW=
FTPSERVER=
#directory that will be created on ftp and the one that will be deleted
TODAY=$(date +"%Y_%m_%d")
RMDATE=$(date +"%Y_%m_%d" -d '7 days ago') 
TMPDIR=/media/backups/uploads
backup_file=$TMPDIR/backup.zip

echo -n "Create Zip Archive"
cd ${folderunder} 
zip -r ${backup_file} ${folder}
echo -n "Uploading files via FTP... "
lftp << EOF
open sftp://${FTPUSER}:${FTPPW}@${FTPSERVER}
cd _UploadBackup/
mkdir ${TODAY}
cd ${TODAY}
mput -E ${TMPDIR}/*
cd ..
rm -rf ${RMDATE}
bye
EOF
echo "Done."
