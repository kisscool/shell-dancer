#!/bin/sh

. ./test.sh



finalize_environment() {
	CONTENT_TYPE=${CONTENT_TYPE:-text/html}
}

# On veut savoir où dispatcher le contenu de PATH_INFO.
eval "ROUTES=\${ROUTES_${REQUEST_METHOD}}"

CHOSEN_ROUTE=
for i in $ROUTES; do
	if [ -z "${PATH_INFO##$i}" ]; then
		CHOSEN_ROUTE="$i"
	fi
done

if [ -z "$CHOSEN_ROUTE" ]; then
	echo "Status: 404 Not found"
	echo
	exit 0
else
	response=$(route_$(dancer_cksum ${REQUEST_METHOD} ${CHOSEN_ROUTE}); echo x)
	response=${response%?}

	finalize_environment

	echo "Status: 200 OK"
	echo "Content-type: ${CONTENT_TYPE}"
	echo
	echo ${response}

	exit $?
fi
