import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/evenement_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/app/widgets/boutons/form_bouton.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/enums/form_bouton_type.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:provider/provider.dart';

/// Classe : Événements
///
/// Type : View
///
/// Contient la liste des événements du projet
class EvenementsView extends StatefulWidget {
  @override
  State<EvenementsView> createState() => _EvenementsViewState();
}

class _EvenementsViewState extends State<EvenementsView> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Événements"),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: getListe(),
                    ),
                  ),
                  FormBouton(
                    boutonType: FormBoutonType.ajouter,
                    alignement: Alignment.bottomRight,
                    action: () => NavigationController.changerView(context, "/creer_evenement"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void choixEvenement(EvenementModel evenement) {
    EvenementController.changerEvenement(context, evenement);
    NavigationController.changerView(context, "/evenement");
  }

  List<Widget> getListe() {
    List<EvenementModel> evenements = projetController.evenements!;
    List<Widget> liste = [];

    for (int index = 0; index < evenements.length; index++) {
      liste.add(boutonEvenement(evenements[index]));
      if (index != evenements.length - 1) {
        liste.add(SizedBox(height: 20));
      }
    }

    return liste;
  }

  Widget boutonEvenement(EvenementModel evenement) {
    Size ecran = MediaQuery.of(context).size;
    return Bouton(
      onTap: () => choixEvenement(evenement),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Couleurs.fondSecondaire,
        ),
        child: Row(
          children: [
            Text(
              "N°${evenement.numero}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
              ),
            ),
            SizedBox(width: 20),
            Text(
              evenement.nom,
              style: TextStyle(
                color: Colors.white,
                fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
