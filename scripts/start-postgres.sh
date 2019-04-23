#!/usr/bin/env bash
set -e
set -o pipefail

docker kill vault-demo-postgres &>/dev/null || true
docker rm vault-demo-postgres &>/dev/null || true
docker run --name=vault-demo-postgres --rm -d -p 5432:5432 -e POSTGRES_DB=my-postgresql-database postgres
echo "==> Done!"

export PGHOST="localhost"
export PGUSER="postgres"
export PGDATABASE="my-postgresql-database"

exec "${SHELL}"

docker exec -ti vault-demo-postgres psql -U postgres -d my-postsgresql-database
