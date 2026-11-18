<?php

class UtilisateursManager {
    private $database;

    public function __construct() {
        $this->database = new Database();
    }

    public function addUtilisateur(Utilisateur $utilisateur): int {
        // Définition de la requête SQL pour ajouter un utilisateur
        $sql = "INSERT INTO utilisateur (nom, prenom, date_naissance, email, mot_de_passe, role)
                VALUES (:nom, :prenom, :date_naissance, :email, :mot_de_passe, :role)";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec les paramètres
        $stmt->bindValue(':nom', $utilisateur->getNom());
        $stmt->bindValue(':prenom', $utilisateur->getPrenom());
        $stmt->bindValue(':date_naissance', $utilisateur->getDateNaissance());
        $stmt->bindValue(':email', $utilisateur->getEmail());
        $stmt->bindValue(':mot_de_passe', $utilisateur->getMotDePasse());
        $stmt->bindValue(':role', $utilisateur->getRole());

        // Exécution de la requête SQL pour ajouter l'utilisateur
        $stmt->execute();

        // Récupération de l'identifiant de l'utilisateur ajouté
        return $this->database->getPdo()->lastInsertId();
    }

    public function getUtilisateurParEmail(string $email): ?Utilisateur {
        // Définition de la requête SQL pour récupérer un utilisateur par son e-mail
        $sql = "SELECT * FROM utilisateur WHERE email = :email";

        // Préparation de la requête SQL
        $stmt = $this->database->getPdo()->prepare($sql);

        // Lien avec le paramètre
        $stmt->bindValue(':email', $email);

        // Exécution de la requête SQL
        $stmt->execute();

        // Récupération de l'utilisateur
        $utilisateurData = $stmt->fetch();

        // Si l'utilisateur n'existe pas, on retourne null
        if (!$utilisateurData) {
            return null;
        }

        return new Utilisateur(
            $utilisateurData['id_utilisateur'],
            $utilisateurData['nom'],
            $utilisateurData['prenom'],
            $utilisateurData['date_naissance'],
            $utilisateurData['email'],
            $utilisateurData['mot_de_passe'],
            $utilisateurData['role']
        );
    }

    public function verifierConnexion(string $email, string $motDePasse): ?Utilisateur {
        // On cherche l'utilisateur avec cet e-mail
        $utilisateur = $this->getUtilisateurParEmail($email);

        // On compare le mot de passe saisi avec le hash enregistré
        if ($utilisateur !== null && password_verify($motDePasse, $utilisateur->getMotDePasse())) {
            return $utilisateur;
        }

        return null;
    }
}
