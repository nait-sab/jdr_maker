import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:provider/provider.dart';

class PersonnagesView extends StatefulWidget {
  @override
  State<PersonnagesView> createState() => _PersonnagesViewState();
}

class _PersonnagesViewState extends State<PersonnagesView> {
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
  }

  void ouvrirPersonnage(PersonnageModel personnage) {
    projetController.personnage = personnage;

    ProjetController.changerPersonnage(context, personnage.id);
    NavigationController.changerView(context, "/personnage");
  }

  void ouvrirCreatePersonnage() {
    NavigationController.changerView(context, "/creer_personnage");
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Personnages"),
            Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                    itemCount: projetController.personnages?.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300, crossAxisSpacing: 15, mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ouvrirPersonnage(projetController.personnages![index]);
                        },
                        child: Container(
                          height: 14,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(20), color: Couleurs.fondSecondaire),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minWidth: 100, maxWidth: 170, maxHeight: 170, minHeight: 100),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            'https://picsum.photos/200/300',
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      projetController.personnages![index].nomPersonnage,
                                      style: TextStyle(color: Couleurs.texte),
                                    ),
                                    Text(
                                      projetController.personnages![index].prenomPersonnage,
                                      style: TextStyle(color: Couleurs.texte),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Bouton(
                      onTap: ouvrirCreatePersonnage,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Couleurs.violet,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
