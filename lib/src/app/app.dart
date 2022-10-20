import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/routes.dart';
import 'package:provider/provider.dart';

/// Classe App
///
/// Contient le moteur de l'application
///
/// Attribution des pages de l'application au Navigator 2.0
///
/// Démarrage automatique de l'application sur la route d'accueil ("/")
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: applicationRoutes(context),
        onPopPage: (route, resultat) {
          bool popStatus = route.didPop(resultat);
          if (popStatus) {
            Provider.of<NavigationController>(context, listen: false)
                .changerRoute("/");
          }
          return popStatus;
        },
      ),
    );
  }
}
