#!/usr/bin/env bash

cd $(dirname $0)/..

migrate -path ./db/migrations -database 'mysql://user:pass@tcp(host.docker.internal:3306)/sample' up
