#!/bin/bash
set -x

docker rm -f some-d8 || true
docker build -t lb/d8 .
docker run --name some-d8 -p 80:80 -d \
        -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
	-e APIGEE_EDGE_AUTH_TYPE=basic \
	-e APIGEE_EDGE_ENDPOINT=https://api.enterprise.apigee.com/v1 \
	-e APIGEE_EDGE_ORGANIZATION=$APIGEE_ORG \
	-e APIGEE_EDGE_USERNAME=$APIGEE_USER \
	-e APIGEE_EDGE_PASSWORD=$APIGEE_PASS \
	lb/d8 
docker logs -f some-d8 
