#!/bin/bash
sudo ncat -kl -p 2376 -c 'ncat -U /run/docker.sock'