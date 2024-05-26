CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE friendship (
    user_id1 INT NOT NULL,
    user_id2 INT NOT NULL,
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES users(id),
    FOREIGN KEY (user_id2) REFERENCES users(id)
);

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    tmdb_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE (user_id, tmdb_id)
);