#!/bin/bash

#get list of server id
echo "Retrieving Server List...."
speedtest-cli --list | awk '{print $1}' | rev | cut -c2- | tail -n +2 > output.txt

#get number of server
server_num=$(more output.txt | wc -1)

#set current testing server number
declare -i server_cur=1

#put csv header to speedtest_02.csv
echo "Adding CSV Header to file..."
speedtest-cli --csv-header --csv-delimiter '|' > speedtest_02.csv

#testing each sever.
echo "Begin Testing."
for ID in $(cut -f1 output.txt)
do
    #counter
    echo "Testing Server ID=$ID ($server_cur/$server_num)"
    #append test result to speedtest02.csv
    speedtest-cli --csv --csv-delimiter '|' >> speedtest02.csv
    #increase counter by 1
    server_cur=$(($server_cur + 1))
done
echo "Testing Done."