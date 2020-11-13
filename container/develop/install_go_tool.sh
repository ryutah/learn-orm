#!/usr/bin/env bash

cat tools.go | awk -F'"' '/_/ {print $2}' | xargs -tI {} go install {}
