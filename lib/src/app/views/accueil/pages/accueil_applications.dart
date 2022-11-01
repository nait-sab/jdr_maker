import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Applications
///
/// Type : Page
///
/// Contient la page des applications du projet sélectionné de l'accueil
class AccueilPageApplications extends StatefulWidget {
  final ProjetModel projet;

  AccueilPageApplications({
    required this.projet,
  });

  @override
  State<AccueilPageApplications> createState() => _AccueilPageApplicationsState();
}

class _AccueilPageApplicationsState extends State<AccueilPageApplications> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return Platform.isAndroid ? renduMobile(context) : renduDesktop(context);
  }

  Widget renduDesktop(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            boutonApplication(
              () {},
              Color(0xff935941),
              Icons.menu_book_rounded,
              "Événements",
              projetController.evenements!.length.toString(),
            ),
            boutonApplication(
              () {},
              Color(0xff3C6D47),
              Icons.menu_book_rounded,
              "Personnages",
              projetController.personnages!.length.toString(),
            ),
            boutonApplication(
              () {},
              Color(0xff794567),
              Icons.menu_book_rounded,
              "Lieux",
              projetController.lieux!.length.toString(),
            ),
            boutonApplication(
              () {},
              Color(0xff46487E),
              Icons.menu_book_rounded,
              "Objets",
              projetController.objets!.length.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${widget.projet.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget boutonApplication(VoidCallback action, Color couleurFond, IconData icone, String titre, String total) {
    Size ecran = MediaQuery.of(context).size;
    return Bouton(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: couleurFond,
        ),
        child: Column(
          children: [
            Text(
              titre,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Platform.isAndroid ? 20 : ecran.width * 0.025,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  total,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Platform.isAndroid ? 20 : ecran.width * 0.03,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  icone,
                  size: Platform.isAndroid ? 20 : ecran.width * 0.04,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
