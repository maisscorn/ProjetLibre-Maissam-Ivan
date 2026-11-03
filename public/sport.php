<?php
require_once __DIR__ . '/../src/utils/autoloader.php';

$sportsManager = new SportsManager();
$categoriesManager = new CategoriesManager();

// Récupération de l'identifiant du sport dans l'URL (sport.php?id=3)
if (isset($_GET['id'])) {
    $id = (int) $_GET['id'];
} else {
    $id = 0;
}

$sport = $sportsManager->getSport($id);

// Si le sport n'existe pas, on affiche un message et on arrête
if ($sport === null) {
    echo "Sport introuvable.";
    exit();
}

$categorie = $categoriesManager->getCategorie($sport->getIdCategorie());
?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($sport->getNom()) ?> | Sports niches</title>
</head>

<body>
    <p><a href="index.php">Accueil</a></p>

    <h1><?= htmlspecialchars($sport->getNom()) ?></h1>
    <p><em><?= htmlspecialchars($sport->getAccroche()) ?></em></p>
    <p>Catégorie : <?= htmlspecialchars($categorie->getNom()) ?></p>

    <ul>
        <li>Origine : <?= htmlspecialchars($sport->getOrigine()) ?></li>
        <li>Joueurs : <?= htmlspecialchars($sport->getJoueurs()) ?></li>
        <li>Terrain : <?= htmlspecialchars($sport->getTerrain()) ?></li>
        <li>Contact : <?= htmlspecialchars($sport->getContact()) ?></li>
    </ul>

    <h2>En quoi ça consiste</h2>
    <p><?= htmlspecialchars($sport->getDescription()) ?></p>

    <h2>Les règles de base</h2>
    <ul>
        <?php foreach ($sport->enListe($sport->getRegles()) as $regle) { ?>
            <li><?= htmlspecialchars($regle) ?></li>
        <?php } ?>
    </ul>

    <h2>Matériel</h2>
    <ul>
        <?php foreach ($sport->enListe($sport->getMateriel()) as $element) { ?>
            <li><?= htmlspecialchars($element) ?></li>
        <?php } ?>
    </ul>

    <h2>Les qualités nécessaires</h2>
    <ul>
        <?php foreach ($sport->enListe($sport->getQualites()) as $qualite) { ?>
            <li><?= htmlspecialchars($qualite) ?></li>
        <?php } ?>
    </ul>
</body>

</html>
