import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe : Accueil - Titre
///
/// Type : Widget
///
/// Contient le titre ou le projet sélectionné dans l'accueil
class AccueilTitre extends StatefulWidget {
  final bool isAndroid;
  final ProjetModel? projet;

  AccueilTitre({
    required this.isAndroid,
    required this.projet,
  });

  @override
  State<AccueilTitre> createState() => _AccueilTitreState();
}

class _AccueilTitreState extends State<AccueilTitre> {
  String nomProjet() {
    return widget.projet == null ? "Projet JDR" : widget.projet!.nomProjet;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5),
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(right: BorderSide()),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              nomProjet(),
              style: TextStyle(
                fontSize: ecran.width * 0.01,
                color: Couleurs.texte,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: Couleurs.texte,
          ),
        ],
      ),
    );
  }

  Widget renduAndroid(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Couleurs.fondSecondaire,
        border: Border(bottom: BorderSide()),
        boxShadow: [
          BoxShadow(blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              nomProjet(),
              style: TextStyle(
                fontSize: ecran.width * 0.04,
                color: Couleurs.texte,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: Couleurs.texte,
          ),
        ],
      ),
    );
  }
}
