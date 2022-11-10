import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';


class PersonnageCreate extends StatefulWidget {
  const PersonnageCreate({super.key});

  @override
  State<PersonnageCreate> createState() => _PersonnageCreateState();
}

class _PersonnageCreateState extends State<PersonnageCreate> {
  late TextEditingController textEditingControllerNom;
  late TextEditingController textEditingControllerPrenom;
  late TextEditingController textEditingControllerDescription;
  late TextEditingController textEditingControllerHistoire;
  late String lienImage;

  @override
  void initState() {
    super.initState();

    textEditingControllerNom = TextEditingController();
    textEditingControllerPrenom = TextEditingController();
    textEditingControllerDescription = TextEditingController();
    textEditingControllerHistoire = TextEditingController();
    lienImage = 'https://picsum.photos/200/300';
  }

  Future<void> creationPersonnage() async {
    String idPersonnage = getRandomString(20);
    PersonnageModel newPersonnage = PersonnageModel(
        id: idPersonnage,
        idProjet: idPersonnage,
        lienImage: lienImage,
        description: textEditingControllerDescription.text,
        histoire: textEditingControllerHistoire.text,
        nomPersonnage: textEditingControllerNom.text,
        prenomPersonnage: textEditingControllerPrenom.text);
    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(
          PersonnageModel.nomCollection, idPersonnage, newPersonnage.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(
          PersonnageModel.nomCollection, idPersonnage, newPersonnage.toMap());
    }
    leave();
  }

  void leave() {
    NavigationController.changerView(context, "/personnages");
  }

  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return AppInterface(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Couleurs.fondSecondaire,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Nom:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: textEditingControllerNom,
                  style: TextStyle(color: Couleurs.texte),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Prénom:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: textEditingControllerPrenom,
                  style: TextStyle(color: Couleurs.texte),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Couleurs.fondPrincipale),
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: ecran.height * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Couleurs.fondPrincipale),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: ecran.height * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Couleurs.fondPrincipale),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
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
                    onPressed: creationPersonnage,
                    child: Text("Creer le personnage")),
              )
            ]),
          ),
        ),
      )),
    );
  }
}
