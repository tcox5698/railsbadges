#!/usr/bin/env bash

docker kill "$(docker container ls --filter name=some-postgres --all -q)"

docker rm "$(docker container ls --filter name=some-postgres --all -q)"

docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD= -d postgres

sleep 3

psql -h localhost -U postgres -f "./script/db_init_user.sql"

bundle exec rails db:setup
