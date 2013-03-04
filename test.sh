#!/bin/sh
# vim: set softtabstop=2 shiftwidth=2 expandtab :

. ./dancer.sh

get /hi <<!
  echo "hello get"
!

get '/test' <<!
  echo "this is a test"
!

post /hi <<!
  echo "hello post"
!

put /hi <<!
  echo "hello put"
!

delete /hi <<!
  echo "hello delete"
!

echo "* tests :"
route_`dancer_cksum GET /hi`
route_`dancer_cksum POST /hi`
route_`dancer_cksum PUT /hi`
route_`dancer_cksum DELETE /hi`

echo "* routes :"
printf "GET : %s\n" "$ROUTES_GET"
printf "POST : %s\n" "$ROUTES_POST"
printf "PUT : %s\n" "$ROUTES_PUT"
printf "DELETE : %s\n" "$ROUTES_DELETE"


