#!/usr/bin/env bash
if [[ -v CODESPACES ]]; then
  sudo apt-get update
  sudo apt-get install awscli
  sudo pip3 install aws-mfa j2cli
fi
