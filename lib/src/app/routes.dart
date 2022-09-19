import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/views/accueil_view.dart';
import 'package:provider/provider.dart';

/// Liste des pages de l'application
///
/// Le rooting s'éffectue selon la route
/// actuelle du controller navigation
///
/// Routes actuelles :
///
/// - Accueil
List<Page> applicationRoutes(context) {
  NavigationController navigation = Provider.of<NavigationController>(context);
  List<Page> liste = [];

  // Route par défaut
  liste.add(MaterialPage(child: Accueil()));

  // Routing
  // Toujours un / en début de route
  switch (navigation.currentRoute) {
    case "/exemple":
      liste.add(MaterialPage(child: Accueil()));
      break;
  }

  return liste;
}
