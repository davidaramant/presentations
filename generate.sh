#!/bin/bash

docker build -t mkslides:latest .

docker run --rm -v ./presentations:/presentations mkslides:latest