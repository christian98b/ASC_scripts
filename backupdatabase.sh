#!/bin/bash

datum ="$(date +'%d-%m-%Y')"
directory ="/var/mariadb/backup/$datum"
lowerdir ="/var/mariadb/backup"
password = "mypassword"
user = "mydbuser"


mariabackup --backup --target-dir=$directory --user=$user --password=$password
echo "backup created"
cd $lowerdir
zip -r $directory.zip $datum
echo "created zip"
rm -r "${directory}"
echo "delete old folder"
