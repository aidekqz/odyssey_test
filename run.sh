#!/bin/bash
set -ex

ulimit -c 20000
docker rm --force postgres 2>/dev/null || true
docker run --name postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres
sleep 5
docker exec -it postgres bash -c "sed -i 's/scram-sha-256/md5/g' /var/lib/postgresql/data/pg_hba.conf"
sleep 2
psql "host=127.0.0.1 port=5432 user=postgres password=123456 dbname=postgres" -f init.sql
./odyssey ./odyssey.conf
pgrep odyssey
psql "host=127.0.0.1 port=6432 user=postgres password=123456 dbname=postgres" -c "SELECT 1" && echo "OK"
kill -s HUP $(pgrep odyssey)
psql "host=127.0.0.1 port=6432 user=postgres password=123456 dbname=postgres" -c "SELECT 1" || echo "Failed"
ls -alht /var/lib/apport/coredump/