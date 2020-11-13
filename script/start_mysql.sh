#!/usr/bin/env bash

set -eu

cd $(dirname $0)/..

docker-compose down
docker-compose up -d
docker run --rm jwilder/dockerize -wait tcp://host.docker.internal:3306 -timeout 3m -wait-retry-interval 1s

until mysql -h"host.docker.internal" -u"user" -p"pass" -P"3306" -e "SELECT 1" > /dev/null 2>&1;
do
  echo -n "."
  sleep 1
done
echo "MySQL is up - executing command"

bash ./script/migrate.sh
mysql -u"user" -p"pass" -h"host.docker.internal" -P"3306" sample < ./db/testdata/data.sql
