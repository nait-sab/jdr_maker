import 'package:flutter/material.dart';

/// Classe : Alerte
///
/// Type : Widget (Commun)
///
/// Créer une alerte personnalisé
class Alerte {
  static void afficherAlerte(BuildContext context, Widget child) {
    print("test");
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
}
