#!/usr/bin/env bash
if [[ -v CODESPACES ]]; then
  sudo apt-get update
  sudo apt-get install -y awscli
  sudo pip3 install aws-mfa j2cli

  mkdir ~/.aws
  j2 -o ~/.aws/config templates/aws_config.j2
  j2 -o ~/.aws/credentials templates/aws_credentials.j2
fi
