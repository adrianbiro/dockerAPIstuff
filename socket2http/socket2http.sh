#!/bin/bash
#publish socket on 0.0.0.0:2376
sudo ncat -kl -p 2376 -c 'ncat -U /run/docker.sock'