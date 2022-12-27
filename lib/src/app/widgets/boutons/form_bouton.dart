import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/enums/form_bouton_type.dart';

/// Classe : Formulaire Bouton
///
/// Type : Widget (Commun)
///
/// Créer des boutons de formulaires
class FormBouton extends StatelessWidget {
  /// Type du bouton
  final FormBoutonType boutonType;

  /// Emplacement du bouton
  final Alignment alignement;

  /// Action du bouton
  final VoidCallback action;

  FormBouton({
    required this.boutonType,
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
            color: couleur(),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icone(),
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  IconData icone() {
    switch (boutonType) {
      case FormBoutonType.ajouter:
        return Icons.add_rounded;
      case FormBoutonType.valider:
        return Icons.done_rounded;
      case FormBoutonType.fermer:
        return Icons.close_rounded;
      case FormBoutonType.modifier:
        return Icons.edit_rounded;
      case FormBoutonType.supprimer:
        return Icons.delete_rounded;
    }
  }

  Color couleur() {
    switch (boutonType) {
      case FormBoutonType.ajouter:
        return Couleurs.violet;
      case FormBoutonType.valider:
        return Couleurs.violet;
      case FormBoutonType.fermer:
        return Couleurs.rouge;
      case FormBoutonType.modifier:
        return Couleurs.violet;
      case FormBoutonType.supprimer:
        return Couleurs.rouge;
    }
  }
}
