#!/bin/bash

# $dbs will contain db names and sizes mixed together
# Use --quiet to skip connection information

bkp_dir=$(date +"%m-%d-%y")

bkp_path=/mnt/mongo_data/backup


###################################################

dbs=$(mongo --quiet <<EOF
show dbs
quit()
EOF
)
i=0
for db in ${dbs[*]}
do
    # Odd values are db names
    # Even values are sizes
    i=$(($i+1))
    # Show db name, ignore size
    if (($i % 2)); then
        echo "$db"
        sudo mongodump --gzip --db $db --out $bkp_path/$bkp_dir
        
    fi

done



#delete directories older than 5 days
find /mnt/mongo_data/backup/* -type d -mtime +5 -delete

