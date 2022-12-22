import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/enums/navigation_icons_type.dart';

/// Classe : Accueil - Navigation
///
/// Type : Widget
///
/// Contient la barre de navigation
class AccueilNavigation extends StatefulWidget {
  final bool isAndroid;
  final ProjetController projetController;
  final VoidCallback switchChargement;

  AccueilNavigation({
    required this.isAndroid,
    required this.projetController,
    required this.switchChargement,
  });

  @override
  State<AccueilNavigation> createState() => _AccueilNavigationState();
}

class _AccueilNavigationState extends State<AccueilNavigation> {
  @override
  Widget build(BuildContext context) {
    return widget.isAndroid ? renduAndroid() : renduDesktop();
  }

  void changerRoute(String route) => NavigationController.changerRoute(context, route);

  /// Action du bouton Accueil
  Future boutonAccueil() async {
    if (NavigationController.getRoute(context) != "/accueil") {
      widget.switchChargement();
      await ProjetController.actualiserProjet(context);
      widget.switchChargement();
      changerRoute("/accueil");
    }
  }

  /// Action du bouton Rechercher (Mobile)
  void boutonRechercher() => changerRoute("/rechercher");

  /// Action du bouton Jouer
  void boutonJouer() {}

  /// Action du bouton Options
  void boutonOptions() => changerRoute("/options");

  /// Action du bouton Événements
  void boutonEvenements() => changerRoute("/evenements");

  /// Action du bouton Personnages
  void boutonPersonnages() => changerRoute("/personnages");

  /// Action du bouton Lieux
  void boutonLieux() => changerRoute("/lieux");

  /// Action du bouton Objets
  void boutonObjets() => changerRoute("/objets");

  /// Action du bouton Déconnexion (Windows)
  Future boutonDeconnexion() async {
    if (Platform.isAndroid) {
      await FirebaseAndroidTool.deconnexion();
    } else {
      FirebaseDesktopTool.deconnexion();
    }
    changerRoute("/connexion");
  }

  Widget renduDesktop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Couleurs.fondSecondaire,
        border: Border(right: BorderSide()),
        boxShadow: [
          BoxShadow(blurRadius: 20, offset: Offset(5, 0)),
        ],
      ),
      child: Column(
        children: [
          Bouton(
            onTap: boutonAccueil,
            child: icone(NavigationIconeType.maison),
          ),
          SizedBox(height: 10),
          Bouton(
            onTap: boutonJouer,
            child: icone(NavigationIconeType.jouer),
          ),
          Column(children: boutonsProjet()),
          Spacer(),
          Bouton(
            onTap: boutonOptions,
            child: icone(NavigationIconeType.options),
          ),
          SizedBox(height: 10),
          Bouton(
            onTap: boutonDeconnexion,
            child: icone(NavigationIconeType.deconnexion),
          ),
        ],
      ),
    );
  }

  Widget renduAndroid() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Couleurs.fondSecondaire,
        border: Border(top: BorderSide()),
        boxShadow: [
          BoxShadow(blurRadius: 20, offset: Offset(0, -10)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Bouton(
            onTap: boutonAccueil,
            child: icone(NavigationIconeType.maison),
          ),
          Bouton(
            onTap: boutonRechercher,
            child: icone(NavigationIconeType.recherche),
          ),
          Bouton(
            onTap: boutonJouer,
            child: icone(NavigationIconeType.jouer),
          ),
          Bouton(
            onTap: boutonOptions,
            child: icone(NavigationIconeType.options),
          ),
        ],
      ),
    );
  }

  Widget icone(NavigationIconeType iconeType) {
    Size ecran = MediaQuery.of(context).size;
    String route = NavigationController.getRoute(context);
    IconData icone;
    Color texteCouleur;

    switch (iconeType) {
      case NavigationIconeType.maison:
        icone = Icons.home_rounded;
        texteCouleur = route == "/" || route == "/accueil" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.recherche:
        icone = Icons.search_rounded;
        texteCouleur = route == "/rechercher" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.jouer:
        icone = Icons.play_arrow_rounded;
        texteCouleur = route == "/jouer" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.options:
        icone = Icons.settings_rounded;
        texteCouleur = route == "/options" || route == "/modifier_profil" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.evenements:
        icone = Icons.menu_book_rounded;
        texteCouleur = route == "/evenements" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.personnages:
        icone = Icons.person_rounded;
        texteCouleur = route == "/personnages" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.lieux:
        icone = Icons.location_on_rounded;
        texteCouleur = route == "/lieux" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.objets:
        icone = Icons.diamond_rounded;
        texteCouleur = route == "/objets" ? Couleurs.violet : Couleurs.texte;
        break;
      case NavigationIconeType.deconnexion:
        icone = Icons.power_settings_new_rounded;
        texteCouleur = Couleurs.texte;
        break;
    }

    return Icon(
      icone,
      color: texteCouleur,
      size: widget.isAndroid ? ecran.width * 0.1 : ecran.width * 0.03,
    );
  }

  List<Widget> boutonsProjet() {
    List<Widget> liste = [];

    if (widget.projetController.projet != null) {
      liste.add(SizedBox(height: 20));
      liste.add(Container(height: 1, width: 30, color: Couleurs.texte));
      liste.add(SizedBox(height: 20));
      liste.add(
        Bouton(
          onTap: boutonEvenements,
          child: icone(NavigationIconeType.evenements),
        ),
      );
      liste.add(SizedBox(height: 10));
      liste.add(
        Bouton(
          onTap: boutonPersonnages,
          child: icone(NavigationIconeType.personnages),
        ),
      );
      liste.add(SizedBox(height: 10));
      liste.add(
        Bouton(
          onTap: boutonLieux,
          child: icone(NavigationIconeType.lieux),
        ),
      );
      liste.add(SizedBox(height: 10));
      liste.add(
        Bouton(
          onTap: boutonObjets,
          child: icone(NavigationIconeType.objets),
        ),
      );
    }

    return liste;
  }
}
