#!/bin/bash

# It starts in the HOME directory, and backups all directories.

cd 

for i in *
do
	if [ -d $i ]
	then
	    if [ "$i" != "tmp" -a "$i" != "temp" ] 
	    then 
		    tar_file="$i"".tar.gz"
		    tar cvfz /tmp/"$tar_file" $i
		    sed 's/REEMPLAZAR/'"$tar_file"'/g' /tmp/sftp_template.sftp > /tmp/sftp.sftp
		    echo "Listo para conectarme"
		    sftp -b /tmp/sftp.sftp basicas5
		    rm /tmp/"$tar_file"
	    fi
	fi
done
