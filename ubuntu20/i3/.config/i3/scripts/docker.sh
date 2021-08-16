#!/usr/bin/env bash

# Number of docker containers running
count=$(docker ps -q | wc -l | sed -r 's/^0$//g')
# Recent docker container IP
recent_ip=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $(docker ps -ql))

echo "$LABEL$count: $recent_ip"
