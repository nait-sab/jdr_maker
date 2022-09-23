import 'package:flutter/material.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class AccueilView extends StatefulWidget {
  @override
  State<AccueilView> createState() => _AccueilViewState();
}

class _AccueilViewState extends State<AccueilView> {
  @override
  void initState() {
    super.initState();

    // Vérification si l'utilisateur est connecté
    // if !connecter
    //  NavigationController.changerView(context, "/connexion");

    // Affichage de l'interface selon les données user
    // La gestion ne doit pas apparaître si aucun JDR est lié à l'user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "JDR Maker",
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
