CREATE TABLE books (
  id INT PRIMARY KEY,
  genre VARCHAR(255),
  author VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN,
  publisher VARCHAR(255),
  cover_state VARCHAR(255)
);

CREATE TABLE labels (
  id INT PRIMARY KEY,
  title VARCHAR(255),
  color VARCHAR(255)
);
