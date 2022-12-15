import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class ConnexionEntete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Couleurs.fondSecondaire,
        border: Border(bottom: BorderSide()),
        boxShadow: [
          BoxShadow(blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: MoveWindow(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Projet JDR",
                style: TextStyle(
                  fontSize: ecran.width * 0.01,
                  color: Couleurs.texte,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 1,
              decoration: BoxDecoration(border: Border(right: BorderSide())),
            ),
            Row(
              children: [
                MinimizeWindowButton(colors: couleurBoutonWindow()),
                MaximizeWindowButton(colors: couleurBoutonWindow()),
                CloseWindowButton(colors: couleurBoutonWindow()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  WindowButtonColors couleurBoutonWindow() {
    return WindowButtonColors(
      mouseOver: Couleurs.fondPrincipale,
      mouseDown: Couleurs.fondPrincipale,
      iconNormal: Couleurs.violet,
      iconMouseDown: Couleurs.violet,
      iconMouseOver: Couleurs.violet,
    );
  }
}
