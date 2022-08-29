#!/bin/bash

date="$(date +'%d/%m/%Y')"
mariabackup --backup \ --target-dir=/var/mariadb/backup/date \ --user=laravelapp_mitgliederverwaltunguser --password=mypassword
echo("Backup erstellt")
