import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/champ.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:provider/provider.dart';

/// Classe : Événement
///
/// Type : View
///
/// Afficher l'édition d'un événement
class EvenementEditView extends StatefulWidget {
  @override
  State<EvenementEditView> createState() => _EvenementEditViewState();
}

class _EvenementEditViewState extends State<EvenementEditView> {
  late bool chargement;
  late TextEditingController champNom;
  late TextEditingController champDescription;
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
    chargement = false;
    champNom = TextEditingController();
    champDescription = TextEditingController();
  }

  Future modifier() async {
    if (champNom.text.isEmpty) {
      return;
    }

    setState(() {
      chargement = true;
    });

    String id = projetController.evenement!.id;
    EvenementModel evenement = EvenementModel(
      id: id,
      idCreateur: projetController.evenement!.idCreateur,
      idProjet: projetController.evenement!.idProjet,
      numero: projetController.evenement!.numero,
      nom: champNom.text,
      description: champDescription.text,
    );
    EvenementModel evenement = projetController.evenement!;
    evenement.nom = champNom.text;
    evenement.description = champDescription.text

    Platform.isAndroid
        ? await FirebaseAndroidTool.modifierDocument(EvenementModel.nomCollection, id, evenement.toMap())
        : await FirebaseDesktopTool.modifierDocument(EvenementModel.nomCollection, id, evenement.toMap());

    await actualiser();

    setState(() {
      NavigationController.changerView(context, "/evenement");
    });
  }

  Future actualiser() async => await ProjetController.actualiser(context);

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    champNom.text = projetController.evenement!.nom;
    champDescription.text = projetController.evenement!.description;

    return AppInterface(child: chargement ? Chargement() : renduFormulaire());
  }

  Widget renduFormulaire() {
    Size ecran = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          EnteteApplication(routeRetour: "/evenement", titreFormulaire: "Modifier un événement"),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Couleurs.fondSecondaire,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Champ(
                    typeChamp: TextInputType.text,
                    controller: champNom,
                    nomChamp: "Nom de l'événement",
                    couleurTexte: Couleurs.texte,
                  ),
                  SizedBox(height: 20),
                  Champ(
                    typeChamp: TextInputType.multiline,
                    controller: champDescription,
                    nomChamp: "Description de l'événement",
                    couleurTexte: Couleurs.texte,
                  ),
                  Spacer(),
                  Bouton(
                    onTap: modifier,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Couleurs.violet,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Modifier",
                        style: TextStyle(
                          fontSize: Platform.isAndroid ? 22 : ecran.width * 0.015,
                          color: Colors.white,
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
}
