import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class ChampCheckbox extends StatefulWidget {
  final bool etatInitial;
  final VoidCallback action;

  ChampCheckbox({
    required this.etatInitial,
    required this.action,
  });

  @override
  State<ChampCheckbox> createState() => _ChampCheckboxState();
}

class _ChampCheckboxState extends State<ChampCheckbox> {
  late bool etat;

  @override
  void initState() {
    super.initState();
    etat = widget.etatInitial;
  }

  void changement() {
    setState(() => etat = !etat);
    widget.action();
  }

  @override
  Widget build(BuildContext context) {
    return Bouton(
      onTap: changement,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: etat ? Couleurs.violet : Couleurs.fondPrincipale,
        ),
      ),
    );
  }
}
