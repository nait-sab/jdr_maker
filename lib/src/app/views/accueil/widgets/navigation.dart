import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
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

  AccueilNavigation({
    required this.isAndroid,
  });

  @override
  State<AccueilNavigation> createState() => _AccueilNavigationState();
}

class _AccueilNavigationState extends State<AccueilNavigation> {
  @override
  Widget build(BuildContext context) {
    return widget.isAndroid ? renduAndroid() : renduDesktop();
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
          icone(NavigationIconeType.maison),
          SizedBox(height: 10),
          icone(NavigationIconeType.recherche),
          SizedBox(height: 10),
          icone(NavigationIconeType.jouer),
          Spacer(),
          icone(NavigationIconeType.options),
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
          icone(NavigationIconeType.maison),
          icone(NavigationIconeType.recherche),
          icone(NavigationIconeType.jouer),
          icone(NavigationIconeType.options),
        ],
      ),
    );
  }

  Widget icone(NavigationIconeType iconeType) {
    Size ecran = MediaQuery.of(context).size;
    String route = Provider.of<NavigationController>(context).currentRoute;
    IconData icone;
    Color texteCouleur;

    switch (iconeType) {
      case NavigationIconeType.maison:
        icone = Icons.home_rounded;
        texteCouleur = route == "/" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.recherche:
        icone = Icons.search_rounded;
        texteCouleur = route == "/" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.jouer:
        icone = Icons.play_arrow_rounded;
        texteCouleur = route == "/" ? Colors.white : Couleurs.texte;
        break;
      case NavigationIconeType.options:
        icone = Icons.settings_rounded;
        texteCouleur = route == "/" ? Colors.white : Couleurs.texte;
        break;
    }

    return Icon(
      icone,
      color: texteCouleur,
      size: widget.isAndroid ? ecran.width * 0.1 : ecran.width * 0.03,
    );
  }
}
