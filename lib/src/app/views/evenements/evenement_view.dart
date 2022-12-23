import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/evenement_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
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
/// Afficher l'événement sélectionner
class EvenementView extends StatefulWidget {
  @override
  State<EvenementView> createState() => _EvenementViewState();
}

class _EvenementViewState extends State<EvenementView> {
  late EvenementModel evenement;
  late bool chargement;

  @override
  void initState() {
    super.initState();
    chargement = false;
  }

  void alerteSupprimer() {
    Alerte.demander(
      context,
      "Supprimer l'événement",
      "Souhaitez-vous vraiment supprimer l'événement \"${evenement.nom}\" ?",
      () async {
        setState(() {
          chargement = true;
        });

        if (Platform.isAndroid) {
          await FirebaseAndroidTool.supprimerDocument(EvenementModel.nomCollection, evenement.id);
        } else {
          await FirebaseDesktopTool.supprimerDocument(EvenementModel.nomCollection, evenement.id);
        }

        await supprimer();
        retour();
      },
    );
  }

  Future supprimer() async {
    await ProjetController.actualiserProjet(context);
  }

  void retour() => NavigationController.changerView(context, "/evenements");

  @override
  Widget build(BuildContext context) {
    evenement = Provider.of<EvenementController>(context).evenement!;

    if (chargement) {
      return AppInterface(child: Chargement());
    }

    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/evenements", titreFormulaire: evenement.nom),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: afficherEvenement(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Bouton(
                        onTap: alerteSupprimer,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Couleurs.rouge,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Bouton(
                        onTap: () => NavigationController.changerView(context, "/modifier_evenement"),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Couleurs.violet,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.edit_rounded,
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
      ),
    );
  }

  List<Widget> afficherEvenement() {
    List<Widget> liste = [];

    liste.add(titre(context, "Nom"));
    liste.add(contenu(context, evenement.nom));
    liste.add(SizedBox(height: 20));

    if (evenement.description != "") {
      liste.add(titre(context, "Description"));
      liste.add(contenu(context, evenement.description));
    }

    liste.add(SizedBox(height: 100));
    return liste;
  }

  Widget titre(BuildContext context, String titre) {
    Size ecran = MediaQuery.of(context).size;
    return Text(
      titre,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: ecran.width * 0.02,
      ),
    );
  }

  Widget contenu(BuildContext context, String texte) {
    Size ecran = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        texte,
        style: TextStyle(
          color: Couleurs.texte,
          fontSize: ecran.width * 0.015,
        ),
      ),
    );
  }
}
