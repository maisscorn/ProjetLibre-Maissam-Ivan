<?php

class SportsManager {
    private $database;

    public function __construct() {
        $this->database = new Database();
    }

    public function getSports(): array {
        // Définition de la requête SQL pour récupérer tous les sports
        $sql = "SELECT * FROM sport ORDER BY nom";

        // Préparation et exécution de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);
        $stmt->execute();

        // Récupération de tous les sports
        $sports = $stmt->fetchAll();

        // Transformation des tableaux associatifs en objets Sport
        $sports = array_map(function ($sportData) {
            return $this->creerSport($sportData);
        }, $sports);

        return $sports;
    }

    public function getSportsParCategorie(int $idCategorie): array {
        // Définition de la requête SQL pour récupérer les sports d'une catégorie
        $sql = "SELECT * FROM sport WHERE id_categorie = :id_categorie ORDER BY nom";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec le paramètre
        $stmt->bindValue(':id_categorie', $idCategorie);

        // Exécution de la requête SQL
        $stmt->execute();

        // Récupération des sports
        $sports = $stmt->fetchAll();

        // Transformation des tableaux associatifs en objets Sport
        $sports = array_map(function ($sportData) {
            return $this->creerSport($sportData);
        }, $sports);

        return $sports;
    }

    public function getSport(int $id): ?Sport {
        // Définition de la requête SQL pour récupérer un sport
        $sql = "SELECT * FROM sport WHERE id_sport = :id";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec le paramètre
        $stmt->bindValue(':id', $id);

        // Exécution de la requête SQL
        $stmt->execute();

        // Récupération du sport
        $sportData = $stmt->fetch();

        // Si le sport n'existe pas, on retourne null
        if (!$sportData) {
            return null;
        }

        return $this->creerSport($sportData);
    }

    public function addSport(Sport $sport): int {
        // Définition de la requête SQL pour ajouter un sport
        $sql = "INSERT INTO sport (nom, accroche, origine, joueurs, terrain, contact, description, regles, materiel, qualites, id_categorie)
                VALUES (:nom, :accroche, :origine, :joueurs, :terrain, :contact, :description, :regles, :materiel, :qualites, :id_categorie)";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec les paramètres
        $stmt->bindValue(':nom', $sport->getNom());
        $stmt->bindValue(':accroche', $sport->getAccroche());
        $stmt->bindValue(':origine', $sport->getOrigine());
        $stmt->bindValue(':joueurs', $sport->getJoueurs());
        $stmt->bindValue(':terrain', $sport->getTerrain());
        $stmt->bindValue(':contact', $sport->getContact());
        $stmt->bindValue(':description', $sport->getDescription());
        $stmt->bindValue(':regles', $sport->getRegles());
        $stmt->bindValue(':materiel', $sport->getMateriel());
        $stmt->bindValue(':qualites', $sport->getQualites());
        $stmt->bindValue(':id_categorie', $sport->getIdCategorie());

        // Exécution de la requête SQL pour ajouter un sport
        $stmt->execute();

        // Retour de l'identifiant du sport ajouté
        return $this->database->getPdo()->lastInsertId();
    }

    public function removeSport(int $id): bool {
        // Définition de la requête SQL pour supprimer un sport
        $sql = "DELETE FROM sport WHERE id_sport = :id";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec le paramètre
        $stmt->bindValue(':id', $id);

        // Exécution de la requête SQL pour supprimer un sport
        return $stmt->execute();
    }

    // Transforme un tableau associatif (une ligne de la base) en objet Sport
    private function creerSport(array $sportData): Sport {
        return new Sport(
            $sportData['id_sport'],
            $sportData['nom'],
            $sportData['accroche'],
            $sportData['origine'],
            $sportData['joueurs'],
            $sportData['terrain'],
            $sportData['contact'],
            $sportData['description'],
            $sportData['regles'],
            $sportData['materiel'],
            $sportData['qualites'],
            $sportData['id_categorie']
        );
    }
}
