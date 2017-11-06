#!/bin/bash
set -e
##
##  Restore dumps from volume /opt/bonita/dump
##  dumps should have name bonita.dump and business_data.dump
##  dump using: pg_dump -h localhost -p 5432 -Ubonita bonita> bonita.dump

if [ -f /var/lib/postgresql/restore.lastExecution ]
then
  "Restore already executed: skipping dump restoration."
else
  touch /var/lib/postgresql/restore.inProgress
  if [ -f /opt/bonita/dump/bonita.dump ]
  then
    psql -h localhost -p 5432 -Ubonita bonita < /opt/bonita/dump/bonita.dump
    date > /var/lib/postgresql/restore.lastExecution
  fi
  if [ -f /opt/bonita/dump/business_data.dump ]
  then
    psql -h localhost -p 5432 -Ubusiness_data business_data < /opt/bonita/dump/business_data.dump
    date > /var/lib/postgresql/restore.lastExecution
  fi
  rm /var/lib/postgresql/restore.inProgress
fi
