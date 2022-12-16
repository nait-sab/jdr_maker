import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Rechercher
///
/// Type : Page
///
/// Contient la page de recherche (Mobile) de l'accueil
class RechercherView extends StatefulWidget {
  @override
  State<RechercherView> createState() => _RechercherViewState();
}

class _RechercherViewState extends State<RechercherView> {
  late ProjetController projetController;
  late UtilisateurController utilisateurController;
  late List<ProjetModel> projetsPublic;
  late List<String> utilisateurCreateur;
  late bool chargement;

  @override
  void initState() {
    super.initState();
  }

  Future getListeProjetsPublics(ProjetController projetController) async {
    projetsPublic = [];
    utilisateurCreateur = [];
    for (var projet in projetController.projets) {
      if (projet.isPublic) {
        var user = await FirebaseDesktopTool.getCollectionID("Utilisateurs", projet.idCreateur);
        utilisateurCreateur.add(user['username']);
        projetsPublic.add(projet);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    getListeProjetsPublics(projetController);
    return AppInterface(child: Platform.isAndroid ? renduMobile(context) : renduDesktop(context));
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
                            utilisateurCreateur[index],
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
