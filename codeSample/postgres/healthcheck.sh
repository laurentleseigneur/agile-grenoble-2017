#!/bin/bash
set -eo pipefail

if [ -f /var/lib/postgresql/restore.restore.inProgress ]
then
  echo "database restore in progress. Not yet healthy"
  exit 1
fi

host="$(hostname -i || echo '127.0.0.1')"
user="bonita"
db="bonita"
export PGPASSWORD="bpm"

args=(
	# force postgres to not use the local unix socket (test "external" connectibility)
	--host "$host"
	--username "$user"
	--dbname "$db"
	--quiet --no-align --tuples-only
)

if select="$(echo 'SELECT 1' | psql "${args[@]}")" && [ "$select" = '1' ]; then
	echo "Healthy"
	exit 0
fi

echo "UnHealthy"
exit 1