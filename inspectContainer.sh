#!/bin/bash
#inspect
curl -s "http://0.0.0.0:2376/containers/$(curl -s http://0.0.0.0:2376/containers/json | jq -r '.[0].Id')/json"
# stats
curl -s "http://0.0.0.0:2376/containers/$(curl -s http://0.0.0.0:2376/containers/json | jq -r '.[0].Id')/stats" 
# kill
curl -s -XPOST "http://0.0.0.0:2376/containers/$(curl -s http://0.0.0.0:2376/containers/json | jq -r '.[0].Id')/kill"