#!/bin/bash
# Copyright 2019, Oracle Corporation and/or its affiliates. All rights reserved.

cat <<EOF | kubectl apply -f -
kind: Secret
apiVersion: v1
metadata:
  name: atp-secret
  namespace: alpha-office
type: Opaque
data:
  ojdbc.properties: `cat /Users/eshneken/OCI/Wallet_ATP/ojdbc.properties | base64`
  tnsnames.ora: `cat /Users/eshneken/OCI/Wallet_ATP/tnsnames.ora | base64`
  sqlnet.ora: `cat /Users/eshneken/OCI/Wallet_ATP/sqlnet.ora | base64`
  cwallet.sso: `cat /Users/eshneken/OCI/Wallet_ATP/cwallet.sso | base64`
  ewallet.p12: `cat /Users/eshneken/OCI/Wallet_ATP/ewallet.p12 | base64`
  keystore.jks: `cat /Users/eshneken/OCI/Wallet_ATP/keystore.jks | base64`
  truststore.jks: `cat /Users/eshneken/OCI/Wallet_ATP/truststore.jks | base64`
  atp_password.txt: `cat /Users/eshneken/OCI/Wallet_ATP/atp_password.txt | base64`
EOF