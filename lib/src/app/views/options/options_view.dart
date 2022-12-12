import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe Options
///
/// Type : View
///
/// Page contenant les options de l'application
class OptionsView extends StatefulWidget {
  @override
  State<OptionsView> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {
  @override
  Widget build(BuildContext context) {
    return AppInterface(
      child: Platform.isAndroid ? renduMobile(context) : renduDesktop(context),
    );
  }

  void boutonDeconnexion() {
    NavigationController.changerView(context, "/accueil");
  }

  void goChangeAccount() {
    NavigationController.changerView(context, "/modifier_profil");
  }

  Widget renduDesktop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Options"),
          Expanded(
            child: Stack(
              children: [
                GridView.count(
                  crossAxisCount: 7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    optionBoutonDesktop("Modifier son profil", Icons.person_rounded, action: goChangeAccount),
                    optionBoutonDesktop("Modifier le projet", Icons.layers_rounded),
                    optionBoutonDesktop("Membres du projet", Icons.manage_accounts_rounded),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            optionBoutonMobile("Déconnexion", action: boutonDeconnexion),
          ],
        ),
      ),
    );
  }

  Widget optionBoutonMobile(String texte, {VoidCallback? action}) {
    return Bouton(
      onTap: action ?? (() {}),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Couleurs.fondSecondaire,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          texte,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget optionBoutonDesktop(String texte, IconData icone, {VoidCallback? action}) {
    Size ecran = MediaQuery.of(context).size;
    return Bouton(
      onTap: action ?? (() {}),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Couleurs.fondSecondaire,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icone,
                color: Couleurs.violet,
                size: ecran.width * 0.04,
              ),
              Text(
                texte,
                style: TextStyle(
                  color: Couleurs.texte,
                  fontSize: ecran.width * 0.01,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
