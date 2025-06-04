DROP DATABASE IF EXISTS SimulazioneFM24Italia;
CREATE DATABASE SimulazioneFM24Italia;
USE SimulazioneFM24Italia;

CREATE TABLE Squadre (
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE Competizioni (
    categoria VARCHAR(1) NOT NULL CHECK (categoria IN ('A', 'B', 'C')),
    PRIMARY KEY (categoria)
);

CREATE TABLE Stagioni (
    annata VARCHAR(9) NOT NULL,
    PRIMARY KEY (annata),
    CHECK (
        annata REGEXP '^[0-9]{4}-[0-9]{4}$'
        AND SUBSTRING(annata, 6, 4) = CAST(SUBSTRING(annata, 1, 4) AS UNSIGNED) + 1
    )
);

CREATE TABLE Partecipazioni (
    squadra VARCHAR(255) NOT NULL,
    competizione VARCHAR(1) NOT NULL,
    stagione VARCHAR(9) NOT NULL,
    PRIMARY KEY (squadra, competizione, stagione),
    FOREIGN KEY (squadra) REFERENCES Squadre(nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (competizione) REFERENCES Competizioni(categoria)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (stagione) REFERENCES Stagioni(annata)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Performance (
    squadra VARCHAR(255) NOT NULL,
    stagione VARCHAR(9) NOT NULL,
    punti INT NOT NULL CHECK (punti >= 0),
    golFatti INT NOT NULL CHECK (golFatti >= 0),
    golSubiti INT NOT NULL CHECK (golSubiti >= 0),
    PRIMARY KEY (squadra, stagione),
    FOREIGN KEY (squadra) REFERENCES Squadre(nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (stagione) REFERENCES Stagioni(annata)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Competizioni (categoria) VALUES ('A'), ('B'), ('C');
