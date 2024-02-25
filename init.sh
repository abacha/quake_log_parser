#!/bin/bash

if [ "$1" == "docker" ]; then
  docker build . -t quake_log_parser
  if [ "$2" == "run" ]; then
    docker run -it quake_log_parser ./bin/quake_log_parser $3
  elif [ "$2" == "tests" ]; then
    docker run -it quake_log_parser bundle exec rspec --format documentation
  fi
else
  echo Invalid Option
fi
