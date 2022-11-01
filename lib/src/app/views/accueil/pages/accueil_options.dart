import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Accueil - Options
///
/// Type : Page
///
/// Contient la page d'options de l'accueil
class AccueilPageOptions extends StatefulWidget {
  @override
  State<AccueilPageOptions> createState() => _AccueilPageOptionsState();
}

class _AccueilPageOptionsState extends State<AccueilPageOptions> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  void boutonDeconnexion() {
    NavigationController.changerView(context, "/accueil");
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            optionBouton("Déconnexion", action: boutonDeconnexion),
          ],
        ),
      ),
    );
  }

  Widget optionBouton(String texte, {VoidCallback? action}) {
    return Bouton(
      onTap: action ?? (() {}),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Couleurs.fondSecondaire,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          texte,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
