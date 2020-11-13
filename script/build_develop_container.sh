#!/usr/bin/env bash

cd $(dirname $0)/..

docker image build -t ryutah/sample -f ./container/develop/Dockerfile .
