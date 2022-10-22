import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/recherche.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/titre.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Accueil - Entête
///
/// Type : Widget
///
/// Contient l'entête de l'accueil
class AccueilEntete extends StatelessWidget {
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
      child: Row(
        children: [
          AccueilTitre(isAndroid: false),
          AccueilRecherche(),
        ],
      ),
    );
  }
}
