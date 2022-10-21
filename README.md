# JDR Maker
<p align="center">
    <img src="https://c0.lestechnophiles.com/www.numerama.com/wp-content/uploads/2020/03/role-playing-game-2536016_1920.jpg?resize=1024,768&key=07841d0c">
    Application pour gérer et jouer des jeux de roles
</p>

## Développeurs
- [Bastian Boulogne](https://github.com/nait-sab)
- [Romain Duciel](https://github.com/Rom10811)
- [Florentin Allart](https://github.com/Flo-a)

## Support
- Windows (EXE)
- Android >= 5  (APK)

## Version actuelle : 1.0.0
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
    - __CTRL + F5__ : Démarrage sans le débug

## Autres commandes utile
- Nettoyer le projet : __"flutter clean"__
- Récupérer la liste des packages après nettoyage ou erreurs : __"flutter packages get"__

## Exemple
- Une démo du provider se situe dans la branche demo

## Architecture
- Lancement du programme depuis __lib/main.dart__

- Contenu Application depuis __lib/src/app__ :
    - __app.dart__ : Contient le démarrage de l'application lancé par le fichier main.dart
    - __routes.dart__ : Contient l'ensemble des routes avec leurs UI correspondant
    - Dossier Controllers :
        - __navigation_controller.dart__ : Controller des routes permettant de modifier 
        dans l'application la page actuelle

    - Dossiers Views :
        - __accueil_view.dart__ : Page d'accueil

    - Dossier Widgets :

    - Dossier Tools :


- Contenu Données depuis __lib/src/data__ :

- Contenu Modèles, Énumérations et données fixes depuis __lib/src/domain__ :
    - Dossier __enums__ :    
    - Dossier __models__ :
    - Dossier __data__ :

- __android__ : Librairie interne générant l'APK
- __windows__ : Librairie interne générant le EXE

- __test__ : Tests unitaire

- __assets__ : Contenu des images
    - Dossier font : Polices d'écriture
    - Dossier img : Images
    - Dossier json : Fichiers json
    - Dossier music : Musiques
    - Dossier sound : Sons d'éffets