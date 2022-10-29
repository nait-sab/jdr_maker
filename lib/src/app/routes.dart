import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/views/accueil/accueil_view.dart';
import 'package:jdr_maker/src/app/views/connexion_view.dart';
import 'package:jdr_maker/src/app/views/creerJDR/debut_jdr_view.dart';
import 'package:jdr_maker/src/app/views/inscription_view.dart';
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
    case "/accueil":
      liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/connexion":
      liste.add(MaterialPage(child: ConnexionView()));
      break;
    case "/inscription":
      liste.add(MaterialPage(child: InscriptionView()));
      break;
    case "/creer_jdr":
      liste.add(MaterialPage(child: DebutJDR()));
      break;
    case "/projet":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/evenements":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/evenement":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/personnages":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/personnage":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/lieux":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/lieu":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/objets":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/objet":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/options":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/profil":
      //liste.add(MaterialPage(child: AccueilView()));
      break;
  }

  return liste;
}
