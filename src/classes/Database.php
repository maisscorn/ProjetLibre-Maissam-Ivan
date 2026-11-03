<?php

class Database {
    const DATABASE_CONFIGURATION_FILE = __DIR__ . '/../../config/database.ini';

    private $pdo;

    public function __construct() {
        // Lecture du fichier de configuration (non versionné)
        $config = parse_ini_file(self::DATABASE_CONFIGURATION_FILE);

        $host = $config['host'];
        $port = $config['port'];
        $database = $config['database'];
        $username = $config['username'];
        $password = $config['password'];

        // Connexion à la base de données
        $this->pdo = new PDO("mysql:host=$host;port=$port;dbname=$database;charset=utf8mb4", $username, $password);
    }

    public function getPdo(): PDO {
        return $this->pdo;
    }
}
