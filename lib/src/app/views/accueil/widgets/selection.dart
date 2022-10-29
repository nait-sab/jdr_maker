import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe : Accueil - Sélection
///
/// Type : Widget
///
/// Contient la sélection de projet
class AccueilSelection extends StatefulWidget {
  final List<ProjetModel> projets;

  AccueilSelection({
    required this.projets,
  });

  @override
  State<AccueilSelection> createState() => _AccueilSelectionState();
}

class _AccueilSelectionState extends State<AccueilSelection> {
  void rejoindreCreationProjet() {
    NavigationController.changerView(context, "/creer_jdr");
  }

  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      width: ecran.width / 4,
      color: Couleurs.fondSecondaire,
      child: Wrap(children: liste(context)),
    );
  }

  List<Widget> liste(BuildContext context) {
    List<Widget> liste = [];

    if (widget.projets.isEmpty) {
      liste.add(Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all()),
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

    liste.add(Bouton(
      onTap: rejoindreCreationProjet,
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

    return liste;
  }

  Widget boutonProjet(ProjetModel projet) {
    return Bouton(
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
