import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/entete.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/liste.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/navigation.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/selection.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/titre.dart';
import 'package:jdr_maker/src/app/widgets/alerte/alerte.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class AccueilView extends StatefulWidget {
  @override
  State<AccueilView> createState() => _AccueilViewState();
}

class _AccueilViewState extends State<AccueilView> {
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
    if (Platform.isAndroid) {
      var collection = await FirebaseAndroidTool.getCollection("Projets");
      var liste = collection.docs.map((document) => document.data()).toList();
      for (var data in liste) {
        projets.add(ProjetModel.fromMap(data));
      }
    } else {
      var collection = await FirebaseDesktopTool.getCollection("Projets");
      for (var document in collection) {
        projets.add(ProjetModel.fromMap(document.map));
      }
    }

    setState(() {
      rechercheProjetsTerminer = true;
      chargement = false;
    });
  }

  void modifierAffichageProjets() {
    setState(() => afficherProjets = !afficherProjets);
  }

  dynamic changerProjet(String projetID) {
    ProjetModel? projetSelectionner;
    for (ProjetModel projet in projets) {
      if (projetID == projet.id) {
        projetSelectionner = projet;
      }
    }
    setState(() {
      afficherProjets = false;
      ProjetController.changerProjet(context, projetSelectionner!);
    });
  }

  Widget definirRendu(BuildContext context) {
    if (chargement) {
      return renduChargement(context);
    }

    return Platform.isAndroid ? renduAndroid(context) : renduDesktop(context);
  }

  @override
  Widget build(BuildContext context) {
    verifierUtilisateur();
    if (!rechercheProjetsTerminer) {
      recupererProjets();
    }
    return Scaffold(backgroundColor: Couleurs.fondPrincipale, body: definirRendu(context));
  }

  Widget renduChargement(BuildContext context) {
    return Container(
      color: Couleurs.fondPrincipale,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
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
                    AccueilNavigation(isAndroid: false),
                    // Zone
                    Expanded(child: AccueilListe())
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
                  AccueilListe(),
                  if (afficherProjets) AccueilSelection(projets: projets, changerProjet: changerProjet),
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
