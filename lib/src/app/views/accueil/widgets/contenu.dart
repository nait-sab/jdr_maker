import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/views/applications/applications_view.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Contenu
///
/// Type : Widget
///
/// Contient le contenu de l'application selon le projet et/ou la route
class AccueilContenu extends StatefulWidget {
  @override
  State<AccueilContenu> createState() => _AccueilContenuState();
}

class _AccueilContenuState extends State<AccueilContenu> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);

    if (projetController.projet != null) {
      return ApplicationsView(projet: projetController.projet!);
    }

    return Center(
      child: Text(
        "Aucun projet sélectionné",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
