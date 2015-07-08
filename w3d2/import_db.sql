DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Jesse', 'Latimer'), ('Ned', 'Stark'), ('Bobby', 'Fischer'), ('Robert', 'Jordan'), ('Ed', 'Huang');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('First question?', 'This is the first question?', (SELECT id FROM users WHERE fname = 'Jesse' AND lname = 'Latimer')),
  ('Second question?', 'This is the second question?', (SELECT id FROM users WHERE fname = 'Ed' AND lname = 'Huang')),
  ('Third question?', 'This is the third question?', (SELECT id FROM users WHERE fname = 'Robert' AND lname = 'Jordan')),
  ('Fourth question?', 'This is the fourth question?', (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'Stark')),
  ('Fifth question?', 'This is the fifth question?', (SELECT id FROM users WHERE fname = 'Bobby' AND lname = 'Fischer'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Jesse' AND lname = 'Latimer'), 2),
  ((SELECT id FROM users WHERE fname = 'Ed' AND lname = 'Huang'), 5),
  ((SELECT id FROM users WHERE fname = 'Robert' AND lname = 'Jordan'), 3);

INSERT INTO
  replies (question_id, parent_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'First question?'), NULL, (SELECT id FROM users WHERE fname = 'Ed' AND lname = 'Huang')),
  ((SELECT id FROM questions WHERE title = 'Third question?'), NULL, (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'Stark')),
  ((SELECT id FROM questions WHERE title = 'Third question?'), 2, (SELECT id FROM users WHERE fname = 'Bobby' AND lname = 'Fischer'));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bobby' and lname = 'Fischer'), 4),
  ((SELECT id FROM users WHERE fname = 'Ed' and lname = 'Huang'), 4),
  ((SELECT id FROM users WHERE fname = 'Ned' and lname = 'Stark'), 4),
  ((SELECT id FROM users WHERE fname = 'Robert' and lname = 'Jordan'), 4),
  ((SELECT id FROM users WHERE fname = 'Jesse' and lname = 'Latimer'), 3),
  ((SELECT id FROM users WHERE fname = 'Ned' and lname = 'Stark'), 1);
