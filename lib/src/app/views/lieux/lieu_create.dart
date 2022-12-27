import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:provider/provider.dart';

class LieuCreate extends StatefulWidget {
  const LieuCreate({super.key});

  @override
  State<LieuCreate> createState() => _LieuCreateState();
}

class _LieuCreateState extends State<LieuCreate> {
  late TextEditingController textEditingControllerNomLieu;
  late TextEditingController textEditingControllerDescription;
  late String lienImage;
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
    textEditingControllerNomLieu = TextEditingController();
    textEditingControllerDescription = TextEditingController();
    lienImage = 'https://picsum.photos/1920/1080'; //brut pour le moment
  }

  Future<void> creationLieu() async {
    String idLieu = getRandomString(20);
    LieuModel newLieu = LieuModel(
      id: idLieu,
      idProjet: projetController.projet!.id,
      lienImage: lienImage,
      description: textEditingControllerDescription.text,
      idCreateur: 'zgzeazfzzEFZEF', //brut pour le moment
      nomLieu: textEditingControllerNomLieu.text,
    );
    if (Platform.isWindows) {
      await FirebaseDesktopTool.ajouterDocumentID(LieuModel.nomCollection, idLieu, newLieu.toMap());
    } else {
      await FirebaseAndroidTool.ajouterDocumentID(LieuModel.nomCollection, idLieu, newLieu.toMap());
    }
    await actualiser();
    setState(() => NavigationController.changerView(context, "/lieux"));
  }

  Future actualiser() async => ProjetController.actualiserProjet(context);

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    Size ecran = MediaQuery.of(context).size;
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/lieux", titreFormulaire: "Création lieu"),
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
                            'Description du lieu:',
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
                              onPressed: creationLieu,
                              style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
                              child: Text("Creer le lieu")),
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
