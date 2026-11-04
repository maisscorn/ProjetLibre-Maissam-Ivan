<?php
require_once __DIR__ . '/../src/utils/autoloader.php';

// Création des managers (les classes sont chargées par l'autoloader)
$categoriesManager = new CategoriesManager();
$sportsManager = new SportsManager();

// Récupération de toutes les catégories
$categories = $categoriesManager->getCategories();
?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports niches</title>
</head>

<body>
    <h1>Sports niches</h1>
    <p>Un site pour partir à la rencontre de sports méconnus, insolites et très niches.</p>

    <h2>Nos catégories</h2>

    <?php foreach ($categories as $categorie) { ?>
        <h3><?= htmlspecialchars($categorie->getNom()) ?></h3>
        <p><?= htmlspecialchars($categorie->getDescription()) ?></p>

        <ul>
            <?php foreach ($sportsManager->getSportsParCategorie($categorie->getId()) as $sport) { ?>
                <li>
                    <a href="sport.php?id=<?= $sport->getId() ?>"><?= htmlspecialchars($sport->getNom()) ?></a>
                    : <?= htmlspecialchars($sport->getAccroche()) ?>
                </li>
            <?php } ?>
        </ul>
    <?php } ?>

    <p>Projet réalisé dans le cadre du cours ProgServ2 – HEIG-VD.</p>
</body>

</html>
