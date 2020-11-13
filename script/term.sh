#!/usr/bin/env bash

cd $(dirname $0)/..

docker container run -it --rm \
  -v $(pwd):/root/app \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ryutah/sample bash
