<?php
// Lit les identifiants dans config/database.ini (fichier non versionné)
$config = parse_ini_file(__DIR__ . '/../config/database.ini');

$dsn = "mysql:host={$config['host']};port={$config['port']};dbname={$config['database']};charset=utf8mb4";

$pdo = new PDO($dsn, $config['username'], $config['password']);
