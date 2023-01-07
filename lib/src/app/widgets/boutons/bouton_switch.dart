import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class BoutonSwitch extends StatefulWidget {
  /// État par défaut du switch
  final bool actif;

  /// Action lié au switch
  final VoidCallback action;

  BoutonSwitch({
    required this.actif,
    required this.action,
  });

  @override
  State<BoutonSwitch> createState() => _BoutonSwitchState();
}

class _BoutonSwitchState extends State<BoutonSwitch> {
  late bool actif;

  @override
  void initState() {
    super.initState();
    actif = widget.actif;
  }

  void onTap() {
    setState(() {
      widget.action();
      actif = !actif;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Bouton(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: actif ? Couleurs.violet.withOpacity(0.2) : Couleurs.fondPrincipale,
        ),
        child: Row(
          children: [
            // Bord Gauche
            SizedBox(width: actif ? 30 : 0),
            // Curseur
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Couleurs.violet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
