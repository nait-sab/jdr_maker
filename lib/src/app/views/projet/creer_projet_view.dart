import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/views/projet/widgets/views_create_JDR_Widgets.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Créer un Projet
///
/// Type : View
///
/// Contient la page de création d'un nouveau projet
class CreerProjetView extends StatefulWidget {
  @override
  State<CreerProjetView> createState() => _CreerProjetViewState();
}

class _CreerProjetViewState extends State<CreerProjetView> {
  late String bullet;
  late int etape;
  late TextEditingController champNom;
  late String nomJdr;
  late UtilisateurController utilisateurController;

  @override
  void initState() {
    super.initState();
    etape = 0;
    nomJdr = "";
    bullet = "\u2022 ";
    champNom = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void etapeSuivante() {
    setState(() => etape++);
  }

  Future creationJDR() async {
    String idProjet = getRandomString(20);

    ProjetModel newProjet = ProjetModel(
      id: idProjet,
      idCreateur: utilisateurController.utilisateur!.id,
      nom: champNom.text,
      isPublic: false,
      codeMembre: "",
      codeUtilisable: false,
    );

    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(
          ProjetModel.nomCollection, idProjet, newProjet.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(
          ProjetModel.nomCollection, idProjet, newProjet.toMap());
    }

    retourAcceuil();
  }

  void retourAcceuil() {
    NavigationController.changerView(context, "/accueil");
  }

  @override
  Widget build(BuildContext context) {
    utilisateurController = Provider.of<UtilisateurController>(context);
    return Scaffold(
      backgroundColor: Couleurs.fondPrincipale,
      body: rendu(),
    );
  }

  Widget rendu() {
    return ViewsCreateJDRWidgets.rendu1(context, champNom, nomJdr, creationJDR);
  }
}
