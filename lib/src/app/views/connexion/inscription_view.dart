import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_boutons.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_champ.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_entete.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_formulaire.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
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
  void afficherMessage(String texte) => Alerte.message(context, "Tentative d'inscription", texte);

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
      return afficherMessage("Aucun nom renseigné");
    }

    if (mail.isEmpty) {
      return afficherMessage("Aucun email renseigné");
    }

    if (!EmailValidator.validate(mail)) {
      return afficherMessage("Email invalide");
    }

    if (passe.isEmpty) {
      return afficherMessage("Aucun mot de passe renseigné");
    }

    if (passe.length < 6) {
      return afficherMessage("Votre mot de passe doit contenir au moins 6 caractères");
    }

    UtilisateurModel? utilisateurModel;

    // Créer le compte sur Android
    if (Platform.isAndroid) {
      bool connexionReussi = await FirebaseAndroidTool.creerCompte(mail, passe);
      if (connexionReussi) {
        var utilisateur = FirebaseAndroidTool.getUtilisateur();

        utilisateurModel = UtilisateurModel(
          id: utilisateur!.uid,
          mail: mail,
          username: nom,
        );

        await FirebaseAndroidTool.ajouterDocumentID(
          UtilisateurModel.nomCollection,
          utilisateur.uid,
          utilisateurModel.toMap(),
        );
      } else {
        return afficherMessage("Impossible de créer ce compte");
      }
    }

    // Créer le compte sur Desktop
    if (Platform.isWindows) {
      bool connexionReussi = await FirebaseDesktopTool.creerCompte(mail, passe);
      if (connexionReussi) {
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
      } else {
        return afficherMessage("Impossible de créer ce compte");
      }
    }

    chargerUtilisateur(utilisateurModel!);
    changerRoute("/accueil");
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  Widget renduAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Projet JDR",
              style: TextStyle(
                color: Couleurs.texte,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      ),
    );
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
