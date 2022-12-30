import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/views/applications/applications_view.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:provider/provider.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class AccueilView extends StatefulWidget {
  @override
  State<AccueilView> createState() => _AccueilViewState();
}

class _AccueilViewState extends State<AccueilView> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);

    if (projetController.projet != null) {
      return Scaffold(
        backgroundColor: Couleurs.fondPrincipale,
        body: AppInterface(child: ApplicationsView()),
      );
    }

    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: AppInterface(
        child: Center(
          child: Text(
            "Aucun projet sélectionné",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
