import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_boutons.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_champ.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_entete.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_formulaire.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';

/// Classe Connexion
///
/// Type : View
///
/// Page de connexion de l'application
class ConnexionView extends StatefulWidget {
  @override
  State<ConnexionView> createState() => _ConnexionViewState();
}

class _ConnexionViewState extends State<ConnexionView> {
  // Controllers formulaire
  late TextEditingController mailController;
  late TextEditingController passeController;

  // Contenu du formulaire
  late List<Widget> formulaire;

  // Variables
  late bool chargement;

  @override
  void initState() {
    super.initState();

    mailController = TextEditingController();
    passeController = TextEditingController();

    chargement = false;
    formulaire = [
      ConnexionChamp(nom: "Adresse email", controller: mailController),
      SizedBox(height: 10),
      ConnexionChamp(nom: "Mot de passe", controller: passeController, secret: true),
    ];
  }

  void changerRoute(String route) => NavigationController.changerRoute(context, route);
  void afficherMessage(String texte) => Alerte.message(context, "Tentative de connexion", texte);

  void chargerUtilisateur(UtilisateurModel utilisateur) {
    UtilisateurController.changerUtilisateur(context, utilisateur);
  }

  Future login() async {
    String mail = mailController.text;
    String passe = passeController.text;

    if (mail.isEmpty) {
      return afficherMessage("Aucun email renseigné");
    }

    if (passe.isEmpty) {
      return afficherMessage("Aucun mot de passe renseigné");
    }

    setState(() => chargement = true);
    if (Platform.isAndroid) {
      bool connexionReussi = await FirebaseAndroidTool.connexion(mail, passe);
      if (connexionReussi) {
        var utilisateur = FirebaseAndroidTool.getUtilisateur();
        var userInfos = await FirebaseAndroidTool.getdocumentID(UtilisateurModel.nomCollection, utilisateur!.uid);
        chargerUtilisateur(UtilisateurModel.fromMap(userInfos));
      } else {
        setState(() => chargement = false);
        return afficherMessage("Compte introuvable");
      }
    }

    if (Platform.isWindows) {
      bool connexionReussi = await FirebaseDesktopTool.connexion(mail, passe);
      if (connexionReussi) {
        var utilisateur = await FirebaseDesktopTool.getUtilisateur();
        var userInfos = await FirebaseDesktopTool.getdocumentID(UtilisateurModel.nomCollection, utilisateur!.id);
        chargerUtilisateur(UtilisateurModel.fromMap(userInfos));
      } else {
        setState(() => chargement = false);
        return afficherMessage("Compte introuvable");
      }
    }

    if (await UtilisateurController.verifierUtilisateur()) {
      await chargerProjets();
      setState(() => chargement = false);
      changerRoute("/accueil");
    }
  }

  Future chargerProjets() async => await ProjetController.chargerProjets(context);

  @override
  Widget build(BuildContext context) {
    if (chargement) {
      return Scaffold(
        backgroundColor: Couleurs.fondPrincipale,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chargement de votre compte en cours...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              Chargement(),
            ],
          ),
        ),
      );
    }

    return Platform.isAndroid ? renduAndroid() : renduDesktop();
  }

  Widget renduAndroid() {
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
                      boutonDroite: true,
                      actionBoutonPrincipal: login,
                      actionBoutonChanger: () => changerRoute("/inscription"),
                      texteBoutonPrincipal: "Connexion",
                      texteBoutonChanger: "Inscription >",
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

  Widget renduDesktop() {
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
                    boutonDroite: true,
                    actionBoutonPrincipal: login,
                    actionBoutonChanger: () => changerRoute("/inscription"),
                    texteBoutonPrincipal: "Connexion",
                    texteBoutonChanger: "Inscription >",
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
