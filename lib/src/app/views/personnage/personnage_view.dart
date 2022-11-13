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
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:provider/provider.dart';

class PersonnageView extends StatefulWidget {
  const PersonnageView({super.key});

  @override
  State<PersonnageView> createState() => _PersonnageViewState();
}

class _PersonnageViewState extends State<PersonnageView> {
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> deleteDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Couleurs.fondSecondaire,
            title: Text(
              'Supprimer un personnage',
              style: TextStyle(color: Couleurs.violet),
            ),
            content: RichText(
              text: TextSpan(
                text: 'Supprimer le personnage : ',
                style: TextStyle(color: Couleurs.texte),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${projetController.personnage!.prenomPersonnage} ${projetController.personnage!.nomPersonnage}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Couleurs.violet),
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
                      await FirebaseDesktopTool.supprimerDocument(
                          PersonnageModel.nomCollection,
                          projetController.personnage!.id);
                    } else {
                      await FirebaseAndroidTool.supprimerDocument(
                          PersonnageModel.nomCollection,
                          projetController.personnage!.id);
                    }
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context, true);
                    setState(() {
                      ProjetController.actualiser(context);
                      NavigationController.changerView(context, "/personnages");
                    });
                  },
                  child: Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.redAccent),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
        child: Column(
          children: [
            EnteteApplication(
                routeRetour: "/personnages",
                titreFormulaire: "Fiche de personnage"),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Couleurs.fondSecondaire),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 200,
                                      maxHeight: 200,
                                      minHeight: 100),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          projetController
                                                      .personnage!.lienImage !=
                                                  ""
                                              ? projetController
                                                  .personnage!.lienImage
                                              : 'https://picsum.photos/200/300',
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    AutoSizeText(
                                      projetController
                                          .personnage!.nomPersonnage,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Couleurs.texte,
                                      ),
                                      minFontSize: 25,
                                      maxFontSize: 50,
                                    ),
                                    AutoSizeText(
                                      projetController
                                          .personnage!.prenomPersonnage,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Couleurs.texte,
                                      ),
                                      minFontSize: 25,
                                      maxFontSize: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Divider(
                            color: Couleurs.texte,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Couleurs.texte,
                                fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Couleurs.fondPrincipale),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                projetController.personnage!.description,
                                style: TextStyle(
                                  color: Couleurs.texte,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Histoire",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Couleurs.texte,
                                fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Couleurs.fondPrincipale),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                projetController.personnage!.histoire,
                                style: TextStyle(
                                  color: Couleurs.texte,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: deleteDialog,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            child: Text("Supprimer le personnage"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
