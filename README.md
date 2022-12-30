# JDR Maker
<p align="center">
    <img src="https://c0.lestechnophiles.com/www.numerama.com/wp-content/uploads/2020/03/role-playing-game-2536016_1920.jpg?resize=1024,768&key=07841d0c">
    Application pour gérer et jouer des jeux de roles
</p>

## Développeurs
- [Bastian Boulogne](https://github.com/nait-sab)
- [Romain Duciel](https://github.com/Rom10811)
- [Florentin Allart](https://github.com/Flo-a)

## Supports
- Windows (EXE)
- Android >= 5  (APK)

## Version actuelle : 1.0.9
Historique des modifications : __changelog.md__

## Langages
- Dart
- C++ (only for compiler)

## Démarrage
- Créer un éxécutable __EXE__ :
    - Commande __"flutter build windows"__
    - Emplacement DEBUG : __build/windows/runner/Debug__
    - Emplacement Release : __build/windows/runner/Release__

- Lancer depuis __Visual Studio Code__ :
    - __F5__ : Démarrage avec le debug
    - __CTRL + F5__ : Démarrage sans le debug

## Autres commandes utiles
- Nettoyer le projet : __"flutter clean"__
- Récupérer la liste des packages après nettoyage ou erreur : __"flutter packages get"__

## Exemple
- Une démo du provider se situe dans la branche demo

## Architecture
- Lancement du programme depuis __lib/main.dart__

- Contenu Application depuis __lib/src/app__ :
    - Dossier Controllers : Contient les controllers de variables dynamiques
    - Dossier Tools : Contients les outils / API utilisé
    - Dossier Views : Contient les vues de l'application rangées avec leurs widgets
    - Dossier Widgets : Contient les widgets communs entre plusieurs vues
    - __app.dart__ : Contient le démarrage de l'application lancée par le fichier main.dart
    - __routes.dart__ : Contient l'ensemble des routes avec leurs UI correspondantes

- Contenu Modèles, Énumérations et données fixes depuis __lib/src/domain__ :
    - Dossier __data__ : Contient les données fixes
    - Dossier __enums__ : Contient les types de données
    - Dossier __models__ : Contient les modèles de données

- __android__ : Librairie interne générant l'APK
- __windows__ : Librairie interne générant le EXE

- __test__ : Tests unitaires

- __assets__ : Contenu des images
    - Dossier font : Polices d'écriture
    - Dossier img : Images
    - Dossier json : Fichiers json
    - Dossier music : Musiques
    - Dossier sound : Sons d'effets