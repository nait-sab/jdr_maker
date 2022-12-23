import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/views/projet/widgets/debut_jdr_widgets.dart';
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

  void etapeSuivante() {
    setState(() => etape++);
  }

  Future creationJDR() async {
    String idProjet = getRandomString(20);

    ProjetModel newProjet = ProjetModel(
      id: idProjet,
      idCreateur: utilisateurController.utilisateur!.id,
      nomProjet: champNom.text,
      isPublic: false,
    );

    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(ProjetModel.nomCollection, idProjet, newProjet.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(ProjetModel.nomCollection, idProjet, newProjet.toMap());
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
      backgroundColor: Color(0xff1e1e1e),
      body: rendu(),
    );
  }

  Widget rendu() {
    if (etape == 0) {
      return DebutJDRWidgets.rendu1(context, bullet, etapeSuivante);
    } else if (etape == 1) {
      return DebutJDRWidgets.rendu2(context, etapeSuivante, champNom, nomJdr);
    } else {
      return DebutJDRWidgets.rendu3(context, creationJDR);
    }
  }
}
