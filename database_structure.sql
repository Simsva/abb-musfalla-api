CREATE TYPE event_type AS ENUM ('open', 'close');

CREATE TABLE account (
  id SERIAL,
  name VARCHAR,
  pass CHAR(60) NOT NULL,
  email VARCHAR NOT NULL
);
CREATE TABLE device (
  id SERIAL,
  name VARCHAR,
  owner_id INT NOT NULL
);
CREATE TABLE event (
  t TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  device_id INT NOT NULL,
  type event_type NOT NULL
);
CREATE TABLE auth_token (
  uid INT NOT NULL,
  token CHAR(64) NOT NULL,
  until TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now() + interval '24 hour'
);

CREATE VIEW event_unix AS SELECT
  round(date_part('epoch', event.t) * 1000::DOUBLE PRECISION)::BIGINT AS t,
  event.device_id,
  event.type
FROM event;
