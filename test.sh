#!/bin/sh

. ./dancer.sh

get /hi <<!
  echo "hello"
  echo "world"
!

get /test <<!
  echo "this is a test"
!

echo "* test :"
route_`dancer::cksum GET /hi`
echo "* routes :"
printf "%s\n" "$ROUTES_GET"

