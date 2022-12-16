import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_boutons.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_champ.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_entete.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_formulaire.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';

/// Classe Inscription
///
/// Type : View
///
/// Page d'inscription de l'application
class InscriptionView extends StatefulWidget {
  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  // Controllers formulaire
  late TextEditingController usernameController;
  late TextEditingController mailController;
  late TextEditingController passeController;

  // Contenu du formulaire
  late List<Widget> formulaire;

  // Variables
  late bool chargement;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();
    mailController = TextEditingController();
    passeController = TextEditingController();

    formulaire = [
      ConnexionChamp(nom: "Nom d'utilisateur", controller: usernameController),
      SizedBox(height: 10),
      ConnexionChamp(nom: "Adresse email", controller: mailController),
      SizedBox(height: 10),
      ConnexionChamp(nom: "Mot de passe", controller: passeController, secret: true),
    ];
  }

  void changerRoute(String route) => NavigationController.changerView(context, route);

  void chargerUtilisateur(UtilisateurModel utilisateurModel) {
    UtilisateurController.changerUtilisateur(context, utilisateurModel);
  }

  Future creerCompte() async {
    // Récupération des champs
    String nom = usernameController.text;
    String mail = mailController.text;
    String passe = passeController.text;

    // Vérification problème
    if (nom.isEmpty) {
      print("Aucun nom renseigné");
    }

    if (mail.isEmpty) {
      print("Aucun email renseigné");
    }

    if (passe.length < 6) {
      print("Mot de passe trop court");
    }

    UtilisateurModel? utilisateurModel;

    // Créer le compte sur Android
    if (Platform.isAndroid) {
      await FirebaseAndroidTool.creerCompte(mail, passe);
    }

    // Créer le compte sur Desktop
    if (Platform.isWindows) {
      await FirebaseDesktopTool.creerCompte(mail, passe);
      var utilisateur = await FirebaseDesktopTool.getUtilisateur();

      utilisateurModel = UtilisateurModel(
        id: utilisateur!.id,
        mail: mail,
        username: nom,
      );

      await FirebaseDesktopTool.ajouterDocumentID(
        UtilisateurModel.nomCollection,
        utilisateur.id,
        utilisateurModel.toMap(),
      );
    }

    chargerUtilisateur(utilisateurModel!);
    changerRoute("/accueil");
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  Widget renduAndroid(BuildContext context) {
    return Container();
  }

  Widget renduDesktop(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: Column(
        children: [
          ConnexionEntete(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  ConnexionFormulaire(contenu: formulaire),
                  ConnexionBoutons(
                    boutonDroite: false,
                    actionBoutonPrincipal: creerCompte,
                    actionBoutonChanger: () => changerRoute("/connexion"),
                    texteBoutonPrincipal: "Inscription",
                    texteBoutonChanger: "< Connexion",
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
