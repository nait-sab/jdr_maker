import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Alerte
///
/// Type : Widget (Commun)
///
/// Créer une alerte personnalisé
class Alerte {
  static void afficherAlerte(BuildContext context, Widget child) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }

  static void demander(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Couleurs.fondSecondaire,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Titre"),
                    Text("Description"),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
