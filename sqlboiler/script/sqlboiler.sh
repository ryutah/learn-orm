#!/usr/bin/env bash

cd $(dirname $0)/..

sqlboiler mysql -c sqlboiler.toml
