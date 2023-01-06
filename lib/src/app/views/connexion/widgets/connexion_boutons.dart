import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class ConnexionBoutons extends StatelessWidget {
  final bool boutonDroite;
  final VoidCallback actionBoutonPrincipal;
  final VoidCallback actionBoutonChanger;
  final String texteBoutonPrincipal;
  final String texteBoutonChanger;

  ConnexionBoutons({
    required this.boutonDroite,
    required this.actionBoutonPrincipal,
    required this.actionBoutonChanger,
    required this.texteBoutonPrincipal,
    required this.texteBoutonChanger,
  });

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    Size ecran = MediaQuery.of(context).size;
    if (Platform.isAndroid) {
      alignment = boutonDroite ? Alignment.centerLeft : Alignment.centerRight;
    } else {
      alignment = Alignment.center;
    }

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: alignment,
            child: Bouton(
              onTap: actionBoutonPrincipal,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Couleurs.violet,
                ),
                child: Text(
                  texteBoutonPrincipal,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Platform.isAndroid ? 14 : ecran.width * 0.015,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: boutonDroite ? Alignment.centerRight : Alignment.centerLeft,
            child: Bouton(
              onTap: actionBoutonChanger,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  texteBoutonChanger,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Platform.isAndroid ? 14 : ecran.width * 0.015,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
