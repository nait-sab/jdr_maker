import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class Chargement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Couleurs.fondPrincipale,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
