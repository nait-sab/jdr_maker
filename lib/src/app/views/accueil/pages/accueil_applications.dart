import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe : Accueil - Applications
///
/// Type : Page
///
/// Contient la page des applications du projet sélectionné de l'accueil
class AccueilPageApplications extends StatelessWidget {
  final ProjetModel projet;

  AccueilPageApplications({
    required this.projet,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${projet.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${projet.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
