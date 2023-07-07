CREATE TABLE
    author (
        id int generated always as identity,
        fisrt_name VARCHAR(250) NOT NULL,
        last_name VARCHAR(250) NOT NULL,
        PRIMARY KEY (id)
    );

CREATE TABLE
    game (
        id int generated always as identity,
        publish_date DATE,
        author_id INT NOT NULL,
        archived BOOLEAN NOT NULL,
        multiplayer VARCHAR(250) NOT NULL,
        last_played_at DATE,
        CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author(id),
        primary key (id)
    );