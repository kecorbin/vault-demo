#!/usr/bin/env bash
set -e
set -o pipefail

# multiple users request credentials
for u in kevin adam; do
  echo "Generating Credentials for $u"
  vault login \
    -method=userpass \
    -no-print \
    username="$u" \
    password=password

  for i in {1..2}; do
    vault read database/creds/webtier
  done
done

vault login root
