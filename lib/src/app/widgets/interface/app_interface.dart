import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
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
  /// Controller de navigation
  late NavigationController navigationController;

  /// Chargement de la page
  late bool chargement;

  /// Vérouiller la recherche de projets une fois terminé
  late bool rechercheProjetsTerminer;

  /// Afficher ou non la sélection de projets
  late bool afficherProjets;

  /// Liste des projets
  late List<ProjetModel> projets;

  @override
  void initState() {
    super.initState();
    chargement = true;
    rechercheProjetsTerminer = false;
    afficherProjets = false;
    projets = [];
  }

  void changerRoute(String route) {
    NavigationController.changerView(context, route);
  }

  /// Vérifier la connexion de l'utilisateur
  Future verifierUtilisateur() async {
    Object? utilisateurConnecter;

    Platform.isAndroid
        ? utilisateurConnecter = FirebaseAndroidTool.getUtilisateur()
        : utilisateurConnecter = await FirebaseDesktopTool.getUtilisateur();

    // TODO - Commenter l'appel si besoin de modifier sans se connecter
    // if (utilisateurConnecter == null) {
    //   changerRoute("/inscription");
    // }
  }

  /// Récupérer la liste des projets
  Future recupererProjets() async {
    await FirebaseGlobalTool.recupererListe(ProjetModel.nomCollection, (data) {
      projets.add(ProjetModel.fromMap(data));
    });

    setState(() {
      rechercheProjetsTerminer = true;
      chargement = false;
    });
  }

  void modifierAffichageProjets() {
    setState(() => afficherProjets = !afficherProjets);
  }

  Future changerProjet(String projetID) async {
    ProjetModel? projetSelectionner;

    setState(() {
      chargement = true;
    });

    for (ProjetModel projet in projets) {
      if (projetID == projet.id) {
        projetSelectionner = projet;
      }
    }

    await ProjetController.changerProjet(
      context,
      projetSelectionner!,
    );

    if (!(navigationController.currentRoute == "/" || navigationController.currentRoute == "/aceuil")) {
      changerRoute("/accueil");
    }

    setState(() {
      afficherProjets = false;
      chargement = false;
    });
  }

  void rafraichir() {
    setState(() {
      chargement = true;
      rechercheProjetsTerminer = false;
      afficherProjets = false;
      projets = [];
    });
  }

  Widget definirRendu(BuildContext context) {
    if (chargement) {
      return Chargement();
    }

    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  @override
  Widget build(BuildContext context) {
    navigationController = Provider.of<NavigationController>(context);
    verifierUtilisateur();
    if (!rechercheProjetsTerminer) {
      recupererProjets();
    }
    return Scaffold(backgroundColor: Couleurs.fondPrincipale, body: definirRendu(context));
  }

  Widget renduDesktop(BuildContext context) {
    return Container(
      color: Couleurs.fondPrincipale,
      child: Column(
        children: [
          AccueilEntete(actionTitre: modifierAffichageProjets),
          Expanded(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccueilNavigation(isAndroid: false, rafraichir: rafraichir),
                    // Zone
                    Expanded(child: widget.child),
                  ],
                ),
                if (afficherProjets) AccueilSelection(projets: projets, changerProjet: changerProjet),
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
              onTap: modifierAffichageProjets,
              child: AccueilTitre(isAndroid: true),
            ),
            Expanded(
              child: Stack(
                children: [
                  widget.child,
                  if (afficherProjets) AccueilSelection(projets: projets, changerProjet: changerProjet),
                ],
              ),
            ),
            AccueilNavigation(isAndroid: true, rafraichir: rafraichir),
          ],
        ),
      ),
    );
  }
}
