CREATE TABLE user (
  id                      INTEGER AUTO_INCREMENT,
  first_name              VARCHAR(255),
  last_name               VARCHAR(255),
  email                   VARCHAR(255),
  password                BINARY(60),
  phone_number            VARCHAR(255),
  reservations_banned     BOOLEAN,
  last_login_datetime     DATETIME,

  PRIMARY KEY (id)
);


CREATE TABLE registration (
  id        INTEGER AUTO_INCREMENT,
  status    VARCHAR(3),

  user_fk   INTEGER,

  FOREIGN KEY (user_fk) REFERENCES user(id),
  PRIMARY KEY (id)
);

CREATE TABLE notification (
  id        INTEGER AUTO_INCREMENT,
  user_fk   INTEGER,
  seen      BOOLEAN,
  message   VARCHAR(255),

  FOREIGN KEY (user_fk) REFERENCES user(id),
  PRIMARY KEY (id)
);

CREATE TABLE feedback (
  id           INTEGER AUTO_INCREMENT,
  user_fk      INTEGER,
  rate         SMALLINT,
  comment      VARCHAR(255),
  festival_fk  INTEGER,

  FOREIGN KEY (user_fk) REFERENCES user(id),
  FOREIGN KEY (festival_fk) REFERENCES festival(id),
  PRIMARY KEY (id)
);

CREATE TABLE location (
  id            INTEGER AUTO_INCREMENT,
  description   TEXT,

  PRIMARY KEY (id)
);


CREATE TABLE festival (
  id                INTEGER AUTO_INCREMENT,
  name              VARCHAR(255),
  datetime_start    DATETIME,
  datetime_end      DATETIME,
  location_fk       INTEGER,
  tickets_per_user  INTEGER,
  views             BIGINT,

  FOREIGN KEY (location_fk) REFERENCES location(id),
  PRIMARY KEY (id)

  /* many to many to performer */
);


CREATE TABLE festivalday (
  id          INTEGER AUTO_INCREMENT,
  date        DATE,

  festival_fk INTEGER,

  FOREIGN KEY (festival_fk) REFERENCES festival(id),
  PRIMARY KEY (id)
);


CREATE TABLE performer (
  id      INTEGER,
  name    VARCHAR(255),

  PRIMARY KEY (id)
);


CREATE TABLE festivaldayperformer (
  id              INTEGER AUTO_INCREMENT,

  performer_fk    INTEGER,
  festivalday_fk  INTEGER,

  FOREIGN KEY (festivalday_fk) REFERENCES festivalday(id),
  FOREIGN KEY (performer_fk) REFERENCES performer(id),
  PRIMARY KEY (id)
);


CREATE TABLE rating (
  id            INTEGER AUTO_INCREMENT,
  value         INTEGER,
  user_fk       INTEGER,
  festival_fk   INTEGER,

  FOREIGN KEY (user_fk) REFERENCES user(id),
  FOREIGN KEY (festival_fk) REFERENCES user(id),
  PRIMARY KEY (id)
);

CREATE TABLE ticket_festivalday (
  id             INTEGER AUTO_INCREMENT,
  ticket_fk      INTEGER,
  festivalday_fk INTEGER,

  FOREIGN KEY (ticket_fk) REFERENCES ticket(id),
  FOREIGN KEY (festivalday_fk) REFERENCES festivalday(id),
  PRIMARY KEY (id)
);

CREATE TABLE ticket (
  id            INTEGER AUTO_INCREMENT,
  volume        INTEGER,
  price         NUMERIC,
  type_fk       INTEGER,

  FOREIGN KEY (type_fk) REFERENCES tickettype(id),
  PRIMARY KEY (id)
);


CREATE TABLE type (
  id      INTEGER AUTO_INCREMENT,
  name    VARCHAR(3),

  PRIMARY KEY (id)
);

CREATE TABLE ticketreservation (
  id         INTEGER AUTO_INCREMENT NULL,
  status     VARCHAR(3),
  ticket_fk  INTEGER,
  user_fk    INTEGER,

  FOREIGN KEY (user_fk) REFERENCES user(id),
  FOREIGN KEY (ticket_fk) REFERENCES ticket(id),
  PRIMARY KEY (id)
);

CREATE TRIGGER ticket_bought (

);

CREATE TABLE media (
  id       INTEGER AUTO_INCREMENT,
  path     TEXT,

  PRIMARY KEY (id)
);

CREATE TABLE festivalmedia (
  id            INTEGER AUTO_INCREMENT,
  festival_fk   INTEGER,
  media_fk      INTEGER,

  FOREIGN KEY (festival_fk) REFERENCES festival(id),
  FOREIGN KEY (media_fk) REFERENCES media(id),
  PRIMARY KEY (id)
);

/*
[extras]
Login Audit:
    - loggin_attempt: ...
    -
*/
