import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/app.dart';
import 'package:jdr_maker/src/app/controllers/evenement_controller.dart';
import 'package:jdr_maker/src/app/controllers/lieu_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/objet_controller.dart';
import 'package:jdr_maker/src/app/controllers/personnage_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/domain/data/config.dart';
import 'package:provider/provider.dart';

/// Départ de l'application
///
/// Initialisation de Firestore (Support Firebase pour Desktop)
///
/// Initialisation des providers (Ajouter ici les nouveaux)
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // Initialisation Firebase côté Android
    await Firebase.initializeApp();
  } else {
    // Initialisation Firebase côté Desktop
    Firestore.initialize(Config.projectID);
    FirebaseAuth.initialize(Config.apiKey, VolatileStore());
  }

  // Lancement des providers puis de l'application
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationController>(create: (_) => NavigationController()),
        ListenableProvider<ProjetController>(create: (_) => ProjetController()),
        ListenableProvider<UtilisateurController>(create: (_) => UtilisateurController()),

        // Chargement des applications
        ListenableProvider<EvenementController>(create: (_) => EvenementController()),
        ListenableProvider<PersonnageController>(create: (_) => PersonnageController()),
        ListenableProvider<LieuController>(create: (_) => LieuController()),
        ListenableProvider<ObjetController>(create: (_) => ObjetController()),
      ],
      child: App(),
    ),
  );

  if (Platform.isWindows) {
    doWhenWindowReady(() {
      var fenetre = appWindow;
      var tailleInitiale = Size(1400, 800);
      fenetre.minSize = tailleInitiale;
      fenetre.size = tailleInitiale;
      fenetre.alignment = Alignment.center;
      fenetre.title = "Dé part";
      fenetre.show();
    });
  }
}
