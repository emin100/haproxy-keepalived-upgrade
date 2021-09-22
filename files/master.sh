#!/bin/bash
status_code=$(curl --write-out %{http_code} --silent --output /dev/null $HAPROXY_SERVER_ADDR:8008/master)
nc -z $HAPROXY_SERVER_ADDR $HAPROXY_SERVER_PORT

port_status=$?

if [[ "$status_code" -eq 200 && "$port_status" -eq 0 ]] ; then
  exit 0
else
  exit 1
fi