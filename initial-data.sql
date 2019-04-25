CREATE TABLE users (
  id SERIAL NOT NULL,
  username VARCHAR(128) NOT NULL,
  email VARCHAR(128) NOT NULL,
  active BOOLEAN NOT NULL,
  admin BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (username),
  UNIQUE (email)
);

INSERT INTO users (username, email, active, admin) VALUES ('catboy', 'catboy@hq.com', 'True', 'False') RETURNING users.id;
INSERT INTO users (username, email, active, admin) VALUES ('gecko', 'gecko@hq.com', 'True', 'False') RETURNING users.id;
INSERT INTO users (username, email, active, admin) VALUES ('owlette', 'owlette@hq.com', 'True', 'False') RETURNING users.id;
