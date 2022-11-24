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
                  children: [
                    InkWell(
                      onTap: goChangeAccount,
                      child: Container(
                        height: 14,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(20), color: Couleurs.fondSecondaire),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                  child: Icon(
                                Icons.edit,
                                size: 100,
                                color: Couleurs.violet,
                              )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Modifier son profil",
                                    style: TextStyle(color: Couleurs.texte, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
            optionBouton("Déconnexion", action: boutonDeconnexion),
          ],
        ),
      ),
    );
  }

  Widget optionBouton(String texte, {VoidCallback? action}) {
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
}
