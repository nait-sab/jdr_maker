import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_boutons.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_champ.dart';
import 'package:jdr_maker/src/app/views/connexion/widgets/connexion_entete.dart';
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
  late TextEditingController mailController;
  late TextEditingController passeController;

  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    passeController = TextEditingController();
  }

  void changerRoute(String route) => NavigationController.changerView(context, route);

  void chargerUtilisateur(UtilisateurModel utilisateur) {
    UtilisateurController.changerUtilisateur(context, utilisateur);
  }

  Future login() async {
    String mail = mailController.text;
    String passe = passeController.text;

    if (mail.isEmpty) {
      print("Aucun email");
    }

    if (passe.length < 6) {
      print("Mot de passe trop court");
    }

    UtilisateurModel? utilisateurModel;

    if (Platform.isAndroid) {
      await FirebaseAndroidTool.connexion(mail, passe);
    }

    if (Platform.isWindows) {
      await FirebaseDesktopTool.connexion(mail, passe);
      var utilisateur = await FirebaseDesktopTool.getUtilisateur();
      var userInfos = await FirebaseDesktopTool.getCollectionID(UtilisateurModel.nomCollection, utilisateur!.id);
      chargerUtilisateur(UtilisateurModel.fromMap(userInfos));
      changerRoute("/accueil");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  Widget renduAndroid(BuildContext context) {
    return Container();
  }

  Widget renduDesktop(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: Container(
        color: Couleurs.fondPrincipale,
        child: Column(
          children: [
            ConnexionEntete(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      width: ecran.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Couleurs.fondSecondaire,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ConnexionChamp(nom: "Adresse email", controller: mailController),
                          SizedBox(height: 10),
                          ConnexionChamp(nom: "Mot de passe", controller: passeController, secret: true),
                        ],
                      ),
                    ),
                    Spacer(),
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
}
