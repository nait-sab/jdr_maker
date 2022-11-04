import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';

/// Classe : Formulaire Entete
///
/// Type : Widget (Commun)
///
/// Créer un entête d'application avec un bouton de retour et un titre
class EnteteApplication extends StatefulWidget {
  final String routeRetour;
  final String titreFormulaire;

  EnteteApplication({
    required this.routeRetour,
    required this.titreFormulaire,
  });

  @override
  State<EnteteApplication> createState() => _EnteteApplicationState();
}

class _EnteteApplicationState extends State<EnteteApplication> {
  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Bouton(
              onTap: () => NavigationController.changerView(context, widget.routeRetour),
              child: Text(
                Platform.isAndroid ? "<" : "< Retour",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Platform.isAndroid ? 22 : ecran.width * 0.02,
                ),
              ),
            ),
          ),
          Align(
            child: Text(
              widget.titreFormulaire,
              style: TextStyle(
                fontSize: Platform.isAndroid ? 22 : ecran.width * 0.02,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
