## Diagramme UML

Voici ce que j'ai produit comme modèle conceptuel de données :

<img width="1093" height="1098" alt="Modèle conceptuel de données" src="https://github.com/user-attachments/assets/20ba26df-271b-4d49-931d-eb8e489553bb" />

J'ai ensuite demandé à l'IA de m'aider à développer le reste (MCD détaillé, MLD, MPD) pour gagner du temps.

---

## 1. MCD (Modèle Conceptuel de Données)

### Entités et attributs

L'identifiant de chaque entité est souligné par un `_`.

| UTILISATEUR       | CATEGORIE       | SPORT         | IMAGE       |
|-------------------|-----------------|---------------|-------------|
| `_id_utilisateur` | `_id_categorie` | `_id_sport`   | `_id_image` |
| nom               | nom             | nom           | url         |
| prenom            | description     | description   | legende     |
| age               |                 | regles        |             |
| email             |                 | origine       |             |
| mot_de_passe      |                 | materiel      |             |

### Associations et cardinalités

```
CATEGORIE (0,n) ────── CONTENIR ────── (1,1) SPORT
SPORT     (0,n) ────── ILLUSTRER ───── (1,1) IMAGE
```

### Comment lire le schéma

- **Contenir** : une catégorie contient 0 à plusieurs sports, et un sport appartient à une seule catégorie.
- **Illustrer** : un sport a 0 à plusieurs images, et une image appartient à un seul sport.
- **Utilisateur** n'est relié à aucune autre entité pour l'instant : il sert seulement à se connecter. Avec des favoris ou des commentaires, on ajouterait une association.

> **Astuce :** la cardinalité se lit du côté opposé. « Un sport → (1,1) catégorie » signifie qu'un sport a exactement une catégorie.

---

## 2. MLD (Modèle Logique de Données)

**Règle de passage :** quand une association est de type 1,n (un côté à 1,1), on place l'identifiant du côté « n » dans la table du côté « 1,1 », comme **clé étrangère** (notée `#`).

```
UTILISATEUR (id_utilisateur, nom, prenom, age, email, mot_de_passe)

CATEGORIE (id_categorie, nom, description)

SPORT (id_sport, nom, description, regles, origine, materiel, #id_categorie)

IMAGE (id_image, url, legende, #id_sport)
```

- **Clé primaire** : soulignée (ou placée en premier).
- **Clé étrangère** : précédée de `#`.

---

## 3. MPD (Modèle Physique de Données, MySQL / MariaDB)

```sql
CREATE DATABASE IF NOT EXISTS nouveaux_sports
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE nouveaux_sports;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    age            TINYINT UNSIGNED NOT NULL,
    email          VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe   VARCHAR(255) NOT NULL  -- stocke le hash de password_hash()
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
```

### Points importants

- `mot_de_passe` fait 255 caractères car le hash de `password_hash()` est long. Le mot de passe n'est **jamais** stocké en clair.
- `email` est `UNIQUE` pour éviter deux comptes avec la même adresse.
- `ON DELETE CASCADE` supprime automatiquement les images d'un sport quand ce sport est supprimé.
