import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/entete.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/navigation.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/selection.dart';
import 'package:jdr_maker/src/app/widgets/interface/widgets/titre.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Interface
///
/// Type : Widget (Commun)
///
/// Insérer l'interface de l'application (navigation, sélection / titre, rechercher)
class AppInterface extends StatefulWidget {
  final Widget child;

  AppInterface({
    required this.child,
  });

  @override
  State<AppInterface> createState() => _AppInterfaceState();
}

class _AppInterfaceState extends State<AppInterface> {
  // Controllers
  late ProjetController projetController;
  late UtilisateurController utilisateurController;
  late NavigationController navigationController;

  /// Afficher ou non la sélection de projets
  late bool selectionVisible;

  // Chargement de l'interface
  late bool chargement;

  @override
  void initState() {
    super.initState();
    chargement = false;
    selectionVisible = false;
  }

  Future chargerProjet(ProjetModel projet) async {
    if (projetController.projet != projet) {
      switchChargement();
      changerSelection();
      await ProjetController.chargerProjet(context, projet);
      switchChargement();
    } else {
      changerSelection();
    }
  }

  void switchChargement() => setState(() => chargement = !chargement);
  void changerSelection() => setState(() => selectionVisible = !selectionVisible);
  void retourAccueil() => setState(() => NavigationController.changerView(context, "/accueil"));

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    utilisateurController = Provider.of<UtilisateurController>(context);
    navigationController = Provider.of<NavigationController>(context);

    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: Platform.isAndroid ? renduAndroid(context) : renduDesktop(context),
    );
  }

  Widget renduDesktop(BuildContext context) {
    return Container(
      color: Couleurs.fondPrincipale,
      child: Column(
        children: [
          AccueilEntete(actionTitre: changerSelection, projet: projetController.projet),
          Expanded(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccueilNavigation(
                      isAndroid: false,
                      projetController: projetController,
                      switchChargement: switchChargement,
                    ),
                    // Zone
                    afficherContenu(),
                  ],
                ),
                afficherSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renduAndroid(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Couleurs.fondPrincipale,
      child: SafeArea(
        child: Column(
          children: [
            Bouton(
              onTap: changerSelection,
              child: AccueilTitre(isAndroid: true, projet: projetController.projet),
            ),
            Expanded(
              child: Stack(
                children: [
                  afficherContenu(),
                  afficherSelection(),
                ],
              ),
            ),
            AccueilNavigation(
              isAndroid: true,
              projetController: projetController,
              switchChargement: switchChargement,
            ),
          ],
        ),
      ),
    );
  }

  Widget afficherContenu() {
    if (chargement) {
      return Platform.isAndroid ? Chargement() : Expanded(child: Chargement());
    }
    return Platform.isAndroid ? widget.child : Expanded(child: widget.child);
  }

  Widget afficherSelection() {
    if (!selectionVisible) {
      return Container();
    }
    return AccueilSelection(
      projets: projetController.projets,
      action: chargerProjet,
    );
  }
}
