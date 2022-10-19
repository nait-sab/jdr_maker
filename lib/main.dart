import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/app.dart';
import 'package:jdr_maker/src/app/config.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:provider/provider.dart';

/// Départ de l'application
///
/// Initialisation de Firestore (Support Firebase pour Desktop)
///
/// Initialisation des providers (Ajouter ici les nouveaux)
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Firebase côté Desktop
  Firestore.initialize(Config.projectID);
  FirebaseAuth.initialize(Config.apiKey, VolatileStore());

  // Initialisation Firebase côté Android
  await Firebase.initializeApp();

  // Lancement des providers puis de l'application
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationController>(
            create: (_) => NavigationController()),
      ],
      child: App(),
    ),
  );
}
