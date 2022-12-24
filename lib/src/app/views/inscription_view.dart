import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';

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
  late TextEditingController usernameController;
  late TextEditingController mailController;
  late TextEditingController passController;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    mailController = TextEditingController();
    passController = TextEditingController();
  }

  void goConnexion() {
    NavigationController.changerView(context, "/connexion");
  }

  void goAcceuil() {
    NavigationController.changerView(context, "/");
  }

  Future createAccount() async {
    String usernameValue = usernameController.text;
    String mailValue = mailController.text;
    String passValue = passController.text;
    String? userID = "";
    Map<String, dynamic> userInfos = {'mail': mailValue, 'username': usernameValue};
    if (Platform.isAndroid) {
      await FirebaseAndroidTool.creerCompte(mailValue, passValue);
      userID = FirebaseAndroidTool.getUtilisateur()?.uid;
      userInfos.addAll({"id": userID});
      await FirebaseAndroidTool.ajouterDocumentID("Utilisateurs", userID!, userInfos);
    } else {
      await FirebaseDesktopTool.creerCompte(mailValue, passValue);
      userID = FirebaseDesktopTool.getUtilisateurID();
      userInfos.addAll({"id": userID});
      await FirebaseDesktopTool.ajouterDocumentID("Utilisateurs", userID, userInfos);
    }
    goAcceuil();
  }

  @override
  Widget build(BuildContext context) {
    Size largeurEcran = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF19191D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: largeurEcran.width / 2.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Nom d'utilisateur",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Nom d'utilisateur",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: largeurEcran.width / 2.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Adresse Mail",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Adresse Mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: largeurEcran.width / 2.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Mot de passe",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Mot de passe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: createAccount,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff36AC50),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                "Inscription",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: goConnexion,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                "J'ai déjà un compte",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}