#!/bin/bash
#docker API create container
#https://docs.docker.com/engine/api/v1.42/#tag/Container/operation/ContainerCreate
image=$(curl --silent http://0.0.0.0:2376/images/json | jq -r '.[] | select(.RepoTags[] | test("alpine:*")) | .RepoTags[0]')


