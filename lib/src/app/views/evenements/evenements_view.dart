import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/views/evenements/widgets/evenement_item.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton_icone.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';

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
  late List<EvenementModel> evenements;

  @override
  void initState() {
    super.initState();
    evenements = ProjetController.getEvenements(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Événements"),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Couleurs.fondSecondaire,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: getListe(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BoutonIcone(icone: Icons.add_rounded, action: () => NavigationController.changerView(context, "/creer_evenement")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getListe() {
    List<Widget> liste = [];

    for (int index = 0; index < evenements.length; index++) {
      liste.add(EvenementItem(evenement: evenements[index]));
      if (index != evenements.length - 1) {
        liste.add(SizedBox(height: 20));
      }
    }

    return liste;
  }
}
