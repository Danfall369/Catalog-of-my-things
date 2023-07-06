CREATE TABLE game(
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    multiplayer VARCHAR(255) NOT NULL,
    last_played_at DATE NOT NULL,
    FOREIGN KEY (item_id) REFERENCES item (id)
);
