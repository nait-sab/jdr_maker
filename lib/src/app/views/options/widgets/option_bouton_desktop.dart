import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

/// Classe Bouton Desktop
///
/// Type : Widget - Options
class OptionBoutonDesktop extends StatefulWidget {
  /// Route à charger au tap (Prioritaire sur onTap)
  final String routeOnTap;

  /// Nom du bouton
  final String nom;

  /// Icone du bouton
  final IconData icone;

  /// Couleur du bouton (Fond Secondaire par défaut)
  final Color? couleurBouton;

  /// Couleur de l'icone (Violet par défaut)
  final Color? couleurIcone;

  OptionBoutonDesktop({
    required this.routeOnTap,
    required this.nom,
    required this.icone,
    Color? couleurBouton,
    Color? couleurIcone,
  })  : couleurBouton = couleurBouton ?? Couleurs.fondSecondaire,
        couleurIcone = couleurIcone ?? Couleurs.violet;

  @override
  State<OptionBoutonDesktop> createState() => _OptionBoutonDesktopState();
}

class _OptionBoutonDesktopState extends State<OptionBoutonDesktop> {
  late Color couleurBouton;

  @override
  void initState() {
    super.initState();
    couleurBouton = widget.couleurBouton!;
  }

  void survol(bool isHover) {
    setState(() {
      couleurBouton = isHover ? widget.couleurBouton!.withOpacity(0.75) : widget.couleurBouton!;
    });
  }

  void onTap() => NavigationController.changerView(context, widget.routeOnTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: survol,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: couleurBouton,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              widget.icone,
              color: widget.couleurIcone!,
              size: 50,
            ),
            Text(
              widget.nom,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Couleurs.texte,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
