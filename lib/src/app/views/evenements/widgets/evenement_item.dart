import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/evenement_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';

/// Classe : Evenement Item
///
/// Type : Widget de la liste
class EvenementItem extends StatefulWidget {
  final EvenementModel evenement;

  EvenementItem({
    required this.evenement,
  });

  @override
  State<EvenementItem> createState() => _EvenementItemState();
}

class _EvenementItemState extends State<EvenementItem> {
  /// Enregistrer l'evenement demandé et ouvrir sa view
  void ouvrirEvenement() {
    EvenementController.changerEvenement(context, widget.evenement);
    NavigationController.changerView(context, "/evenement");
  }

  @override
  Widget build(BuildContext context) {
    return Bouton(
      onTap: ouvrirEvenement,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Couleurs.fondPrincipale,
        ),
        child: Row(
          children: [
            Text(
              "N°${widget.evenement.numero}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Platform.isAndroid ? 20 : 14,
              ),
            ),
            SizedBox(width: 20),
            Text(
              widget.evenement.nom,
              style: TextStyle(
                color: Colors.white,
                fontSize: Platform.isAndroid ? 20 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
