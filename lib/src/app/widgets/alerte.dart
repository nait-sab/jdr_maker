import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Alerte
///
/// Type : Widget (Commun)
///
/// Créer une alerte personnalisé
class Alerte {
  /// Afficher un message avec un [titre] et un [texte]
  static void message(BuildContext context, String titre, String texte) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * (Platform.isAndroid ? 0.9 : 0.5),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Couleurs.fondSecondaire,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    texte,
                    style: TextStyle(
                      fontSize: 18,
                      color: Couleurs.texte,
                    ),
                  ),
                  SizedBox(height: 20),
                  Bouton(
                    onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                    child: Center(
                      child: Text(
                        "Fermer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Couleurs.violet,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void demander(BuildContext context, String titre, String description, VoidCallback action) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Couleurs.fondSecondaire,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Couleurs.texte,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Bouton(
                        onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      Bouton(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          action();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Couleurs.violet,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Confirmer",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
