import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/views/creerJDR/widgets/debut_jdr_widgets.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';

/// Classe DebutJDR
///
/// Type : View
///
///Ecran création d'un projet
class DebutJDR extends StatefulWidget {
  @override
  State<DebutJDR> createState() => _DebutJDRState();
}

class _DebutJDRState extends State<DebutJDR> {
  late String bullet;
  late int etape;
  late TextEditingController nomJdrController;
  late String nomJdr;

  @override
  void initState() {
    super.initState();
    etape = 0;
    nomJdr = "";
    bullet = "\u2022 ";
    nomJdrController = TextEditingController();
  }

  void gestionEtape() {
    setState(() {
      if (etape == 1) {
        nomJdr = nomJdrController.text;
      }
      etape++;
    });
  }

  Future<void> creationJDR() async {
    String idProjet = getRandomString(20);
    ProjetModel newProjet = ProjetModel(
        id: idProjet,
        idCreateur: "wi3eEPNOwmecmOy9nuVzETg19oP2", //Brut Pour le moment
        nomProjet: nomJdrController.text,
        isPublic: true);
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
    return Scaffold(
      backgroundColor: Color(0xff1e1e1e),
      body: etape == 0
          ? DebutJDRWidgets.rendu1(context, bullet, gestionEtape)
          : etape == 2
              ? DebutJDRWidgets.rendu3(
                  context,
                  creationJDR,
                )
              : DebutJDRWidgets.rendu2(context, gestionEtape, nomJdrController, nomJdr),
    );
  }
}
