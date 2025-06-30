-- PostgreSQL initial migration

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(32) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE group_members (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  group_id INTEGER REFERENCES groups(id),
  role VARCHAR(32),
  status VARCHAR(32)
);

CREATE TABLE rehearsals (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  datetime TIMESTAMP,
  location VARCHAR(255),
  notes TEXT,
  created_by INTEGER REFERENCES users(id)
);

CREATE TABLE rsvps (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  user_id INTEGER REFERENCES users(id),
  status VARCHAR(32)
);

CREATE TABLE setlists (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  name VARCHAR(255),
  notes TEXT
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  setlist_id INTEGER REFERENCES setlists(id),
  title VARCHAR(255),
  artist VARCHAR(255),
  order_num INTEGER
);

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  user_id INTEGER REFERENCES users(id),
  message TEXT,
  timestamp TIMESTAMP DEFAULT NOW()
);