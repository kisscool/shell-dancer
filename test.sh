#!/bin/sh
# vim: set softtabstop=2 shiftwidth=2 expandtab :

. ./dancer.sh



debug() {
  echo "* routes :"
  printf "GET : %s\n" "$ROUTES_GET"
  printf "POST : %s\n" "$ROUTES_POST"
  printf "PUT : %s\n" "$ROUTES_PUT"
  printf "DELETE : %s\n" "$ROUTES_DELETE"
} 

get / <<!
  echo "<h1>Ah oui &ccedil;a marche</h1>"
  echo "<p>Essaye d'aller sur <a href=\"http://${SERVER_NAME}/hi\">/hi</a></p>"
  debug
!

get /hi <<!
  echo "<h1>hello get</h1>"
  echo
  echo "<p>eh oui, c'est bel et bien shelldancer en action :)</p>"
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
