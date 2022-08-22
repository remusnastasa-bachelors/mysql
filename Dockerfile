FROM mysql

RUN 'if [ -Z $MYSQL_DATABASE ]; then export MYSQL_DATABASE=enterprise; fi'

COPY ./scripts/ /docker-entrypoint-initdb.d/
