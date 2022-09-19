import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:provider/provider.dart';

/// Classe Bonjour
///
/// Type : View
///
/// Page d'exemple
class Bonjour extends StatefulWidget {
  @override
  State<Bonjour> createState() => _BonjourState();
}

class _BonjourState extends State<Bonjour> {
  void retourAccueil() {
    Provider.of<NavigationController>(context, listen: false).changerRoute("/");
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
              "Hi white rabbit",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: retourAccueil,
            child: Container(
              color: Colors.amber,
              padding: EdgeInsets.all(10),
              child: Text(
                "Page accueil",
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
