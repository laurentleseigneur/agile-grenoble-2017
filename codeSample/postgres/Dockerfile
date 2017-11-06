FROM postgres:9.3

MAINTAINER Laurent Leseigneur <laurent.leseigneur@bonitasoft.com>

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# restore dump on startup if dumpfile is present
VOLUME /opt/bonita/dump

COPY 0_init-databases.sql /docker-entrypoint-initdb.d/0_init-databases.sql
COPY 1_set-max_prepared_transactions.sh /docker-entrypoint-initdb.d/1_set-max_prepared_transactions.sh
COPY 2_restore_dump.sh /docker-entrypoint-initdb.d/2_restore_dump.sh
COPY healthcheck.sh /usr/local/bin/healthcheck.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/local/bin/healthcheck.sh"]