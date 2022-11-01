import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/contenu.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/entete.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/navigation.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/selection.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/titre.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:jdr_maker/src/domain/models/objet_model.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
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
    await recupererListe(projets, ProjetModel.nomCollection, (data) {
      projets.add(ProjetModel.fromMap(data));
    });

    setState(() {
      rechercheProjetsTerminer = true;
      chargement = false;
    });
  }

  Future recupererListe(List<dynamic> liste, String nomCollection, Function action) async {
    if (Platform.isAndroid) {
      var collection = await FirebaseAndroidTool.getCollection(nomCollection);
      var liste = collection.docs.map((document) => document.data()).toList();
      for (var data in liste) {
        action(data);
      }
    } else {
      var collection = await FirebaseDesktopTool.getCollection(nomCollection);
      for (var document in collection) {
        action(document.map);
      }
    }
  }

  void modifierAffichageProjets() {
    setState(() => afficherProjets = !afficherProjets);
  }

  Future changerProjet(String projetID) async {
    ProjetModel? projetSelectionner;
    List<EvenementModel> evenements = [];
    List<PersonnageModel> personnages = [];
    List<LieuModel> lieux = [];
    List<ObjetModel> objets = [];

    setState(() {
      chargement = true;
    });

    for (ProjetModel projet in projets) {
      if (projetID == projet.id) {
        projetSelectionner = projet;
      }
    }

    await recupererListe(evenements, EvenementModel.nomCollection, (data) {
      evenements.add(EvenementModel.fromMap(data));
    });

    await recupererListe(personnages, PersonnageModel.nomCollection, (data) {
      personnages.add(PersonnageModel.fromMap(data));
    });

    await recupererListe(lieux, LieuModel.nomCollection, (data) {
      lieux.add(LieuModel.fromMap(data));
    });

    await recupererListe(objets, ObjetModel.nomCollection, (data) {
      objets.add(ObjetModel.fromMap(data));
    });

    setState(() {
      afficherProjets = false;
      chargement = false;
      ProjetController.changerProjet(
        context,
        projetSelectionner!,
        evenements,
        personnages,
        lieux,
        objets,
      );
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
                    AccueilNavigation(isAndroid: false, rafraichir: rafraichir),
                    // Zone
                    Expanded(child: AccueilContenu())
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
                  AccueilContenu(),
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
