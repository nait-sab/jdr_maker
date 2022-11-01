import 'dart:io';

import 'package:flutter/material.dart';

/// Classe : Accueil - Options
///
/// Type : Page
///
/// Contient la page d'options de l'accueil
class AccueilPageOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    return Center(
      child: Text(
        "Options",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Options",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
