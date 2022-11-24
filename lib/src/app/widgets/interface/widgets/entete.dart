import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/recherche.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/titre.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Accueil - Entête
///
/// Type : Widget
///
/// Contient l'entête de l'accueil
class AccueilEntete extends StatelessWidget {
  final VoidCallback actionTitre;

  AccueilEntete({
    required this.actionTitre,
  });

  @override
  Widget build(BuildContext context) {
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
            Bouton(
              onTap: actionTitre,
              child: AccueilTitre(isAndroid: false),
            ),
            AccueilRecherche(),
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
