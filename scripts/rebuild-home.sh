#!/usr/bin/env bash

if [ ! -z $1 ]; then
  export HOST=$1
else
  export HOST=$(hostname)
fi

if [ ! -z $2 ]; then
  export USER=$2
else
  export USER=$(whoami)
fi

home-manager switch --flake .#$USER@$HOST
