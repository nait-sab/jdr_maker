import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton_icone.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton_switch.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Modifier un Projet
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

  // Données du projet
  late TextEditingController nomProjet;
  late bool isPublic;

  @override
  void initState() {
    super.initState();
    chargement = false;
    isPublic = false;
    nomProjet = TextEditingController();
  }

  Future modifierProjet() async {
    if (nomProjet.text.isEmpty) {
      return;
    }

    setState(() => chargement = true);
    ProjetModel projet = projetController.projet!;
    projet.nom = nomProjet.text;
    projet.isPublic = isPublic;
    await FirebaseGlobalTool.modifierDocument(ProjetModel.nomCollection, projet.id, projet.toMap());
    setState(() => NavigationController.changerView(context, "/options"));
  }

  void changerPublic() => isPublic = !isPublic;

  Future supprimerProjet() async {
    Alerte.demander(
      context,
      "Supprimer le projet",
      "Souhaitez-vous vraiment supprimer le projet \"${projetController.projet!.nom}\" ?",
      () async {
        setState(() {
          chargement = true;
        });

        await _supprimer();
        accueil();
      },
    );
  }

  Future _supprimer() async {
    await ProjetController.supprimerProjet(context);
  }

  void accueil() => NavigationController.changerView(context, "/accueil");

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    nomProjet.text = projetController.projet!.nom;
    isPublic = projetController.projet!.isPublic;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChampSaisie(
                          typeChamp: TextInputType.text,
                          controller: nomProjet,
                          nomChamp: "Nom du projet",
                          couleurTexte: Couleurs.texte,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Projet public :",
                              style: TextStyle(
                                fontSize: 22,
                                color: Couleurs.texte,
                              ),
                            ),
                            BoutonSwitch(actif: isPublic, action: changerPublic),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: BoutonIcone(
                      icone: Icons.delete_rounded,
                      action: supprimerProjet,
                      couleur: Couleurs.rouge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: BoutonIcone(
                      icone: Icons.done_rounded,
                      action: modifierProjet,
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
