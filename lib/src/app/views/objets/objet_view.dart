import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/objet_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/objet_model.dart';
import 'package:provider/provider.dart';

class ObjetView extends StatefulWidget {
  const ObjetView({super.key});

  @override
  State<ObjetView> createState() => _ObjetViewState();
}

class _ObjetViewState extends State<ObjetView> {
  late ObjetController objetController;

  Future<void> deleteDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Couleurs.fondSecondaire,
          title: Text(
            'Supprimer un objet',
            style: TextStyle(color: Couleurs.violet),
          ),
          content: RichText(
            text: TextSpan(
              text: 'Supprimer l\'objet : ',
              style: TextStyle(color: Couleurs.texte),
              children: <TextSpan>[
                TextSpan(
                  text: objetController.objet!.nomObjet,
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
                    await FirebaseDesktopTool.supprimerDocument(ObjetModel.nomCollection, objetController.objet!.id);
                  } else {
                    await FirebaseAndroidTool.supprimerDocument(ObjetModel.nomCollection, objetController.objet!.id);
                  }
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context, true);
                  await actualiser();
                  setState(() => NavigationController.changerView(context, "/objets"));
                },
                child: Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      },
    );
  }

  Future actualiser() async => ProjetController.actualiserProjet(context);

  void goToEdit() {
    NavigationController.changerView(context, "/modifier_objet");
  }

  @override
  Widget build(BuildContext context) {
    objetController = Provider.of<ObjetController>(context);
    return AppInterface(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
          child: Container(
            decoration: BoxDecoration(color: Couleurs.fondSecondaire, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                        image: NetworkImage(objetController.objet!.lienImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          EnteteApplication(routeRetour: "/objets", titreFormulaire: "Fiche de l'objet"),
                          AutoSizeText(
                            objetController.objet!.nomObjet,
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
                          objetController.objet!.description,
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
                          child: Text("Supprimer l'objet"),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: goToEdit,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text("Modifier l'objet"),
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
