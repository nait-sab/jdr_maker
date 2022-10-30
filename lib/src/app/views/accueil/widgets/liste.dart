import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Liste
///
/// Type : Widget
///
/// Contient la liste des applications de projet
class AccueilListe extends StatefulWidget {
  @override
  State<AccueilListe> createState() => _AccueilListeState();
}

class _AccueilListeState extends State<AccueilListe> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);

    if (projetController.projet == null) {
      return renduDefault(context);
    }

    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  Widget renduDefault(BuildContext context) {
    return Center(
      child: Text(
        "Aucun projet sélectionné",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renduDesktop(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${projetController.projet!.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${projetController.projet!.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
