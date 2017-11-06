# This image is based on postgres 9.3 image

## additions

### configuration

set required `max_prepared_transactions` setting required by Bonita


### databases

create user and database `bonita` and `business_data`, with password `bpm`

## build it

    Note: tag is just an argument and is not provided by Dockerfile. so 

```
# will use 'latest' as tag  
docker build -t registry.rd.lan/bonitasoft/postgres-9.3 .`
```

## deploy to internal registry

```
# will use 'latest' as tag  
docker push registry.rd.lan/bonitasoft/postgres-9.3
```

### restore dump

It will restore dumps present in the volume /opt/bonita/dump

dumps must be named `bonita.dump` and `business_data.dump`

create those dump using

```
pg_dump -h localhost -p 5432 -Ubonita bonita> /opt/bonita/dump/bonita.dump
pg_dump -h localhost -p 5432 -Ubusiness_data business_data> /opt/bonita/dump/business_data.dump
```

then run the docker using volume `-v <path to dumps>:/opt/bonita/dump`

    Note: if container already exists, it must be removed, using `docker rm <CONTAINER_ID>`, unless restore won't be applied

## run it

default way

```
# will use 'latest' as tag  
docker run -p 5432:5432 -d registry.rd.lan/bonitasoft/postgres-9.3
```

recommended way, to have datafiles out of container 

```
# will use 'latest' as tag  
docker run -p 5432:5432 -d -v "/PATH_TO_DATA_FILES:/var/lib/postgresql/data" registry.rd.lan/bonitasoft/postgres-9.3
```


with local volume for backup/restore and script exchange

```
# will use 'latest' as tag  
docker run -p 5432:5432 -d -v "/PATH_TO_DATA_FILES:/var/lib/postgresql/data" -v"/MY_SQL_FOLDER:/opt/bonita/sql" registry.rd.lan/bonitasoft/postgres-9.3 
```

## shell

`docker exec -ti <CONTAINER_ID> bash`
