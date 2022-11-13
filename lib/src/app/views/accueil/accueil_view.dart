import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/contenu.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class AccueilView extends StatefulWidget {
  @override
  State<AccueilView> createState() => _AccueilViewState();
}

class _AccueilViewState extends State<AccueilView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: AppInterface(child: AccueilContenu()),
    );
  }
}
