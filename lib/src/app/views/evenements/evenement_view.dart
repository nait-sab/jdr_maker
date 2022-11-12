import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:provider/provider.dart';

/// Classe : Événement
///
/// Type : View
///
/// Afficher l'événement sélectionner
class EvenementView extends StatefulWidget {
  @override
  State<EvenementView> createState() => _EvenementViewState();
}

class _EvenementViewState extends State<EvenementView> {
  late EvenementModel evenement;

  @override
  Widget build(BuildContext context) {
    evenement = Provider.of<ProjetController>(context).evenement!;
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/evenements", titreFormulaire: evenement.nomEvenement),
          ],
        ),
      ),
    );
  }
}
