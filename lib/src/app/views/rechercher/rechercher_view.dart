import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Rechercher
///
/// Type : Page
///
/// Contient la page de recherche de l'accueil
class RechercherView extends StatefulWidget {
  @override
  State<RechercherView> createState() => _RechercherViewState();
}

class _RechercherViewState extends State<RechercherView> {
  // Controller
  late ProjetController projetController;

  // Listes
  late List<ProjetModel> projetsPublic;
  late List<String> utilisateursCreateur;

  // Chargement et Lock
  late bool chargement;
  late bool lock;

  @override
  void initState() {
    super.initState();

    // Initialisations des variables
    chargement = false;
    lock = false;
    projetsPublic = [];
    utilisateursCreateur = [];
  }

  Future getProjetsPublics() async {
    setState(() => chargement = true);

    for (ProjetModel projet in projetController.projets) {
      if (projet.isPublic) {
        projetsPublic.add(projet);
        utilisateursCreateur.add(UtilisateurModel.fromMap(
          await FirebaseDesktopTool.getCollectionID(
            UtilisateurModel.nomCollection,
            projet.idCreateur,
          ),
        ).username);
      }
    }

    lock = true;
    setState(() => chargement = false);
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);

    if (!lock) {
      getProjetsPublics();
    }

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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
      child: Column(
        children: [
          EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Recherche"),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: projetsPublic.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            projetsPublic[index].nomProjet,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            projetsPublic[index].idCreateur,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            utilisateursCreateur[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            projetsPublic[index].id,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
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
