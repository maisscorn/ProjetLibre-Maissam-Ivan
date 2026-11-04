USE my_database;

DROP TABLE IF EXISTS suivre;
DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS sport;
DROP TABLE IF EXISTS categorie;
DROP TABLE IF EXISTS utilisateur;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    date_naissance DATE NOT NULL,
    email          VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe   VARCHAR(255) NOT NULL,  -- stocke le hash de password_hash()
    role           ENUM('utilisateur', 'admin') NOT NULL DEFAULT 'utilisateur'
);

CREATE TABLE categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL UNIQUE,
    description  TEXT,
    image        VARCHAR(255)                  -- image de la carte sur l'accueil
);

CREATE TABLE sport (
    id_sport     INT AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL UNIQUE,
    accroche     VARCHAR(255),
    origine      VARCHAR(255),
    joueurs      VARCHAR(255),
    terrain      VARCHAR(255),
    contact      VARCHAR(255),
    description  TEXT NOT NULL,                -- « En quoi ça consiste »
    regles       TEXT NOT NULL,                -- une règle par ligne
    materiel     TEXT,                         -- un élément par ligne
    qualites     TEXT,                         -- une qualité par ligne
    id_categorie INT NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE image (
    id_image INT AUTO_INCREMENT PRIMARY KEY,
    url      VARCHAR(255) NOT NULL,
    legende  VARCHAR(255),
    id_sport INT NOT NULL,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE
);

CREATE TABLE suivre (
    id_utilisateur INT NOT NULL,
    id_sport       INT NOT NULL,
    PRIMARY KEY (id_utilisateur, id_sport),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE
);

-- Données : catégories
INSERT INTO categorie (nom, description, image) VALUES
    ('Les « jeux vidéo dans la vraie vie »', 'Des sports qui transposent à l''échelle réelle l''univers d''un jeu, d''un film ou d''un livre. On y retrouve le côté fun et décalé d''un jeu vidéo, mais avec de vrais efforts physiques.', 'img/bubble-football-1.jpg'),
    ('Les sports à « objet bizarre »', 'Des disciplines construites autour d''un accessoire improbable (cheval en bois, tronc d''arbre, botte en caoutchouc). Le principe est simple, mais la technique et la force comptent plus qu''on ne le pense.', 'img/hobby-horsing-1.jpg'),
    ('Les sports « extrêmes mais pas trop connus »', 'Des activités qui jouent avec l''équilibre, le vide, l''eau ou la ville, entre prise de risque et maîtrise technique.', 'img/rugby-subaquatique-1.jpg'),
    ('Les sports « course » insolites', 'Des courses où l''on remplace le sprint classique par un objet ou un défi absurde, dans une ambiance festive mais compétitive.', 'img/timbersports-1.jpg'),
    ('Les sports combinés', 'Des mélanges de plusieurs sports ou règles existantes, comme du volley sur trampoline ou du foot avec une balle géante. Ils misent sur la coordination, le jeu d''équipe et le spectacle.', 'img/cheese-rolling-1.jpg');

-- Données : sports
INSERT INTO sport (nom, accroche, origine, joueurs, terrain, contact, description, regles, materiel, qualites, id_categorie) VALUES
    ('Quidditch (Quadball)', 'Le sport né de la saga Harry Potter, pratiqué un balai entre les jambes.', 'États-Unis, 2005 (Middlebury College, Vermont)', '7 par équipe sur le terrain', 'Ovale d''environ 55 × 33 m, avec 3 cerceaux à chaque extrémité', 'Oui, plaquages encadrés', 'Le quadball est la version réelle du Quidditch imaginé dans Harry Potter. Les joueurs courent avec un balai (un simple tuyau) coincé entre les jambes, ce qui oblige à jouer d''une seule main et rend chaque action plus compliquée qu''elle n''en a l''air.

C''est un mélange de rugby, de handball et de balle au prisonnier : on se passe une balle, on tire dans des cerceaux et on esquive des projectiles. Il se pratique en équipes mixtes, avec des règles qui favorisent l''égalité entre les genres.', 'Le Souaffle (une balle de volley dégonflée) est marqué dans l''un des trois cerceaux adverses : 10 points.
Trois balles de dodgeball, les cognards, servent à mettre des adversaires hors-jeu. Un joueur touché doit retourner toucher ses propres cerceaux avant de reprendre le jeu.
Le vif d''or est un joueur neutre en tenue jaune, avec une balle accrochée dans le dos. L''attraper rapporte un gros bonus de points et met fin au match.
Le balai doit rester entre les jambes pendant toute l''action.', 'Un balai (tuyau en PVC)
Un Souaffle et trois cognards
Six cerceaux fixes
Un maillot et des protège-dents conseillés', 'Endurance et vitesse
Coordination à une main
Sens tactique
Communication d''équipe', 1),
    ('Bubble football', 'Du foot où l''on joue enfermé dans une grosse bulle gonflable.', 'Norvège, début des années 2010', 'Généralement 5 contre 5', 'Petit terrain de foot ou de futsal', 'Oui, c''est tout le principe', 'Chaque joueur enfile une bulle gonflable transparente qui couvre le haut du corps et la tête, seules les jambes dépassent. Le but reste le même qu''au football : marquer dans le but adverse.

La différence, c''est qu''on peut foncer dans les adversaires sans se faire mal. Les chocs font rebondir les joueurs, les font rouler par terre et transforment chaque match en spectacle. Les parties sont courtes, car courir dans une bulle est très fatigant.', 'Les buts se marquent comme au football, avec les pieds.
Les charges sont autorisées, mais pas par derrière ni sur un joueur déjà à terre.
Les mains restent dans la bulle : on ne touche pas le ballon avec les mains.
Les matchs se jouent en périodes de quelques minutes, avec beaucoup de pauses.', 'Une bulle gonflable par joueur
Un ballon de football
Deux petits buts
Des chaussures de sport', 'Équilibre
Endurance
Courage dans les contacts
Sens de l''humour', 1),
    ('Chessboxing', 'Un round d''échecs, un round de boxe : le cerveau et les poings.', 'Allemagne (Berlin), 2003, d''après la BD « Froid Équateur » d''Enki Bilal', '1 contre 1', 'Un ring de boxe avec une table d''échecs', 'Oui, pendant les rounds de boxe', 'Le chessboxing alterne des rounds d''échecs et des rounds de boxe. L''idée vient d''une bande dessinée d''Enki Bilal, avant d''être transformée en vrai sport par l''artiste néerlandais Iepe Rubingh.

Toute la difficulté est de réfléchir calmement à une partie d''échecs juste après avoir encaissé des coups, le cœur encore à 180. On peut gagner aussi bien par échec et mat que par KO.', 'Le match alterne les rounds, en commençant par les échecs (jusqu''à 11 rounds au total).
On gagne par échec et mat, par KO, par abandon ou si l''adversaire dépasse son temps aux échecs.
Pendant les échecs, les joueurs portent un casque antibruit pour ne pas entendre le public.
Si personne ne gagne, les juges désignent le vainqueur.', 'Un ring de boxe
Des gants et un protège-dents
Un échiquier et une pendule
Un casque antibruit', 'Concentration
Endurance
Gestion du stress
Bon niveau aux échecs et en boxe', 1),
    ('Hobby horsing', 'L''équitation sans cheval, avec un cheval bâton et beaucoup de style.', 'Finlande, années 2000 (premiers championnats nationaux en 2012)', 'Individuel', 'Parcours d''obstacles, en salle ou en extérieur', 'Non', 'Le hobby horsing reprend les épreuves de l''équitation, mais le cheval est remplacé par un cheval bâton : une tête de cheval en tissu fixée au bout d''un manche.

Les pratiquants sautent des obstacles et réalisent des figures de dressage en imitant les allures du cheval (pas, trot, galop). Beaucoup fabriquent eux-mêmes leur cheval, ce qui fait aussi partie du plaisir.', 'Le cheval doit rester entre les jambes pendant tout le parcours.
En saut d''obstacles, chaque barre tombée ou chaque refus donne des pénalités.
En dressage, le jury note la précision, le rythme et l''élégance des mouvements.
Le parcours le plus rapide et le plus propre l''emporte.', 'Un cheval bâton
Des obstacles réglables
Une tenue d''équitation (facultative)', 'Détente et souplesse
Sens du rythme
Endurance
Créativité', 2),
    ('Lancer de botte de paille', 'Envoyer un sac de paille le plus haut possible avec une fourche.', 'Écosse, jeux des Highlands et fêtes agricoles (« sheaf toss »)', 'Individuel', 'Deux poteaux et une barre horizontale réglable', 'Non', 'Avec une fourche, l''athlète doit projeter un sac de jute rempli de paille par-dessus une barre placée en hauteur, un peu comme au saut en hauteur mais avec un objet.

Ce geste vient du travail à la ferme, quand on chargeait les bottes sur les charrettes. Aujourd''hui, c''est l''une des épreuves phares des jeux des Highlands.', 'Chaque athlète a plusieurs essais pour faire passer le sac au-dessus de la barre.
La barre monte après chaque tour réussi.
Après plusieurs échecs à la même hauteur, l''athlète est éliminé.
Celui qui envoie le sac le plus haut gagne.', 'Une fourche
Un sac de jute rempli de paille
Deux poteaux et une barre', 'Puissance des jambes et du dos
Coordination
Technique de lancer', 2),
    ('Lancer de tronc (Caber toss)', 'Faire basculer un tronc d''arbre de plusieurs mètres, bien droit.', 'Écosse, jeux des Highlands', 'Individuel', 'Un terrain en herbe', 'Non', 'L''athlète soulève un long tronc d''arbre ébranché (le « caber »), le tient à la verticale contre lui, court quelques pas puis le lance pour le faire basculer par-dessus lui-même.

Contrairement à ce qu''on pourrait croire, on ne cherche pas à lancer le plus loin possible : le but est que le tronc retombe le plus droit possible, comme l''aiguille d''une montre sur midi.', 'Le tronc doit retomber sur l''extrémité opposée à celle qu''on tenait.
Le jury note la direction de la chute : un lancer parfait pointe vers « midi ».
Chaque athlète a plusieurs essais.
Un tronc qui ne bascule pas complètement est noté selon l''angle atteint.', 'Un tronc d''environ 5 à 6 m, de plusieurs dizaines de kilos
Le kilt traditionnel', 'Force
Équilibre
Gainage
Précision du geste', 2),
    ('Lancer de bottes en caoutchouc', 'Le lancer de javelot version bottes de pluie.', 'Finlande et Royaume-Uni (« welly wanging »)', 'Individuel', 'Un couloir de lancer en herbe', 'Non', 'Le principe est simple : lancer une botte en caoutchouc le plus loin possible. Né dans les fêtes de village, ce sport a aujourd''hui ses compétitions officielles et même ses championnats du monde.

Chaque lanceur a sa technique : lancer par-dessus l''épaule, en tournant comme au marteau, ou d''une seule main vers l''avant. La forme de la botte rend sa trajectoire difficile à maîtriser.', 'On lance depuis derrière une ligne, sans la dépasser.
La botte doit retomber à l''intérieur du couloir de lancer.
La distance est mesurée jusqu''au point où la botte touche le sol.
Chaque lanceur a plusieurs essais, seul le meilleur compte.', 'Une botte en caoutchouc réglementaire
Un mètre ruban pour mesurer', 'Coordination
Puissance du bras
Technique
Régularité', 2),
    ('Pelote basque à main nue', 'Frapper une balle dure contre un mur, sans raquette ni gant.', 'Pays basque (France et Espagne)', '1 contre 1 ou 2 contre 2', 'Un fronton (mur) en plein air ou couvert', 'Non', 'La pelote est une petite balle très dure, recouverte de cuir. À main nue, les joueurs la frappent contre un mur avec la paume de la main, sans aucun instrument.

C''est la forme la plus traditionnelle de la pelote basque. Elle demande des mains endurcies : les joueurs protègent leurs doigts avec des bandes, mais les impacts restent douloureux.', 'La balle doit frapper le mur au-dessus de la ligne prévue.
Après le mur, elle ne doit pas rebondir plus d''une fois au sol avant d''être renvoyée.
Une faute donne le point à l''adversaire.
La partie se joue en un nombre de points fixé à l''avance.', 'Une pelote en cuir
Des bandes de protection pour les mains
Un fronton', 'Réflexes
Puissance de frappe
Endurance
Résistance à la douleur', 2),
    ('Slackline / Highline', 'Marcher sur une sangle tendue, parfois au-dessus du vide.', 'États-Unis, fin des années 1970 (grimpeurs de Yosemite)', 'Individuel', 'Une sangle tendue entre deux points (arbres, falaises)', 'Non', 'La slackline consiste à marcher en équilibre sur une sangle plate et souple, tendue entre deux points. Contrairement au funambule, la sangle bouge et rebondit sous les pieds.

La highline est sa version extrême : la sangle est installée en hauteur, entre deux falaises ou deux bâtiments. Le pratiquant est alors attaché à la sangle par une longe pour sa sécurité.', 'En pratique libre, il n''y a pas de règle officielle : on avance, on tient, on recommence.
En highline, on est toujours relié à la sangle par un baudrier et une longe.
En compétition (trickline), les figures sont notées par un jury.
On protège toujours les arbres qui servent d''ancrage.', 'Une sangle
Un système de tension
Des protections d''arbres
Un baudrier et une longe (highline)', 'Équilibre
Concentration
Gainage
Maîtrise de la peur', 3),
    ('Parkour', 'La ville devient un terrain de jeu : courir, sauter, grimper.', 'France (Lisses et Évry), fin des années 1980, avec David Belle et les Yamakasi', 'Individuel ou en groupe', 'La ville : murs, rampes, toits, escaliers', 'Non', 'Le parkour consiste à se déplacer d''un point à un autre le plus efficacement possible, en franchissant les obstacles qui se trouvent sur le chemin : sauts, escalades, roulades, passages de murs.

Né en banlieue parisienne, il s''est fait connaître dans le monde entier grâce aux films et aux vidéos. C''est autant un sport qu''une manière de regarder différemment son environnement.', 'Pas d''arbitre en pratique libre : chacun avance à son rythme.
La sécurité passe avant tout : on progresse étape par étape.
On respecte les lieux et les personnes autour.
Il existe des compétitions de vitesse et de style, notées par des juges.', 'Des chaussures légères avec une bonne adhérence
Une tenue souple', 'Force
Agilité
Coordination
Confiance en soi', 3),
    ('Pétanque en bateau', 'La pétanque, mais sur un terrain qui flotte et qui bouge.', 'Paris, croisières sur la Seine (concept lancé en 2018)', 'En équipes de 1 à 3, comme la pétanque', 'Le toit d''un bateau en navigation', 'Non', 'On reprend les règles classiques de la pétanque, mais le terrain est installé sur le toit d''un bateau qui navigue. Les mouvements de l''eau et les virages rendent chaque lancer imprévisible.

C''est surtout une activité festive, mais elle demande une vraie adresse : il faut adapter son geste au roulis du bateau.', 'On lance d''abord le cochonnet, puis chaque équipe essaie de placer ses boules au plus près.
À la fin de chaque mène, l''équipe la plus proche marque un point par boule mieux placée que la meilleure boule adverse.
On lance toujours depuis le cercle, les pieds au sol.
La première équipe à 13 points gagne.', 'Des boules et un cochonnet
Un cercle de lancer
Un bateau', 'Précision
Concentration
Équilibre
Esprit d''équipe', 3),
    ('Extreme ironing', 'Repasser son linge au sommet d''une montagne… ou sous l''eau.', 'Royaume-Uni (Leicester), 1997, par Phil Shaw', 'Individuel ou en équipe', 'N''importe où, plus c''est insolite, mieux c''est', 'Non', 'Le repassage extrême mélange un sport extrême (escalade, plongée, ski…) et une tâche ménagère : repasser du linge dans un endroit improbable.

Le concept est né comme une blague, mais il a vite fait le tour du monde. Les pratiquants rivalisent d''imagination pour trouver les lieux les plus fous où sortir leur planche à repasser.', 'On emporte une vraie planche à repasser, un fer et du linge.
Le linge doit être réellement repassé sur place.
Une photo sert de preuve de l''exploit.
La sécurité du sport pratiqué reste prioritaire.', 'Une planche à repasser
Un fer à repasser
Du linge
L''équipement du sport pratiqué', 'Endurance
Créativité
Sang-froid
Sens de l''humour', 3),
    ('Rugby subaquatique', 'Un match de rugby en trois dimensions, au fond de la piscine.', 'Allemagne (Cologne), 1961', '6 par équipe dans l''eau, avec des remplaçants', 'Un bassin profond de 3,5 à 5 m, avec un panier au fond de chaque côté', 'Oui', 'Le rugby subaquatique se joue entièrement sous l''eau, en apnée. Le ballon est rempli d''eau salée : il coule au lieu de flotter, ce qui permet de jouer au fond du bassin.

Comme on peut attaquer par le haut, par le bas ou par les côtés, c''est un des rares sports qui se jouent vraiment en trois dimensions. Il ne faut pas le confondre avec le hockey subaquatique, qui se joue avec une crosse et un palet.', 'On marque en déposant le ballon dans le panier adverse, au fond du bassin.
Le ballon ne doit jamais sortir de l''eau.
On ne peut attaquer que le joueur qui porte le ballon.
Les joueurs remontent régulièrement respirer et sont remplacés pendant le match.', 'Palmes, masque et tuba
Un bonnet avec protège-oreilles
Un ballon rempli d''eau salée
Deux paniers', 'Apnée
Endurance
Vision du jeu
Communication sans parler', 3),
    ('Course de lits', 'Pousser un lit sur roulettes, avec un passager allongé dessus.', 'Royaume-Uni (Knaresborough, depuis 1966) et fêtes de village', 'Une équipe de pousseurs et un passager', 'Les rues de la ville, parfois avec un passage dans l''eau', 'Non', 'Chaque équipe construit ou décore un lit monté sur roulettes. Un membre de l''équipe s''allonge dessus pendant que les autres le poussent le plus vite possible à travers la ville.

La course mêle vraie compétition et grande fête : les équipes sont souvent déguisées et le public vient autant pour rire que pour voir qui gagne.', 'Le passager doit rester sur le lit pendant toute la course.
Le lit doit franchir la ligne d''arrivée en entier, avec son passager.
Le lit ne doit avoir aucun moteur : seule la force des pousseurs compte.
Un prix récompense souvent le meilleur déguisement.', 'Un lit sur roulettes
Des casques
Des déguisements', 'Vitesse
Coordination d''équipe
Endurance
Créativité', 4),
    ('Course de fromages (Cheese rolling)', 'Dévaler une colline très raide pour rattraper une meule de fromage.', 'Angleterre, Cooper''s Hill (Gloucestershire), tradition ancienne', 'Plusieurs dizaines de coureurs par course', 'Une colline extrêmement raide', 'Non, mais les chutes sont nombreuses', 'Une meule de fromage (un Double Gloucester de quelques kilos) est lâchée du haut de la colline. Une seconde plus tard, les coureurs s''élancent derrière elle.

La pente est si raide que presque personne ne reste debout : on court, on tombe, on roule. Le fromage va trop vite pour être rattrapé, alors c''est le premier coureur en bas qui gagne.', 'Le départ est donné juste après le lâcher du fromage.
Le premier à franchir la ligne en bas de la colline gagne.
Le vainqueur repart avec la meule de fromage.
Il n''est pas obligatoire de rester debout.', 'Une meule de Double Gloucester
Une colline
Des secouristes', 'Courage
Vitesse
Souplesse
Résistance aux chocs', 4),
    ('Course de cuvettes de WC', 'Des caisses à savon construites autour d''une vraie cuvette de toilettes.', 'États-Unis, fêtes de quartier (par ex. Hampdenfest à Baltimore)', 'Un pilote par véhicule', 'Une rue en pente', 'Non', 'Les participants construisent un petit véhicule sans moteur dont le siège est… une cuvette de WC. Ils descendent ensuite une rue en pente, uniquement grâce à la gravité.

Comme pour les courses de caisses à savon, il faut un véhicule bien construit et un pilote qui sait prendre les virages. La décoration compte aussi pour le public.', 'Aucun moteur n''est autorisé : seule la pente fait avancer le véhicule.
Le véhicule doit intégrer une vraie cuvette de toilettes.
Les courses se font par manches, le plus rapide gagne.
Le casque est obligatoire.', 'Une cuvette de WC
Un châssis à roulettes avec des freins
Un casque', 'Créativité
Bricolage
Pilotage
Sens de l''humour', 4),
    ('Course de bûcherons (Timbersports)', 'Haches et scies contre la montre : le sport des bûcherons.', 'Compétitions de bûcherons d''Australie, de Nouvelle-Zélande et d''Amérique du Nord ; série STIHL TIMBERSPORTS depuis 1985', 'Individuel ou relais par équipe', 'Une scène avec des billes de bois', 'Non', 'Les athlètes doivent couper des billes de bois le plus vite possible, à la hache ou à la scie. Chaque épreuve dure souvent moins d''une minute.

Ce sport vient du travail des bûcherons, qui comparaient leur rapidité. Aujourd''hui, il a ses championnats du monde, retransmis à la télévision.', 'La série comporte six disciplines, à la hache, à la scie et à la tronçonneuse.
Chaque épreuve est chronométrée : le plus rapide gagne.
La coupe doit rester entre les marques tracées sur le bois, sinon il y a pénalité.
Les protections sont obligatoires.', 'Des haches de compétition
Des scies et des tronçonneuses
Des billes de bois
Des protections', 'Force
Précision
Explosivité
Maîtrise des outils', 4),
    ('Course de dragon boat', 'Vingt pagayeurs, un tambour et un bateau en forme de dragon.', 'Chine, il y a plus de 2000 ans (fête des bateaux-dragons)', '20 pagayeurs, un batteur et un barreur', 'Un plan d''eau, courses souvent de 200 ou 500 m', 'Non', 'Le dragon boat se court sur de longs bateaux décorés d''une tête et d''une queue de dragon. Les pagayeurs sont assis deux par deux et doivent pagayer exactement en même temps.

À l''avant, un batteur donne le rythme avec un tambour ; à l''arrière, un barreur dirige le bateau. C''est un sport d''équipe par excellence : un seul pagayeur en décalage ralentit tout le bateau.', 'Le départ est donné bateaux arrêtés, sur une ligne.
Chaque bateau reste dans son couloir.
L''arrivée est prise quand l''avant du bateau franchit la ligne.
Tous les membres de l''équipe doivent finir la course à bord.', 'Un bateau-dragon
Des pagaies
Un tambour
Des gilets de sauvetage', 'Synchronisation
Puissance
Endurance
Esprit d''équipe', 4),
    ('Ultimate frisbee', 'Un sport collectif avec un disque, et sans arbitre.', 'États-Unis, 1968 (lycée de Maplewood, New Jersey)', '7 contre 7', 'Environ 100 × 37 m, avec une zone d''en-but de chaque côté', 'Non', 'L''ultimate mélange des éléments du football américain, du basket et du netball, mais avec un disque. Pour marquer, il faut attraper le disque dans la zone d''en-but adverse.

Sa particularité : il n''y a pas d''arbitre, même en compétition. Les joueurs règlent eux-mêmes les fautes grâce à « l''esprit du jeu », une règle de respect et de fair-play.', 'On ne peut pas courir avec le disque : il faut s''arrêter et faire une passe.
Le porteur a 10 secondes pour lancer.
Si le disque tombe ou est intercepté, l''autre équipe récupère la possession.
Les joueurs s''arbitrent eux-mêmes.', 'Un disque de 175 g
Des plots pour délimiter le terrain', 'Vitesse
Précision
Lecture du jeu
Fair-play', 5),
    ('Bossaball', 'Du volley sur trampoline, avec les pieds, en musique.', 'Espagne, 2005, inventé par le Belge Filip Eyckmans', '4 ou 5 par équipe', 'Une structure gonflable avec un trampoline de chaque côté du filet', 'Non', 'Le bossaball mélange le volley, le football, la gymnastique et la capoeira. Le terrain est entièrement gonflable, et un trampoline au centre de chaque camp permet des sauts spectaculaires.

On peut jouer la balle avec les mains comme au volley, mais aussi avec les pieds et la tête. Les matchs se jouent souvent en musique, ce qui donne une ambiance de fête.', 'La balle doit passer au-dessus du filet et tomber dans le camp adverse.
On peut toucher la balle avec tout le corps.
Une balle qui touche le trampoline adverse rapporte plus de points.
Le nombre de touches par équipe est limité.', 'Un terrain gonflable avec trampolines
Un ballon
Un filet', 'Détente
Acrobatie
Coordination
Jeu d''équipe', 5),
    ('Sepak takraw', 'Le volley qui se joue avec les pieds et des ciseaux retournés.', 'Asie du Sud-Est (Malaisie, Thaïlande)', '3 contre 3', 'La taille d''un terrain de badminton, avec un filet d''environ 1,5 m', 'Non', 'Le sepak takraw ressemble au volley-ball, mais on n''a pas le droit d''utiliser les mains. Les joueurs frappent une petite balle tressée avec les pieds, les genoux, la poitrine et la tête.

Pour smasher, les joueurs sautent et frappent la balle par-dessus leur tête avec le pied, en faisant un retourné acrobatique. C''est l''un des sports les plus spectaculaires d''Asie.', 'Interdiction de toucher la balle avec les mains et les bras.
Chaque équipe a au maximum 3 touches pour renvoyer la balle.
Le service se fait au pied, depuis un cercle.
Les sets se jouent en 21 points.', 'Une balle en rotin ou en plastique tressé
Un filet', 'Souplesse
Acrobatie
Détente
Précision du pied', 5),
    ('Kin-Ball', 'Trois équipes et un ballon géant de 1,22 m de diamètre.', 'Québec (Canada), 1986, par Mario Demers', '3 équipes de 4', 'Un gymnase', 'Non', 'Le Kin-Ball se joue avec un ballon géant mais très léger, et surtout à trois équipes en même temps, ce qui le rend unique.

L''équipe qui a le ballon le frappe et désigne une autre équipe, qui doit le rattraper avant qu''il touche le sol. Tout le monde participe : c''est un sport pensé pour la coopération.', 'Avant de frapper, l''équipe annonce « Omnikin » suivi de la couleur d''une équipe adverse.
L''équipe désignée doit rattraper le ballon avant qu''il touche le sol.
Si elle échoue, les deux autres équipes marquent un point.
Tous les joueurs de l''équipe qui frappe doivent toucher le ballon.', 'Un ballon de 1,22 m
Des chasubles de trois couleurs', 'Coopération
Réactivité
Coordination
Communication', 5),
    ('Jorkyball', 'Du foot à deux contre deux, dans une cage vitrée.', 'France, fin des années 1980', '2 contre 2', 'Une cage d''environ 10 × 5 m, entourée de vitres et de filets', 'Limité', 'Le jorkyball est un football en format réduit, joué à deux contre deux dans une petite cage fermée. Le ballon rebondit sur les murs et ne sort jamais du terrain.

Le jeu est très rapide : il faut des réflexes, une bonne technique de balle et une parfaite entente avec son coéquipier.', 'Chaque équipe compte deux joueurs, sans gardien attitré.
Les rebonds sur les parois sont autorisés et font partie du jeu.
On marque en envoyant le ballon dans le petit but adverse.
Les matchs se jouent en plusieurs manches courtes.', 'Un ballon de football
Une cage de jorkyball
Des chaussures de salle', 'Technique
Réflexes
Entente à deux
Endurance', 5);

-- Données : images (2 par sport, fichiers dans public/img/)
INSERT INTO image (url, legende, id_sport) VALUES
    ('img/quidditch-1.jpg', 'Quidditch (Quadball)', 1),
    ('img/quidditch-2.jpg', 'Quidditch (Quadball) en action', 1),
    ('img/bubble-football-1.jpg', 'Bubble football', 2),
    ('img/bubble-football-2.jpg', 'Bubble football en action', 2),
    ('img/chessboxing-1.jpg', 'Chessboxing', 3),
    ('img/chessboxing-2.jpg', 'Chessboxing en action', 3),
    ('img/hobby-horsing-1.jpg', 'Hobby horsing', 4),
    ('img/hobby-horsing-2.jpg', 'Hobby horsing en action', 4),
    ('img/lancer-botte-de-paille-1.jpg', 'Lancer de botte de paille', 5),
    ('img/lancer-botte-de-paille-2.jpg', 'Lancer de botte de paille en action', 5),
    ('img/caber-toss-1.jpg', 'Lancer de tronc (Caber toss)', 6),
    ('img/caber-toss-2.jpg', 'Lancer de tronc (Caber toss) en action', 6),
    ('img/lancer-de-bottes-1.jpg', 'Lancer de bottes en caoutchouc', 7),
    ('img/lancer-de-bottes-2.jpg', 'Lancer de bottes en caoutchouc en action', 7),
    ('img/pelote-basque-main-nue-1.jpg', 'Pelote basque à main nue', 8),
    ('img/pelote-basque-main-nue-2.jpg', 'Pelote basque à main nue en action', 8),
    ('img/slackline-1.jpg', 'Slackline / Highline', 9),
    ('img/slackline-2.jpg', 'Slackline / Highline en action', 9),
    ('img/parkour-1.jpg', 'Parkour', 10),
    ('img/parkour-2.jpg', 'Parkour en action', 10),
    ('img/petanque-en-bateau-1.jpg', 'Pétanque en bateau', 11),
    ('img/petanque-en-bateau-2.jpg', 'Pétanque en bateau en action', 11),
    ('img/extreme-ironing-1.jpg', 'Extreme ironing', 12),
    ('img/extreme-ironing-2.jpg', 'Extreme ironing en action', 12),
    ('img/rugby-subaquatique-1.jpg', 'Rugby subaquatique', 13),
    ('img/rugby-subaquatique-2.jpg', 'Rugby subaquatique en action', 13),
    ('img/course-de-lits-1.jpg', 'Course de lits', 14),
    ('img/course-de-lits-2.jpg', 'Course de lits en action', 14),
    ('img/cheese-rolling-1.jpg', 'Course de fromages (Cheese rolling)', 15),
    ('img/cheese-rolling-2.jpg', 'Course de fromages (Cheese rolling) en action', 15),
    ('img/course-de-cuvettes-1.jpg', 'Course de cuvettes de WC', 16),
    ('img/course-de-cuvettes-2.jpg', 'Course de cuvettes de WC en action', 16),
    ('img/timbersports-1.jpg', 'Course de bûcherons (Timbersports)', 17),
    ('img/timbersports-2.jpg', 'Course de bûcherons (Timbersports) en action', 17),
    ('img/dragon-boat-1.jpg', 'Course de dragon boat', 18),
    ('img/dragon-boat-2.jpg', 'Course de dragon boat en action', 18),
    ('img/ultimate-frisbee-1.jpg', 'Ultimate frisbee', 19),
    ('img/ultimate-frisbee-2.jpg', 'Ultimate frisbee en action', 19),
    ('img/bossaball-1.jpg', 'Bossaball', 20),
    ('img/bossaball-2.jpg', 'Bossaball en action', 20),
    ('img/sepak-takraw-1.jpg', 'Sepak takraw', 21),
    ('img/sepak-takraw-2.jpg', 'Sepak takraw en action', 21),
    ('img/kin-ball-1.jpg', 'Kin-Ball', 22),
    ('img/kin-ball-2.jpg', 'Kin-Ball en action', 22),
    ('img/jorkyball-1.jpg', 'Jorkyball', 23),
    ('img/jorkyball-2.jpg', 'Jorkyball en action', 23);
