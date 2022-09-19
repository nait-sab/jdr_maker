import 'package:flutter/material.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
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
