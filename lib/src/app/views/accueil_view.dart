import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:provider/provider.dart';

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
  void allerBonjour() {
    Provider.of<NavigationController>(context, listen: false).changerRoute("/bonjour");
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
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: allerBonjour,
            child: Container(
              color: Colors.amber,
              padding: EdgeInsets.all(10),
              child: Text(
                "Page bonjour",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
