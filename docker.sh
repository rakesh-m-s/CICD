#!/bin/bash

docker version
docker build -t rakesh96/my-app .
docker tag demo rakesh96/my-app
docker push rakesh96/my-app
