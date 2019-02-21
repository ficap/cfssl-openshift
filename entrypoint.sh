#!/bin/bash
set -x

POSTGRESQL_HOST=$CFSSL_DB_SERVICE_HOST
export POSTGRESQL_HOST

if [[ $# -gt 0 ]]; then
    exec "$@"
fi

printf "{\"driver\":\"postgres\",\"data_source\":\"postgres://$POSTGRESQL_USER:$POSTGRESQL_PASSWORD@$POSTGRESQL_HOST:5432/cfssl\"}" > /var/lib/cfssl/db-config.json

cfssl serve -address=$BIND_ADDRESS -ca=/var/lib/cfssl/data/ca.pem -ca-key=/var/lib/cfssl/data/ca-key.pem
