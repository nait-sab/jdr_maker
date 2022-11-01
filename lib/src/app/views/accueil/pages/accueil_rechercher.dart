import 'dart:io';

import 'package:flutter/material.dart';

/// Classe : Accueil - Rechercher
///
/// Type : Page
///
/// Contient la page de recherche (Mobile) de l'accueil
class AccueilPageRechercher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    return Center(
      child: Text(
        "Rechercher",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Rechercher",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
