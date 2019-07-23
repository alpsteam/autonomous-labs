#!/bin/sh

if [ $1 ]
then
        oci db autonomous-database generate-wallet --autonomous-database-id $1 --file src/main/resources/wallet.zip --password Oracle#1ab
        unzip src/main/resources/wallet.zip
        echo "Oracle#1ab" > src/main/resources/atp_password.txt



else
        echo "\nusage: $0 ocid\n"
fi

