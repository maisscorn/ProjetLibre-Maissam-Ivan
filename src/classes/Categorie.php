<?php

class Categorie {
    // Propriétés privées pour assurer l'encapsulation
    private ?int $id;
    private string $nom;
    private ?string $description;
    private ?string $image;

    // Constructeur pour initialiser l'objet
    public function __construct(?int $id, string $nom, ?string $description, ?string $image) {
        $this->id = $id;
        $this->nom = $nom;
        $this->description = $description;
        $this->image = $image;
    }

    // Getters pour accéder aux propriétés
    public function getId(): ?int {
        return $this->id;
    }

    public function getNom(): string {
        return $this->nom;
    }

    public function getDescription(): ?string {
        return $this->description;
    }

    public function getImage(): ?string {
        return $this->image;
    }
}
