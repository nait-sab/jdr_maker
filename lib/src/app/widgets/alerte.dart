import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Alerte
///
/// Type : Widget (Commun)
///
/// Créer une alerte personnalisé
class Alerte {
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
