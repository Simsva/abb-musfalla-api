CREATE TYPE event_type AS ENUM ('open', 'close');

CREATE TABLE account (id SERIAL, name VARCHAR, pass CHAR(60), email VARCHAR);
CREATE TABLE device (id SERIAL, name VARCHAR, owner_id INT);
CREATE TABLE event (t TIMESTAMP, device_id INT, type event_type);

CREATE VIEW event_unix AS SELECT
  round(date_part('epoch', event.t) * 1000::DOUBLE PRECISION)::BIGINT AS t,
  event.device_id,
  event.type
FROM event;
