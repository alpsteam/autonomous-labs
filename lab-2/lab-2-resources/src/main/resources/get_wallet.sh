#!/bin/sh

if [ $1 ]
then
        oci db autonomous-database generate-wallet --autonomous-database-id $1 --file wallet.zip --password Oracle#1
else
        echo "\nusage: $0 ocid\n"
fi

