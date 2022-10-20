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
    case "/connexion":
      liste.add(MaterialPage(child: ConnexionView()));
      break;
    case "/inscription":
      liste.add(MaterialPage(child: InscriptionView()));
      break;
    case "/creer_jdr":
      liste.add(MaterialPage(child: DebutJDR()));
      break;
  }

  return liste;
}
