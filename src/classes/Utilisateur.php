<?php

class Utilisateur {
    // Rôles possibles (identiques à l'ENUM de la base de données)
    const ROLE_UTILISATEUR = 'utilisateur';
    const ROLE_ADMIN = 'admin';

    // Propriétés privées pour assurer l'encapsulation
    private ?int $id;
    private string $nom;
    private string $prenom;
    private string $dateNaissance;
    private string $email;
    private string $motDePasse;
    private string $role;

    // Constructeur pour initialiser l'objet (avec validation des données)
    public function __construct(?int $id, string $nom, string $prenom, string $dateNaissance, string $email, string $motDePasse, string $role = self::ROLE_UTILISATEUR) {
        if (empty(trim($nom)) || empty(trim($prenom))) {
            throw new InvalidArgumentException("Le nom et le prénom sont obligatoires.");
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidArgumentException("L'adresse e-mail n'est pas valide.");
        }

        if ($role !== self::ROLE_UTILISATEUR && $role !== self::ROLE_ADMIN) {
            throw new InvalidArgumentException("Le rôle doit être 'utilisateur' ou 'admin'.");
        }

        $this->id = $id;
        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->dateNaissance = $dateNaissance;
        $this->email = $email;
        $this->motDePasse = $motDePasse;
        $this->role = $role;
    }

    // Getters pour accéder aux propriétés
    public function getId(): ?int {
        return $this->id;
    }

    public function getNom(): string {
        return $this->nom;
    }

    public function getPrenom(): string {
        return $this->prenom;
    }

    public function getDateNaissance(): string {
        return $this->dateNaissance;
    }

    public function getEmail(): string {
        return $this->email;
    }

    // Contient le hash du mot de passe (jamais le mot de passe en clair)
    public function getMotDePasse(): string {
        return $this->motDePasse;
    }

    public function getRole(): string {
        return $this->role;
    }

    // Indique si l'utilisateur est administrateur
    public function isAdmin(): bool {
        return $this->role === self::ROLE_ADMIN;
    }
}
