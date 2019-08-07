#!/bin/sh

echo Enter your Autonomous Database OCID:
read ocid
echo Enter your Autonomous Database password:
read dbpw
oci db autonomous-database generate-wallet --autonomous-database-id $ocid --file src/main/resources/wallet.zip --password $dbpw
        cd src/main/resources
        unzip wallet.zip
        echo $dbpw > atp_password.txt
        cd -

