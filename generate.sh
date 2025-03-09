#!/bin/bash

docker build -t mdslides:latest .

docker run --rm -v ./presentations:/presentations --env-file=.env mdslides:latest