import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:provider/provider.dart';

class LieuView extends StatefulWidget {
  const LieuView({super.key});

  @override
  State<LieuView> createState() => _LieuViewState();
}

class _LieuViewState extends State<LieuView> {
  late ProjetController projetController;

  Future<void> deleteDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Couleurs.fondSecondaire,
            title: Text(
              'Supprimer un Lieu',
              style: TextStyle(color: Couleurs.violet),
            ),
            content: RichText(
              text: TextSpan(
                text: 'Supprimer le Lieu : ',
                style: TextStyle(color: Couleurs.texte),
                children: <TextSpan>[
                  TextSpan(
                    text: projetController.lieu!.nomLieu,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Couleurs.violet),
                  ),
                  TextSpan(text: ' ?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Annuler")),
              TextButton(
                  onPressed: () async {
                    if (Platform.isWindows) {
                      await FirebaseDesktopTool.supprimerDocument(LieuModel.nomCollection, projetController.lieu!.id);
                    } else {
                      await FirebaseAndroidTool.supprimerDocument(LieuModel.nomCollection, projetController.lieu!.id);
                    }
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context, true);
                    setState(() {
                      ProjetController.actualiser(context);
                      NavigationController.changerView(context, "/lieux");
                    });
                  },
                  child: Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  void goToEdit() {
    NavigationController.changerView(context, "/modifier_lieu");
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
          child: Container(
            decoration:
                BoxDecoration(color: Couleurs.fondSecondaire, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Couleurs.fondPrincipale.withOpacity(0.2), BlendMode.dstIn),
                        image: NetworkImage(projetController.lieu!.lienImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          EnteteApplication(routeRetour: "/lieux", titreFormulaire: "Fiche du lieu"),
                          AutoSizeText(
                            projetController.lieu!.nomLieu,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            minFontSize: 40,
                            maxFontSize: 50,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Couleurs.texte, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 100),
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Couleurs.fondPrincipale),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Text(
                          projetController.lieu!.description,
                          style: TextStyle(
                            color: Couleurs.texte,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: deleteDialog,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: Text("Supprimer le lieu"),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: goToEdit,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text("Modifier le lieu"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
