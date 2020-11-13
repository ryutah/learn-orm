#!/usr/bin/env bash

cd $(dirname $0)/..

gcloud --quiet builds submit --config ./container/develop/cloudbuild.yaml .
