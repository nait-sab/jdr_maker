import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe Inscription
///
/// Type : View
///
/// Page d'inscription de l'application
class EditProfileView extends StatefulWidget {
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UtilisateurController utilisateurController;
  late TextEditingController mailController;
  late TextEditingController userController;
  late TextEditingController firstPassController;
  late TextEditingController secondPassController;
  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    userController = TextEditingController();
    firstPassController = TextEditingController();
    secondPassController = TextEditingController();
  }

  void goConnexion() {
    NavigationController.changerView(context, "/connexion");
  }

  void goAcceuil() {
    NavigationController.changerView(context, "/");
  }

  Future updateAccount() async {
    String usernameValue = userController.text;
    String firstPassValue = firstPassController.text;
    String secondPassValue = secondPassController.text;
    UtilisateurModel userInfos = UtilisateurModel(
        id: utilisateurController.utilisateur!.id,
        mail: utilisateurController.utilisateur!.mail,
        username: usernameValue);
    if (utilisateurController.utilisateur?.username != usernameValue) {
      await FirebaseDesktopTool.modifierDocument(
          UtilisateurModel.nomCollection, utilisateurController.utilisateur!.id, userInfos.toMap());
      utilisateurController.actualiser(userInfos);
    }
    if (firstPassValue.isNotEmpty && secondPassValue.isNotEmpty) {
      if (firstPassValue == secondPassValue) {
        await FirebaseDesktopTool.changerCompte(firstPassValue);
        FirebaseDesktopTool.deconnexion();
      }
    }

    if (firstPassValue.isEmpty) {
      goAcceuil();
    } else {
      goConnexion();
    }

    // if (Platform.isAndroid) {
    //   await FirebaseAndroidTool.creerCompte(mailValue, passValue);
    //   userID = FirebaseAndroidTool.getUtilisateur()?.uid;
    //   userInfos.addAll({"id": userID});
    //   await FirebaseAndroidTool.ajouterDocumentID("Utilisateurs", userID!, userInfos);
    // } else {
    //   await FirebaseDesktopTool.creerCompte(mailValue, passValue);
    //   userID = FirebaseDesktopTool.getUtilisateurID();
    //   userInfos.addAll({"id": userID});
    //   await FirebaseDesktopTool.ajouterDocumentID("Utilisateurs", userID, userInfos);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size largeurEcran = MediaQuery.of(context).size;
    utilisateurController = Provider.of<UtilisateurController>(context);
    mailController.text = utilisateurController.utilisateur!.mail;
    userController.text = utilisateurController.utilisateur!.username;
    return AppInterface(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    enabled: false,
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
                      "Nom d'utilisateur",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: userController,
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
                      "Nouveau mot de passe",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    controller: firstPassController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Nouveau mot de passe",
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
                      "Confirmation du nouveau mot de passe",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    controller: secondPassController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Confirmation du nouveau mot de passe",
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
            onTap: updateAccount,
            child: Container(
              decoration: BoxDecoration(
                color: Couleurs.violet,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                "Modifier mon profil",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
