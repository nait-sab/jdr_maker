import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/lieu_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:provider/provider.dart';

class LieuEdit extends StatefulWidget {
  const LieuEdit({super.key});

  @override
  State<LieuEdit> createState() => _LieuEditState();
}

class _LieuEditState extends State<LieuEdit> {
  late TextEditingController textEditingControllerNomLieu;
  late TextEditingController textEditingControllerDescription;
  late String lienImage;
  late LieuController lieuController;

  @override
  void initState() {
    super.initState();
    textEditingControllerNomLieu = TextEditingController();
    textEditingControllerDescription = TextEditingController();
    lienImage = 'https://picsum.photos/1920/1080';
  }

  Future modifierLieu() async {
    LieuModel lieu = lieuController.lieu!;
    lieu.description = textEditingControllerDescription.text;
    lieu.nomLieu = textEditingControllerNomLieu.text;
    if (Platform.isWindows) {
      await FirebaseDesktopTool.modifierDocument(LieuModel.nomCollection, lieu.id, lieu.toMap());
    } else {
      await FirebaseAndroidTool.modifierDocument(LieuModel.nomCollection, lieu.id, lieu.toMap());
    }
    await actualiser();
    setState(() => NavigationController.changerView(context, "/lieux"));
  }

  Future actualiser() async => ProjetController.actualiserProjet(context);

  void chargerPersonnage() {
    textEditingControllerNomLieu.text = lieuController.lieu!.nomLieu;
    textEditingControllerDescription.text = lieuController.lieu!.description;
  }

  @override
  Widget build(BuildContext context) {
    lieuController = Provider.of<LieuController>(context);
    chargerPersonnage();
    Size ecran = MediaQuery.of(context).size;
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/personnage", titreFormulaire: "Modification personnage"),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Couleurs.fondSecondaire, borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ChampSaisie(
                            typeChamp: TextInputType.text,
                            controller: textEditingControllerNomLieu,
                            nomChamp: "Nom du lieu",
                            couleurTexte: Couleurs.texte,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Couleurs.fondPrincipale),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Couleurs.texte,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
                                  child: Text("Ajouter une photo"),
                                )
                              ],
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Description:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Couleurs.texte, fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: ecran.height * 0.3,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Couleurs.fondPrincipale),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Couleurs.violet),
                                  ),
                                ),
                                controller: textEditingControllerDescription,
                                style: TextStyle(color: Couleurs.texte),
                                keyboardType: TextInputType.multiline,
                                maxLines: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              onPressed: modifierLieu,
                              style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
                              child: Text("Modifier le lieu")),
                        )
                      ]),
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
