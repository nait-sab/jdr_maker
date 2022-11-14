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
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
    chargement = false;
    champNom = TextEditingController();
  }

  Future creer() async {
    if (champNom.text.isEmpty) {
      return;
    }

    setState(() {
      chargement = true;
    });

    String idEvenement = getRandomString(20);
    EvenementModel evenement = EvenementModel(
      id: idEvenement,
      idCreateur: getRandomString(20),
      idProjet: projetController.projet!.id,
      nomEvenement: champNom.text,
    );

    Platform.isAndroid
        ? await FirebaseAndroidTool.ajouterDocumentID(EvenementModel.nomCollection, idEvenement, evenement.toMap())
        : await FirebaseDesktopTool.ajouterDocumentID(EvenementModel.nomCollection, idEvenement, evenement.toMap());

    setState(() {
      ProjetController.actualiser(context);
      NavigationController.changerView(context, "/evenements");
    });
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(child: chargement ? Chargement() : renduFormulaire());
  }

  Widget renduFormulaire() {
    Size ecran = MediaQuery.of(context).size;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Champ(
                    typeChamp: TextInputType.text,
                    controller: champNom,
                    nomChamp: "Nom de l'événement",
                    couleurTexte: Couleurs.texte,
                  ),
                  Spacer(),
                  Bouton(
                    onTap: creer,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Couleurs.violet,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Créer",
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
