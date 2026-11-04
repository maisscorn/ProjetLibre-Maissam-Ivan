<?php

class Sport {
    // Propriétés privées pour assurer l'encapsulation
    private ?int $id;
    private string $nom;
    private ?string $accroche;
    private ?string $origine;
    private ?string $joueurs;
    private ?string $terrain;
    private ?string $contact;
    private string $description;
    private string $regles;
    private ?string $materiel;
    private ?string $qualites;
    private int $idCategorie;

    // Constructeur pour initialiser l'objet
    public function __construct(?int $id, string $nom, ?string $accroche, ?string $origine, ?string $joueurs, ?string $terrain, ?string $contact, string $description, string $regles, ?string $materiel, ?string $qualites, int $idCategorie) {
        // Vérification des données
        if (empty($nom)) {
            throw new InvalidArgumentException("Le nom du sport est requis.");
        }

        $this->id = $id;
        $this->nom = $nom;
        $this->accroche = $accroche;
        $this->origine = $origine;
        $this->joueurs = $joueurs;
        $this->terrain = $terrain;
        $this->contact = $contact;
        $this->description = $description;
        $this->regles = $regles;
        $this->materiel = $materiel;
        $this->qualites = $qualites;
        $this->idCategorie = $idCategorie;
    }

    // Getters pour accéder aux propriétés
    public function getId(): ?int {
        return $this->id;
    }

    public function getNom(): string {
        return $this->nom;
    }

    public function getAccroche(): ?string {
        return $this->accroche;
    }

    public function getOrigine(): ?string {
        return $this->origine;
    }

    public function getJoueurs(): ?string {
        return $this->joueurs;
    }

    public function getTerrain(): ?string {
        return $this->terrain;
    }

    public function getContact(): ?string {
        return $this->contact;
    }

    public function getDescription(): string {
        return $this->description;
    }

    public function getRegles(): string {
        return $this->regles;
    }

    public function getMateriel(): ?string {
        return $this->materiel;
    }

    public function getQualites(): ?string {
        return $this->qualites;
    }

    public function getIdCategorie(): int {
        return $this->idCategorie;
    }

    // Méthode qui découpe un texte (un élément par ligne) en liste
    public function enListe(?string $texte): array {
        if (empty($texte)) {
            return [];
        }

        return explode("\n", $texte);
    }
}
