USE my_database;

DROP TABLE IF EXISTS suivre;
DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS sport;
DROP TABLE IF EXISTS categorie;
DROP TABLE IF EXISTS utilisateur;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    date_naissance DATE NOT NULL,
    email          VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe   VARCHAR(255) NOT NULL,  -- stocke le hash de password_hash()
    role           ENUM('utilisateur', 'admin') NOT NULL DEFAULT 'utilisateur'
);

CREATE TABLE categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL UNIQUE,
    description  TEXT
);

CREATE TABLE sport (
    id_sport     INT AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL UNIQUE,
    description  TEXT NOT NULL,
    regles       TEXT NOT NULL,
    origine      TEXT,
    materiel     TEXT,
    id_categorie INT NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE image (
    id_image INT AUTO_INCREMENT PRIMARY KEY,
    url      VARCHAR(255) NOT NULL,
    legende  VARCHAR(255),
    id_sport INT NOT NULL,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE
);

CREATE TABLE suivre (
    id_utilisateur INT NOT NULL,
    id_sport       INT NOT NULL,
    PRIMARY KEY (id_utilisateur, id_sport),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE
);

-- Données de test
INSERT INTO categorie (nom, description) VALUES
    ('Sports collectifs', 'Sports qui se jouent en equipe'),
    ('Sports individuels', 'Sports qui se pratiquent seul');

INSERT INTO sport (nom, description, regles, origine, materiel, id_categorie) VALUES
    ('Quidditch', 'Sport inspire de Harry Potter, joue avec un balai entre les jambes', 'Marquer en lancant le souafle dans les anneaux adverses', 'Etats-Unis', 'Balais, ballons, anneaux', 1),
    ('Ultimate frisbee', 'Sport collectif sans contact avec un disque', 'Attraper le disque dans la zone adverse pour marquer', 'Etats-Unis', 'Un frisbee', 1),
    ('Hobby horsing', 'Sport ou l on mime l equitation avec un cheval baton', 'Parcours de sauts et de dressage avec un cheval baton', 'Finlande', 'Un cheval baton', 2);
