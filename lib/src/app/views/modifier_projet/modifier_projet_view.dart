import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/champ.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Modifier Projet
///
/// Type : View
///
/// Contient la page de modification du projet actuel
class ModifierProjetView extends StatefulWidget {
  @override
  State<ModifierProjetView> createState() => _ModifierProjetViewState();
}

class _ModifierProjetViewState extends State<ModifierProjetView> {
  late bool chargement;
  late ProjetController projetController;
  late TextEditingController nomProjet;

  @override
  void initState() {
    super.initState();
    chargement = false;
    nomProjet = TextEditingController();
  }

  Future modifierProjet() async {
    if (nomProjet.text.isEmpty) {
      return;
    }

    if (nomProjet.text != projetController.projet!.nomProjet) {
      setState(() => chargement = true);

      String id = projetController.projet!.id;
      ProjetModel projet = projetController.projet!;
      projet.nomProjet = nomProjet.text;

      await FirebaseGlobalTool.modifierDocument(ProjetModel.nomCollection, id, projet.toMap());
      await actualiser();

      setState(() => NavigationController.changerView(context, "/options"));
    }
  }

  Future actualiser() async => await ProjetController.actualiser(context);

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    nomProjet.text = projetController.projet!.nomProjet;

    return AppInterface(
      child: chargement
          ? Chargement()
          : Platform.isAndroid
              ? renduMobile(context)
              : renduDesktop(context),
    );
  }

  Widget renduDesktop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EnteteApplication(routeRetour: "/options", titreFormulaire: "Modifier le projet"),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Couleurs.fondSecondaire,
              ),
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Champ(
                          typeChamp: TextInputType.text,
                          controller: nomProjet,
                          nomChamp: "Nom du projet",
                          couleurTexte: Couleurs.texte,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Bouton(
                      onTap: modifierProjet,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Couleurs.violet,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.done_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Rechercher",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
