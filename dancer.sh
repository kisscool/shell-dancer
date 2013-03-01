#!/bin/sh
# vim: set softtabstop=2 shiftwidth=2 expandtab :
# Original author : KissCool
# Created         : 2013
# License         : MIT license

#####################################################################
# Theory :
#####################################################################

# A route is the combination of an HTTP method (GET, POST, PUT, DELETE) and a path ('/path/to/resource').
# Each defined route (throught the use of high level functions get(), post(), put(), delete()) is
# associated with a dynamic function which contains the business logic of this particular route.
# Those route-handling functions are named route_$cksum(), where $cksum is a unique identifier.
# All the registered paths are stored in variables named $ROUTES_$METHOD, where $METHOD is the
# HTTP method of the associated route.


#####################################################################
# Private (internal) functions
#####################################################################


# This function will output a unique and reproductible checksum from a string,
# which in our case is a route. We use this unique checksum to name and retrieve
# the route-handling functions.
# 
# arguments :
# - $* : strings
#
# example :
#     dancer::cksum GET /hi
#
dancer::cksum() {
  local strings="$*"
  printf '%s' "$strings" | cksum | cut -d' ' -f1
}

# This function is used behind the scene inside route definitions.
# It defines a route_$method_$path() with $method equal to the HTTP
# method (GET, POST, PUT, DELETE) and $path equal to the pattern provided
# as an argument to the route definition.
# This new defined function contains the logic of the web application and
# output the answer to the request.
#
# arguments :
# - $1 : HTTP method (GET, POST, PUT or DELETE)
# - $2 : path
# - stdin : logic to execute when this route is used
#
# example :
#     dancer::add_route GET /hi <<!
#         echo "hi"
#     !
#
dancer::add_route() {
  content=`cat /dev/stdin`;
  local method=$1;
  local path=$2;
  local cksum=`dancer::cksum ${method} ${path}`
  # yet again the power of eval comes
  # as our savior for some dynamic
  # function definition
  eval "
    route_${cksum}() {
      $content
    }
  "
  # register the new route
  # this is not as readable as I would like it to be
  export ROUTES_${method}=`eval 'echo $ROUTES_'$method`" ${path}"
}


#####################################################################
# Public functions
#####################################################################


# This function defines a new route for a GET HTTP request.
# It uses dancer::add_route() behind the scene.
#
# arguments :
# - $1 : path
# - stdin : logic to execute when this route is used
#
# example :
#     get /hi <<!
#       echo "hi"
#     !
#
get() {
  content=`cat /dev/stdin`;
  local path=$1;
  dancer::add_route GET $path <<!
    $content
!
}

# This function defines a new route for a POST HTTP request.
# It uses dancer::add_route() behind the scene.
#
# arguments :
# - $1 : path
# - stdin : logic to execute when this route is used
#
# example :
#     post /hi <<!
#       create something
#     !
#
post() {
  content=`cat /dev/stdin`;
  local path=$1;
  dancer::add_route POST $path <<!
    $content
!
}

# This function defines a new route for a PUT HTTP request.
# It uses dancer::add_route() behind the scene.
#
# arguments :
# - $1 : path
# - stdin : logic to execute when this route is used
#
# example :
#     put /hi <<!
#       update/replace something
#     !
#
put() {
  content=`cat /dev/stdin`;
  local path=$1;
  dancer::add_route PUT $path <<!
    $content
!
}

# This function defines a new route for a DELETE HTTP request.
# It uses dancer::add_route() behind the scene.
#
# arguments :
# - $1 : path
# - stdin : logic to execute when this route is used
#
# example :
#     delete /hi <<!
#       annihilate something
#     !
#
delete() {
  content=`cat /dev/stdin`;
  local path=$1;
  dancer::add_route DELETE $path <<!
    $content
!
}
