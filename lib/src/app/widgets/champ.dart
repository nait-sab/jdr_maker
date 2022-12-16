import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe : Champ
///
/// Type : Widget (Commun)
///
/// Créer un champ de formulaire personnalisé
class Champ extends StatefulWidget {
  final TextInputType typeChamp;
  final TextEditingController controller;

  final String? nomChamp;
  final double? tailleTexte;
  final Color? couleurTexte;
  final bool? contenuCacher;
  final int? longueurMax;
  final List<TextInputFormatter>? inputFormatters;

  Champ({
    required this.typeChamp,
    required this.controller,
    this.nomChamp,
    this.tailleTexte,
    this.couleurTexte,
    this.contenuCacher,
    this.longueurMax,
    this.inputFormatters,
  });

  @override
  State<Champ> createState() => _ChampState();
}

class _ChampState extends State<Champ> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.nomChamp ?? "",
        labelStyle: TextStyle(
          fontSize: widget.tailleTexte ?? 22,
          color: widget.couleurTexte ?? Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Couleurs.fondPrincipale, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Couleurs.texte, width: 3),
        ),
      ),
      keyboardType: widget.typeChamp,
      obscureText: widget.contenuCacher ?? false,
      maxLength: widget.longueurMax,
      style: TextStyle(
        fontSize: widget.tailleTexte ?? 22,
        color: widget.couleurTexte ?? Colors.black,
      ),
      inputFormatters: widget.inputFormatters ?? [],
    );
  }
}
