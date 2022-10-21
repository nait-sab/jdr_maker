import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/accueil_widgets.dart';

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
  late bool chargement;

  @override
  void initState() {
    super.initState();
    chargement = true;
  }

  void changerRoute(String route) {
    NavigationController.changerView(context, route);
  }

  Future verifierUtilisateur() async {
    Object? utilisateurConnecter;

    Platform.isAndroid
        ? utilisateurConnecter = FirebaseAndroidTool.getUtilisateur()
        : utilisateurConnecter = await FirebaseDesktopTool.getUtilisateur();

    if (utilisateurConnecter == null) {
      // TODO - Commenter l'appel si besoin de modifier sans se connecter
      changerRoute("/inscription");
    }

    setState(() => chargement = false);
  }

  Widget definirRendu(BuildContext context) {
    if (chargement) {
      return AccueilWidgets.renduChargement(context);
    } else if (Platform.isAndroid) {
      return AccueilWidgets.renduAndroid(context);
    } else {
      return AccueilWidgets.renduDesktop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    verifierUtilisateur();
    return Scaffold(backgroundColor: Colors.white, body: definirRendu(context));
  }
}
