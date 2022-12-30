import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Icone Bouton
///
/// Type : Widget (Commun)
///
/// Créer un bouton icone
class IconeBouton extends StatelessWidget {
  /// Icone du bouton
  final IconData icone;

  /// Emplacement du bouton
  final Alignment alignement;

  /// Action du bouton
  final VoidCallback action;

  IconeBouton({
    required this.icone,
    required this.alignement,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignement,
      child: Bouton(
        onTap: action,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Couleurs.violet,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icone,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
