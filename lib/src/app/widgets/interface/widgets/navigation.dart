import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/enums/navigation_icons_type.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Navigation
///
/// Type : Widget
///
/// Contient la barre de navigation
class AccueilNavigation extends StatefulWidget {
  final bool isAndroid;
  final VoidCallback rafraichir;

  AccueilNavigation({
    required this.isAndroid,
    required this.rafraichir,
  });

  @override
  State<AccueilNavigation> createState() => _AccueilNavigationState();
}

class _AccueilNavigationState extends State<AccueilNavigation> {
  @override
  Widget build(BuildContext context) {
    return widget.isAndroid ? renduAndroid() : renduDesktop();
  }

  /// Action du bouton Accueil
  void boutonAccueil() {
    String route = Provider.of<NavigationController>(context, listen: false).currentRoute;
    if (route == "/" || route == "/accueil") {
      widget.rafraichir();
    } else {
      NavigationController.changerView(context, "/accueil");
    }
  }

  /// Action du bouton Rechercher (Mobile)
  void boutonRechercher() {
    NavigationController.changerView(context, "/rechercher");
  }

  /// Action du bouton Jouer
  void boutonJouer() {}

  /// Action du bouton Options
  void boutonOptions() {
    NavigationController.changerView(context, "/options");
  }

  /// Action du bouton Déconnexion (Windows)
  void boutonDeconnexion() {}

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
          Spacer(),
          Bouton(
            onTap: boutonOptions,
            child: icone(NavigationIconeType.options),
          ),
          // TODO - Faire disparaître l'espacement et bouton deconnexion si l'utilisateur n'est pas connecté
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
    String route = Provider.of<NavigationController>(context, listen: false).currentRoute;
    IconData icone;
    Color texteCouleur;

    switch (iconeType) {
      case NavigationIconeType.maison:
        icone = Icons.home_rounded;
        texteCouleur = route == "/" || route == "/accueil" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.recherche:
        icone = Icons.search_rounded;
        texteCouleur = route == "/rechercher" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.jouer:
        icone = Icons.play_arrow_rounded;
        texteCouleur = route == "/jouer" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.options:
        icone = Icons.settings_rounded;
        texteCouleur = route == "/options" ? Colors.white : Couleurs.texte;
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
}
