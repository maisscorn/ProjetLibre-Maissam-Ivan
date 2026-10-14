# Cahier des Charges

Titre : **Découverte de Nouveaux Sports**

> Un site pour partir à la rencontre de sports méconnus, insolites et très
> niches, parce que le sport ne se limite pas au football et au basket !

## Présentation du projet

**Découverte de Nouveaux Sports** est un site web permettant aux visiteurs
d'explorer des disciplines sportives peu connues du grand public, comme le
**tchoukball**. L'objectif est de faire découvrir ces pratiques originales à
travers des fiches détaillées, présentant leurs règles, leur histoire et leurs
spécificités.

Contrairement aux plateformes classiques qui mettent en avant les sports
populaires, notre site se concentre volontairement sur des disciplines **très
niches**, encore trop peu mises en lumière.

## Fonctionnalités principales

- **Page d'accueil** : présente le concept du site et son objectif, donner de la
  visibilité à des sports méconnus. Accessible à tout le monde.
- **Rôles** : les rôles déterminent l'accès à certaines fonctionnalités.
  - **Administrateur** : a accès à toutes les fonctionnalités du site. Il peut
    créer, modifier et supprimer des sports.
  - **Visiteur (non connecté)** : peut consulter le site et les pages sportives,
    sans plus.
  - **Utilisateur inscrit/connecté** : après avoir complété le formulaire
    d'inscription, il accède à des fonctionnalités supplémentaires :
    - ajouter des sports à ses favoris, afin de retrouver plus facilement ses
      sports de niche ;
    - ajouter de nouveaux sports qu'il connaît, qui lui semblent de niche et
      qu'il veut partager avec le monde entier.
- **Système d'inscription et de connexion** : accessible via la barre de
  navigation depuis la page d'accueil, redirigeant vers un formulaire permettant
  aux utilisateurs de créer un compte ou de se connecter.
- **Accès aux pages sportives** :
  - consultables par tout le monde ;
  - créées par les utilisateurs inscrits et les administrateurs ;
  - modifiées par les administrateurs ;
  - supprimées par les administrateurs ;
  - enregistrées en favoris par les utilisateurs connectés.

## Parcours utilisateur

1. L'utilisateur arrive sur la **page d'accueil**, où le concept du site lui est
   expliqué.
2. Il a accès à tout le contenu. S'il le désire, il peut s'inscrire ou se
   connecter à l'aide d'un formulaire qu'il retrouve en scrollant ou dans la
   barre de navigation.
3. Une fois connecté, il peut enregistrer des sports dans ses favoris ou en
   créer de nouveaux.

## Champs du formulaire d'inscription

- nom
- prénom
- date de naissance
- email
- mot de passe
- bouton d'inscription

## Gestion de session et déconnexion

Lorsque l'utilisateur est connecté, il accède à des fonctionnalités réservées
(favoris, création de sports). Il pourra se déconnecter à l'aide d'un bouton,
qui sera sûrement placé dans le menu du site. Lorsqu'il est déconnecté, il peut
toujours consulter le contenu, mais il voit en plus le bouton pour s'inscrire ou
se connecter.

## Contenu d'une page sportive

Chaque page contient : le nom, la description, les règles, l'origine, le
matériel et des images.

## Navigation par catégories

Il y aura plusieurs catégories de sports, comme les sports de balle, les sports
de raquette, les sports doux, etc.

## Technologies utilisées

- **PHP**
- **HTML/CSS**
- **Base de données**

## L'équipe

Ce projet a été réalisé en binôme :

| Membre           | Rôle / Fonction          |
| ---------------- | ------------------------ |
| **Maïssam**      | Administratrice          |
| **Ivan**         | Administrateur           |
| **Utilisateurs** | Connecté ou pas connecté |

## Installation

```bash
# Cloner le dépôt
git clone <url-du-depot>

# Se placer dans le dossier du projet
cd nom-du-projet

# Option 1 : lancer un serveur PHP local
php -S localhost:8000

# Option 2 : démarrer le serveur web avec Docker
docker compose up
```
