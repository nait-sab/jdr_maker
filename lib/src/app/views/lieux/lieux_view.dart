import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/lieu_controller.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:provider/provider.dart';

class LieuxView extends StatefulWidget {
  @override
  State<LieuxView> createState() => _LieuxViewState();
}

class _LieuxViewState extends State<LieuxView> {
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
  }

  void ouvrirLieu(LieuModel lieu) {
    LieuController.changerLieu(context, lieu);
    NavigationController.changerRoute(context, "/lieu");
  }

  void ouvrirCreateLieu() {
    NavigationController.changerRoute(context, "/creer_lieu");
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);

    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: Platform.isAndroid ? 20 : 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Lieux"),
            Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                    itemCount: projetController.lieux?.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400, crossAxisSpacing: 15, mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ouvrirLieu(projetController.lieux![index]);
                        },
                        child: Container(
                          height: 14,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Couleurs.fondSecondaire),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          projetController.lieux![index].lienImage,
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Center(
                                  child: Text(
                                    projetController.lieux![index].nomLieu,
                                    style: TextStyle(color: Couleurs.texte, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Bouton(
                      onTap: ouvrirCreateLieu,
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
