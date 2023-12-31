#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL

  CREATE DATABASE $APP_DB_NAME;

  CREATE ROLE $APP_DB_USER LOGIN PASSWORD '$APP_DB_PASSWORD';

  ALTER ROLE $APP_DB_USER SET client_encoding TO 'utf8';

  ALTER ROLE $APP_DB_USER SET default_transaction_isolation TO 'read committed';

  ALTER ROLE $APP_DB_USER SET timezone TO 'UTC';

  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;

EOSQL
