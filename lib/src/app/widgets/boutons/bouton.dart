import 'package:flutter/material.dart';

/// Classe : Bouton
///
/// Type : Widget (Commun)
///
/// Créer un bouton personnalisé
class Bouton extends StatelessWidget {
  /// Fonction appeler au clic
  final VoidCallback onTap;

  /// Widget à placer dans le bouton
  final Widget child;

  Bouton({
    VoidCallback? onTap,
    required this.child,
  }) : onTap = onTap ?? (() {});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
