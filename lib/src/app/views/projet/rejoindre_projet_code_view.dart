import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton_icone.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/models/membre_model.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe : Rejoindre un Projet
///
/// Type : View
///
/// Contient la page pour rejoindre un projet par code d'invitation
class RejoindreProjetCodeView extends StatefulWidget {
  @override
  State<RejoindreProjetCodeView> createState() => _RejoindreProjetCodeViewState();
}

class _RejoindreProjetCodeViewState extends State<RejoindreProjetCodeView> {
  /// Chargement de la page
  late bool chargement;

  /// Projet trouver ou non
  late bool projetTrouver;

  /// Code saisie + sauvegarde
  late TextEditingController codeSaisie;
  late String codeSaisieTemp;

  /// Projet trouvé
  late ProjetModel? projet;

  @override
  void initState() {
    super.initState();
    chargement = false;
    projetTrouver = false;
    codeSaisieTemp = "";
    codeSaisie = TextEditingController();
  }

  void afficherMessage(String texte) => Alerte.message(context, "Rejoindre un projet", texte);
  void retourOptions() => NavigationController.changerView(context, "/options");

  Future chercherProjet() async {
    if (codeSaisie.text.isEmpty) {
      return afficherMessage("Aucun code renseigné");
    }

    setState(() => chargement = true);
    projet = null;
    projetTrouver = false;
    await FirebaseGlobalTool.recupererListe(ProjetModel.nomCollection, (data) {
      ProjetModel cible = ProjetModel.fromMap(data);
      if (!cible.codeUtilisable) {
        setState(() => chargement = false);
        return afficherMessage("Code expiré");
      }
      if (cible.codeMembre == codeSaisie.text) {
        projet = cible;
        projetTrouver = true;
        codeSaisieTemp = codeSaisie.text;
      }
    });
    setState(() => chargement = false);
  }

  Future ajouterProjet() async {
    // Annuler si le code est différent de celui enregistré
    if (codeSaisieTemp != codeSaisie.text) {
      return chercherProjet();
    }

    setState(() => chargement = true);
    String id = getRandomString(20);
    MembreModel membre = MembreModel(
      id: id,
      idProjet: projet!.id,
      idMembre: UtilisateurController.getUtilisateur(context).id,
    );

    // L'utilisateur est-il le créateur du projet
    if (projet!.idCreateur == membre.idMembre) {
      setState(() => chargement = false);
      return afficherMessage("Vous êtes déjà créateur du projet");
    }

    // Chercher les membres
    List<MembreModel> listeMembres = [];
    await FirebaseGlobalTool.recupererListe(MembreModel.nomCollection, (data) {
      MembreModel cible = MembreModel.fromMap(data);
      if (cible.idProjet == projet!.id) {
        listeMembres.add(cible);
      }
    });

    // L'utilisateur est-il membre du projet
    for (MembreModel cible in listeMembres) {
      if (cible.idMembre == membre.idMembre) {
        setState(() => chargement = false);
        return afficherMessage("Vous êtes déjà membre du projet");
      }
    }

    // Ajout du membre et désactivation du code d'invitation
    projet!.codeUtilisable = false;
    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(
        MembreModel.nomCollection,
        id,
        membre.toMap(),
      );
      await FirebaseDesktopTool.modifierDocument(ProjetModel.nomCollection, projet!.id, projet!.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(
        MembreModel.nomCollection,
        id,
        membre.toMap(),
      );
      await FirebaseAndroidTool.modifierDocument(ProjetModel.nomCollection, projet!.id, projet!.toMap());
    }

    retourOptions();
  }

  @override
  Widget build(BuildContext context) {
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
          EnteteApplication(routeRetour: "/options", titreFormulaire: "Rejoindre un projet"),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Code d'invitation",
                          style: TextStyle(
                            fontSize: Platform.isAndroid ? 16 : 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: codeSaisie,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Code...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelStyle: TextStyle(fontSize: Platform.isAndroid ? 16 : 20),
                            hintStyle: TextStyle(fontSize: Platform.isAndroid ? 14 : 18),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        afficherProjet(),
                      ],
                    ),
                  ),
                ),
                icone(),
              ],
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

  Widget afficherProjet() {
    if (!projetTrouver) {
      return Container();
    }
    return Column(
      children: [
        SizedBox(height: 50),
        Text(
          "Projet trouver : ${projet!.nom}",
          style: TextStyle(
            fontSize: Platform.isAndroid ? 16 : 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget icone() {
    Widget icone = projetTrouver
        ? BoutonIcone(icone: Icons.done_rounded, action: ajouterProjet)
        : BoutonIcone(icone: Icons.search_rounded, action: chercherProjet);

    return Align(
      alignment: Alignment.bottomRight,
      child: icone,
    );
  }
}
