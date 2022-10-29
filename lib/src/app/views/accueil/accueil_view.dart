import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/entete.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/liste.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/navigation.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/titre.dart';
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

  /// Liste des projets
  late List<ProjetModel> projets;

  @override
  void initState() {
    super.initState();
    chargement = true;
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
    Object listeProjets = Platform.isAndroid
        ? await FirebaseAndroidTool.getCollection("Projets")
        : await FirebaseDesktopTool.getCollection("Projets");

    print(listeProjets);

    setState(() => chargement = false);
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
    recupererProjets();

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
          AccueilEntete(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccueilNavigation(isAndroid: false),
                // Zone
                Expanded(child: AccueilListe())
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
            AccueilTitre(isAndroid: true),
            Expanded(child: AccueilListe()),
            AccueilNavigation(isAndroid: true),
          ],
        ),
      ),
    );
  }
}
