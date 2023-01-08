import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdr_maker/src/app/views/projet/widgets/creationEntete.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : ViewsCreateJDRWidgets
///
/// Type : Widgets
///
/// Contient les widgets utilisés par la view
class ViewsCreateJDRWidgets {
  static Widget rendu1(
      BuildContext context,
      TextEditingController nomJdrController,
      String nomJdr,
      VoidCallback creationJDR) {
    return Column(
      children: [
        Platform.isAndroid ? Container() : CreationEntete(),
        Padding(
          padding: EdgeInsets.only(top: Platform.isAndroid ? 50 : 20),
          child: EnteteApplication(
              routeRetour: "/accueil",
              titreFormulaire: "Création d'un Jeu de rôle"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Couleurs.fondSecondaire,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Le départ d'une nouvelle aventure...",
                        style: TextStyle(
                          fontSize: Platform.isAndroid ? 15 : 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ChampSaisie(
                    typeChamp: TextInputType.text,
                    controller: nomJdrController,
                    nomChamp: "Nom du jeu de rôle",
                    couleurTexte: Couleurs.texte,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                      onPressed: creationJDR,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Couleurs.violet),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Créer le jeu de rôle",
                          style:
                              TextStyle(fontSize: Platform.isAndroid ? 20 : 30),
                        ),
                      )),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  static Widget rendu2(BuildContext context, VoidCallback creationJDR) {
    creationJDR();
    return Column(
      children: [
        Platform.isAndroid ? Container() : CreationEntete(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Création de votre jeu de Rôle en cours...",
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 7,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Couleurs.violet //<-- SEE HERE
                        ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Veuillez ne pas fermer la fenêtre pendant la création",
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.01,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
