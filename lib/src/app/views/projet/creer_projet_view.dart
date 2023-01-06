import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/generateur_tool.dart';
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
    String id = GenerateurTool.genererID();

    ProjetModel newProjet = ProjetModel(
      id: id,
      idCreateur: utilisateurController.utilisateur!.id,
      nom: champNom.text,
      isPublic: false,
      codeMembre: "",
      codeUtilisable: false,
    );

    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(ProjetModel.nomCollection, id, newProjet.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(ProjetModel.nomCollection, id, newProjet.toMap());
    }

    await _chargerProjets();
    await _chargerProjet(newProjet);
    _acceuil();
  }


  Future _chargerProjets() async => await ProjetController.chargerProjets(context);
  Future _chargerProjet(ProjetModel projet) async => await ProjetController.chargerProjet(context, projet);
  void _acceuil() => NavigationController.changerView(context, "/accueil");

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
