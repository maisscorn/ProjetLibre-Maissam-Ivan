<?php
require_once __DIR__ . '/../src/database.php';

$sql = "SELECT * FROM sport";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$results = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProgServ2 Course PHP Template</title>
</head>

<body>
    <h1>Sports niches</h1>

    <p>Bienvenue sur le sites des sports très peu connus</p>

    <h2>Liste des sports :</h2>

    <ul>
        <?php foreach ($results as $row) { ?>
            <li>
                <strong><?= htmlspecialchars($row['nom']) ?></strong>
                <ul>
                    <li>Description : <?= htmlspecialchars($row['description']) ?></li>
                    <li>Règles : <?= htmlspecialchars($row['regles']) ?></li>
                    <li>Origine : <?= htmlspecialchars($row['origine']) ?></li>
                    <li>Matériel : <?= htmlspecialchars($row['materiel']) ?></li>
                </ul>
            </li>
        <?php } ?>
    </ul>
</body>

</html>
