import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/views/accueil/pages/accueil_applications.dart';
import 'package:jdr_maker/src/app/views/accueil/pages/accueil_options.dart';
import 'package:jdr_maker/src/app/views/accueil/pages/accueil_rechercher.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Contenue
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
    String route = Provider.of<NavigationController>(context).currentRoute;

    if (route == "/" || route == "/accueil") {
      return projetController.projet == null
          ? renduDefault(context)
          : AccueilPageApplications(projet: projetController.projet!);
    } else if (route == "/rechercher") {
      return AccueilPageRechercher();
    } else if (route == "/options") {
      return AccueilPageOptions();
    }

    return Center(child: Text("AccueilContenu::Build::Erreur"));
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
}
