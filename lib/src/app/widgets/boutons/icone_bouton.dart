import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Bouton Icone
///
/// Type : Widget (Commun)
class BoutonIcone extends StatelessWidget {
  /// Icone du bouton
  final IconData icone;

  /// Action du bouton
  final VoidCallback action;

  /// Bouton du bouton (Violet par défaut)
  final Color? couleur;

  BoutonIcone({
    required this.icone,
    required this.action,
    Color? couleur,
  }) : couleur = couleur ?? Couleurs.violet;

  @override
  Widget build(BuildContext context) {
    return Bouton(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: couleur,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icone,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
