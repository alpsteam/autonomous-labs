#!/bin/sh

oci setup config

echo "\n"
grep 'fingerprint' ~/.oci/config
echo "Add this as API key in OCI console\n"
cat ~/.oci/oci_api_key_public.pem
echo "\n"

