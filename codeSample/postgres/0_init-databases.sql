
CREATE ROLE bonita LOGIN PASSWORD 'bpm';

CREATE DATABASE bonita
  WITH OWNER = bonita
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

GRANT CONNECT, TEMPORARY ON DATABASE bonita TO public;

GRANT ALL ON DATABASE bonita TO bonita;


CREATE ROLE business_data LOGIN PASSWORD 'bpm';

CREATE DATABASE business_data
  WITH OWNER = business_data
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

GRANT CONNECT, TEMPORARY ON DATABASE business_data TO public;

GRANT ALL ON DATABASE business_data TO business_data;