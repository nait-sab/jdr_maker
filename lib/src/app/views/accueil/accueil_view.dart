import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/views/accueil/widgets/accueil_widgets.dart';
import 'package:provider/provider.dart';

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
  }

  void allerDebut() {
    Provider.of<NavigationController>(context, listen: false).changerRoute("/creer_jdr");
  }

  void goInscription() {
    Provider.of<NavigationController>(context, listen: false).changerRoute("/inscription");
  }

  Future verifierUtilisateur() async {
    if (Platform.isAndroid) {
      await FirebaseAndroidTool.getUtilisateur();
    } else {
      await FirebaseDesktopTool.getUtilisateur();
    }
  }

  Widget definirRendu(BuildContext context) {
    if (chargement) {
      return CircularProgressIndicator();
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
