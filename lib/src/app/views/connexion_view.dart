import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController passController;
  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    passController = TextEditingController();
  }

  void goAcceuil() {
    NavigationController.changerView(context, "/");
  }

  void goInscription() {
    NavigationController.changerView(context, "/inscription");
  }

  Future login() async {
    String mailValue = mailController.text;
    String passValue = passController.text;
    String? userID = "";
    if (Platform.isAndroid) {
      await FirebaseAndroidTool.connexion(mailValue, passValue);
      userID = FirebaseAndroidTool.getUtilisateur()?.uid;
    } else {
      await FirebaseDesktopTool.connexion(mailValue, passValue);
      userID = FirebaseDesktopTool.getUtilisateurID();
    }
    if (userID!.isNotEmpty) {
      goAcceuil();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size largeurEcran = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF19191D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: SizedBox(
          //     width: largeurEcran.width / 2.4,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(left: 10),
          //           child: Text(
          //             "Nom d'utilisateur",
          //             style: TextStyle(fontSize: 20, color: Colors.white),
          //           ),
          //         ),
          //         SizedBox(height: 15),
          //         TextFormField(
          //           controller: userNameController,
          //           decoration: InputDecoration(
          //             fillColor: Colors.white,
          //             filled: true,
          //             hintText: "Nom d'utilisateur",
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(30)),
          //               borderSide: BorderSide(color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20),
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
            onTap: login,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff36AC50),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                "Connexion",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: goInscription,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                "Creer un compte",
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
