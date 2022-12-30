import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/evenement_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/widgets/boutons/form_bouton.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/enums/form_bouton_type.dart';
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
  late EvenementController evenementController;

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

    setState(() => chargement = true);

    EvenementModel evenement = evenementController.evenement!;
    String id = evenement.id;
    evenement.nom = champNom.text;
    evenement.description = champDescription.text;
    await FirebaseGlobalTool.modifierDocument(EvenementModel.nomCollection, id, evenement.toMap());
    await actualiser();
    setState(() => NavigationController.changerView(context, "/evenement"));
  }

  Future actualiser() async => await ProjetController.actualiserProjet(context);

  @override
  Widget build(BuildContext context) {
    evenementController = Provider.of<EvenementController>(context);
    champNom.text = evenementController.evenement!.nom;
    champDescription.text = evenementController.evenement!.description;

    return AppInterface(child: chargement ? Chargement() : renduFormulaire());
  }

  Widget renduFormulaire() {
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ChampSaisie(
                        typeChamp: TextInputType.text,
                        controller: champNom,
                        nomChamp: "Nom de l'événement",
                        couleurTexte: Couleurs.texte,
                      ),
                      SizedBox(height: 20),
                      ChampSaisie(
                        typeChamp: TextInputType.multiline,
                        controller: champDescription,
                        nomChamp: "Description de l'événement",
                        couleurTexte: Couleurs.texte,
                      ),
                    ],
                  ),
                  FormBouton(
                    boutonType: FormBoutonType.valider,
                    alignement: Alignment.bottomRight,
                    action: modifier,
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
