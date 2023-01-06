import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/personnage_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:provider/provider.dart';

class PersonnageEdit extends StatefulWidget {
  const PersonnageEdit({super.key});

  @override
  State<PersonnageEdit> createState() => _PersonnageEditState();
}

class _PersonnageEditState extends State<PersonnageEdit> {
  late TextEditingController textEditingControllerNom;
  late TextEditingController textEditingControllerPrenom;
  late TextEditingController textEditingControllerDescription;
  late TextEditingController textEditingControllerHistoire;
  late String lienImage;
  late PersonnageController personnageController;

  @override
  void initState() {
    super.initState();
    textEditingControllerNom = TextEditingController();
    textEditingControllerPrenom = TextEditingController();
    textEditingControllerDescription = TextEditingController();
    textEditingControllerHistoire = TextEditingController();
    lienImage = 'https://picsum.photos/200/300';
  }

  Future modifierPersonnage() async {
    PersonnageModel personnage = personnageController.personnage!;
    personnage.description = textEditingControllerDescription.text;
    personnage.histoire = textEditingControllerHistoire.text;
    personnage.nomPersonnage = textEditingControllerNom.text;
    if (Platform.isWindows) {
      await FirebaseDesktopTool.modifierDocument(PersonnageModel.nomCollection, personnage.id, personnage.toMap());
    } else {
      await FirebaseAndroidTool.modifierDocument(PersonnageModel.nomCollection, personnage.id, personnage.toMap());
    }
    await actualiser();
    setState(() => NavigationController.changerView(context, "/personnages"));
  }

  Future actualiser() async => ProjetController.actualiserProjet(context);

  void chargerPersonnage() {
    textEditingControllerNom.text = personnageController.personnage!.nomPersonnage;
    textEditingControllerPrenom.text = personnageController.personnage!.prenomPersonnage;
    textEditingControllerDescription.text = personnageController.personnage!.description;
    textEditingControllerHistoire.text = personnageController.personnage!.description;
  }

  @override
  Widget build(BuildContext context) {
    personnageController = Provider.of<PersonnageController>(context);
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
                            controller: textEditingControllerNom,
                            nomChamp: "Nom du personnage",
                            couleurTexte: Couleurs.texte,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ChampSaisie(
                            typeChamp: TextInputType.text,
                            controller: textEditingControllerPrenom,
                            nomChamp: "Prénom du personnage",
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
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Histoire:',
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
                                controller: textEditingControllerHistoire,
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
                              onPressed: modifierPersonnage,
                              style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
                              child: Text("Modifier le personnage")),
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
