#!/bin/bash
#images pipe to selext image
curl -s --unix-socket /var/run/docker.sock   0.0.0.0/v1.42/images/json | jq -r '.[] | select(.RepoTags[] | test("alpine:*")) | .RepoTags[0]'
#id
id="$(curl -s --unix-socket /var/run/docker.sock 0.0.0.0/v1.42/containers/json | jq -r '.[0].Id')"
#inspect
curl -s --unix-socket "/var/run/docker.sock 0.0.0.0/v1.42/containers/${id}/json"
# stats
curl -s --unix-socket "/var/run/docker.sock 0.0.0.0/v1.42/containers/${id}/stats" 
# kill
curl -s -XPOST --unix-socket "/var/run/docker.sock 0.0.0.0/v1.42/containers/${id}/kill"
#docker API create container
#https://docs.docker.com/engine/api/v1.42/#tag/Container/operation/ContainerCreate
#https://docs.docker.com/engine/api/sdk/examples/