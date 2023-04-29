#!/bin/bash

tag1=`sed -n '7p' pom.xml | awk -F ">" '{print $2}'|awk -F "-" '{print $1}'`
docker version
docker build -t my-app .
docker tag demo rakesh96/new-repo:$tag1
docker push rakesh96/new-repo:$tag1
sed -i "s/latest/$tag1/g" deployment_demo.yml
