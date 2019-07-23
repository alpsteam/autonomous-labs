#!/bin/sh

if [ $1 ]
then
        oci db autonomous-database generate-wallet --autonomous-database-id $1 --file src/main/resources/wallet.zip --password Oracle#1ab
        cd src/main/resources
        unzip wallet.zip
        echo "Oracle#1ab" > atp_password.txt
        cd -

else
        echo "\nusage: $0 ocid\n"
fi

