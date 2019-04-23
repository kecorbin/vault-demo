#!/usr/bin/env bash
set -e
set -o pipefail

port=5000
# multiple users request credentials
for u in kevin adam; do
  echo "Generating Credentials for $u"
  vault login \
    -method=userpass \
    -no-print \
    username="$u" \
    password=password

  for i in {1..2}; do
    rm -f .env
    echo DB_SERVER=vault-demo-postgres >> .env
    creds=$(vault read --format json database/creds/webtier)
    echo DB_USER=$(echo $creds | jq -r .data.username) >> .env
    echo DB_PASSWORD=$(echo $creds | jq -r .data.password) >> .env
    echo FLASK_ENV=production >> .env
    echo APP_SETTINGS=project.config.ProductionConfig >> .env

    docker run --name "$u-web-$i" -d --rm -p "$port:$port" \
      --env-file .env \
      --link vault-demo-postgres \
      vault-demo-webapp \
      gunicorn --log-level=debug -b 0.0.0.0:"$port" manage:app
    port=$((port+1))
  done
done

vault login root
