import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Sélection
///
/// Type : Widget
///
/// Contient la sélection de projet
class AccueilSelection extends StatefulWidget {
  @override
  State<AccueilSelection> createState() => _AccueilSelectionState();
}

class _AccueilSelectionState extends State<AccueilSelection> {
  late ProjetController projetController;

  void boutonCreation() => NavigationController.changerView(context, "/creer_jdr");

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    Size ecran = MediaQuery.of(context).size;
    return Container(
      width: Platform.isAndroid ? double.infinity : ecran.width / 4,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
        color: Couleurs.fondSecondaire,
      ),
      child: renduListe(),
    );
  }

  Widget renduListe() {
    if (projetController.projets!.length < 5) {
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

    if (projetController.projets!.isEmpty) {
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
      for (ProjetModel projet in projetController.projets!) {
        liste.add(boutonProjet(projet));
      }
    }

    liste.add(Bouton(
      onTap: boutonCreation,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            "Créer un projet",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));

    return liste;
  }

  Widget boutonProjet(ProjetModel projet) {
    return Bouton(
      onTap: () {},
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
