import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
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
/// Afficher la création d'un nouvel événement
class EvenementCreateView extends StatefulWidget {
  @override
  State<EvenementCreateView> createState() => _EvenementCreateViewState();
}

class _EvenementCreateViewState extends State<EvenementCreateView> {
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

  Future creer() async {
    if (champNom.text.isEmpty) {
      return;
    }

    setState(() {
      chargement = true;
    });

    String idEvenement = getRandomString(20);
    int numero = projetController.evenements!.length + 1;
    EvenementModel evenement = EvenementModel(
      id: idEvenement,
      idCreateur: getRandomString(20),
      idProjet: projetController.projet!.id,
      numero: numero.toString(),
      nom: champNom.text,
      description: champDescription.text,
    );

    Platform.isAndroid
        ? await FirebaseAndroidTool.ajouterDocumentID(EvenementModel.nomCollection, idEvenement, evenement.toMap())
        : await FirebaseDesktopTool.ajouterDocumentID(EvenementModel.nomCollection, idEvenement, evenement.toMap());

    await actualiser();
    setState(() => NavigationController.changerView(context, "/evenements"));
  }

  Future actualiser() async => ProjetController.actualiserProjet(context);

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(child: chargement ? Chargement() : renduFormulaire());
  }

  Widget renduFormulaire() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          EnteteApplication(routeRetour: "/evenements", titreFormulaire: "Créer un événement"),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Couleurs.fondSecondaire,
              ),
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(
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
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Bouton(
                      onTap: creer,
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
}
