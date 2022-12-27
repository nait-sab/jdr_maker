import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe : Accueil - Sélection
///
/// Type : Widget
///
/// Contient la sélection de projet
class AccueilSelection extends StatefulWidget {
  final List<ProjetModel> projets;
  final Function action;

  AccueilSelection({
    required this.projets,
    required this.action,
  });

  @override
  State<AccueilSelection> createState() => _AccueilSelectionState();
}

class _AccueilSelectionState extends State<AccueilSelection> {
  void boutonCreation() => changerRoute("/creer_projet");
  void changerRoute(String route) => NavigationController.changerView(context, route);

  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      width: Platform.isAndroid ? double.infinity : ecran.width * 0.25,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Couleurs.fondSecondaire,
      ),
      child: renduListe(),
    );
  }

  Widget renduListe() {
    if (widget.projets.length < 5) {
      return Wrap(
        children: liste(),
      );
    }

    return SizedBox(
      height: 250,
      child: SingleChildScrollView(child: Column(children: liste())),
    );
  }

  List<Widget> liste() {
    List<Widget> liste = [];

    liste.add(Bouton(
      onTap: boutonCreation,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
          child: Text(
            "Créer un projet",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));

    if (widget.projets.isEmpty) {
      liste.add(Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            "Vous n'avez aucun projet",
            style: TextStyle(color: Couleurs.texte),
          ),
        ),
      ));
    } else {
      for (ProjetModel projet in widget.projets) {
        liste.add(boutonProjet(projet));
      }
    }

    return liste;
  }

  Widget boutonProjet(ProjetModel projet) {
    return Bouton(
      onTap: () => widget.action(projet),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all()),
        child: Row(
          children: [
            Text(
              projet.nomProjet,
              style: TextStyle(color: Couleurs.texte),
            ),
          ],
        ),
      ),
    );
  }
}
