import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/views/accueil/accueil_view.dart';
import 'package:jdr_maker/src/app/views/connexion_view.dart';
import 'package:jdr_maker/src/app/views/creerJDR/debut_jdr_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenement_create_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenement_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenements_view.dart';
import 'package:jdr_maker/src/app/views/inscription_view.dart';
import 'package:jdr_maker/src/app/views/options/options_view.dart';
import 'package:jdr_maker/src/app/views/personnage/personnage_create.dart';
import 'package:jdr_maker/src/app/views/personnage/personnages_view.dart';
import 'package:jdr_maker/src/app/views/rechercher/rechercher_view.dart';
import 'package:provider/provider.dart';

/// Liste des pages de l'application
///
/// Le rooting s'éffectue selon la route
/// actuelle du controller navigation
///
/// Routes actuelles :
///
/// - / (accueil)
/// - /connexion
/// - /inscription
List<Page> applicationRoutes(context) {
  NavigationController navigation = Provider.of<NavigationController>(context);
  List<Page> liste = [];

  // Route par défaut
  liste.add(MaterialPage(child: AccueilView()));

  // Routing
  // Toujours un / en début de route
  switch (navigation.currentRoute) {
    // =======================================================
    // Routes Connexion / Inscription
    // =======================================================
    case "/connexion":
      liste.add(MaterialPage(child: ConnexionView()));
      break;
    case "/inscription":
      liste.add(MaterialPage(child: InscriptionView()));
      break;

    // =======================================================
    // Routes de l'accueil
    // =======================================================
    case "/accueil":
      liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/rechercher":
      liste.add(MaterialPage(child: RechercherView()));
      break;
    case "/options":
      liste.add(MaterialPage(child: OptionsView()));
      break;
    case "/creer_jdr":
      liste.add(MaterialPage(child: DebutJDR()));
      break;
    case "/jouer":
      //liste.add(MaterialPage(child: ));
      break;

    // =======================================================
    // Routes de l'application événement
    // =======================================================
    case "/evenements":
      liste.add(MaterialPage(child: EvenementsView()));
      break;
    case "/evenement":
      liste.add(MaterialPage(child: EvenementView()));
      break;
    case "/creer_evenement":
      liste.add(MaterialPage(child: EvenementCreateView()));
      break;

    // =======================================================
    // Routes de l'application personnage
    // =======================================================
    case "/personnages":
      liste.add(MaterialPage(child: PersonnagesView()));
      break;
    case "/personnage":
      liste.add(MaterialPage(child: PersonnageView()));
      break;
    case "/creer_personnage":
      liste.add(MaterialPage(child: EvenementCreateView()));
      break;
  }

  return liste;
}
