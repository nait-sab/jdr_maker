import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';

/// Classe : Accueil - Barre de recherche
///
/// Type : Widget
///
/// Contient la barre de recherche de l'accueil
class AccueilRecherche extends StatefulWidget {
  @override
  State<AccueilRecherche> createState() => _AccueilRechercheState();
}

class _AccueilRechercheState extends State<AccueilRecherche> {
  @override
  void initState() {
    super.initState();
  }

  void goRecherche() {
    NavigationController.changerView(context, "/rechercher");
  }

  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Rechercher...",
                style: TextStyle(
                  fontSize: ecran.width * 0.01,
                  color: Color(0xff81818F),
                ),
              ),
            ),
            InkWell(
              onTap: goRecherche,
              child: Icon(
                Icons.search_rounded,
                color: Color(0xff81818F),
              ),
            )
          ],
        ),
      ),
    );
  }
}
