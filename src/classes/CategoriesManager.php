<?php

class CategoriesManager {
    private $database;

    public function __construct() {
        $this->database = new Database();
    }

    public function getCategories(): array {
        // Définition de la requête SQL pour récupérer toutes les catégories
        $sql = "SELECT * FROM categorie ORDER BY id_categorie";

        // Préparation et exécution de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);
        $stmt->execute();

        // Récupération de toutes les catégories
        $categories = $stmt->fetchAll();

        // Transformation des tableaux associatifs en objets Categorie
        $categories = array_map(function ($categorieData) {
            return new Categorie(
                $categorieData['id_categorie'],
                $categorieData['nom'],
                $categorieData['description'],
                $categorieData['image']
            );
        }, $categories);

        return $categories;
    }

    public function getCategorie(int $id): ?Categorie {
        // Définition de la requête SQL pour récupérer une catégorie
        $sql = "SELECT * FROM categorie WHERE id_categorie = :id";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec le paramètre
        $stmt->bindValue(':id', $id);

        // Exécution de la requête SQL
        $stmt->execute();

        // Récupération de la catégorie
        $categorieData = $stmt->fetch();

        // Si la catégorie n'existe pas, on retourne null
        if (!$categorieData) {
            return null;
        }

        return new Categorie(
            $categorieData['id_categorie'],
            $categorieData['nom'],
            $categorieData['description'],
            $categorieData['image']
        );
    }
}
