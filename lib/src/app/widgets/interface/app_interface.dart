import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
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
  /// Controller des projets
  late ProjetController projetController;

  /// Chargement de la page
  late bool chargement;
  late bool recupererationProjets;

  /// Afficher ou non la sélection de projets
  late bool afficherProjets;

  @override
  void initState() {
    super.initState();
    chargement = false;
    recupererationProjets = true;
    afficherProjets = false;
  }

  void changerSelection() => setState(() => afficherProjets = !afficherProjets);
  void retourAccueil() => setState(() => NavigationController.changerView(context, "/accueil"));

  Future changerProjet(ProjetModel projetModel) async {
    setState(() => chargement = true);
    await ProjetController.changerProjet(context, projetModel);
    retourAccueil();
    setState(() => {afficherProjets = false, chargement = false});
  }

  Future chargerProjets() async {
    setState(() => chargement = true);
    await ProjetController.chargerProjets(context);
    print("chargement des projets");
    setState(() => recupererationProjets = false);
    setState(() => chargement = false);
  /// Vérifier la connexion de l'utilisateur
  Future verifierUtilisateur() async {
    Object? utilisateurConnecter;

    Platform.isAndroid
        ? utilisateurConnecter = FirebaseAndroidTool.getUtilisateur()
        : utilisateurConnecter = await FirebaseDesktopTool.getUtilisateur();

    if (utilisateurConnecter == null &&
        navigationController.currentRoute != "/connexion" &&
        navigationController.currentRoute != "/inscription") {
      changerRoute("/connexion");
    }
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    String route = Provider.of<NavigationController>(context).currentRoute;

    // Récupération des projets depuis l'accueil
    if ((route == "/" || route == "/accueil") && recupererationProjets) {
      chargerProjets();
    }

    return Scaffold(backgroundColor: Couleurs.fondPrincipale, body: definirRendu(context));
  }

  Widget definirRendu(BuildContext context) {
    if (chargement) {
      return Chargement();
    }
    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    return Container(
      color: Couleurs.fondPrincipale,
      child: Column(
        children: [
          AccueilEntete(actionTitre: changerSelection),
          Expanded(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccueilNavigation(isAndroid: false),
                    // Zone
                    Expanded(child: widget.child),
                  ],
                ),
                if (afficherProjets) AccueilSelection(action: changerProjet),
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
              child: AccueilTitre(isAndroid: true),
            ),
            Expanded(
              child: Stack(
                children: [
                  widget.child,
                  if (afficherProjets) AccueilSelection(action: changerProjet),
                ],
              ),
            ),
            AccueilNavigation(isAndroid: true),
          ],
        ),
      ),
    );
  }
}
