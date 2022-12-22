import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:provider/provider.dart';

/// Classe : Accueil - Applications
///
/// Type : View
///
/// Contient la page des applications du projet sélectionné de l'accueil
class ApplicationsView extends StatefulWidget {
  @override
  State<ApplicationsView> createState() => _ApplicationsViewState();
}

class _ApplicationsViewState extends State<ApplicationsView> {
  late ProjetController projetController;

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: StaggeredGrid.count(
          crossAxisCount: Platform.isAndroid ? 1 : 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            boutonApplication(
              ouvrirApplicationEvenement,
              Color(0xff935941),
              Icons.menu_book_rounded,
              "Événements",
              projetController.evenements!.length.toString(),
            ),
            boutonApplication(
              ouvrirApplicationPersonnage,
              Color(0xff3C6D47),
              Icons.person_rounded,
              "Personnages",
              projetController.personnages!.length.toString(),
            ),
            boutonApplication(
              ouvrirApplicationLieu,
              Color(0xff794567),
              Icons.location_on_rounded,
              "Lieux",
              projetController.lieux!.length.toString(),
            ),
            boutonApplication(
              ouvrirApplicationObjet,
              Color(0xff46487E),
              Icons.diamond_rounded,
              "Objets",
              projetController.objets!.length.toString(),
            ),
            boutonApplication(
              ouvrirApplicationLanceDes,
              Color.fromARGB(255, 153, 150, 74),
              Icons.play_arrow,
              "Lancé de dés",
              0.toString(),
            ),
          ],
        ),
      ),
    );
  }

  void ouvrirApplicationEvenement() {
    NavigationController.changerRoute(context, "/evenements");
  }

  void ouvrirApplicationPersonnage() {
    NavigationController.changerRoute(context, "/personnages");
  }

  void ouvrirApplicationLieu() {
    NavigationController.changerRoute(context, "/lieux");
  }

  void ouvrirApplicationObjet() {
    NavigationController.changerRoute(context, "/objets");
  }

  void ouvrirApplicationLanceDes() {
    NavigationController.changerRoute(context, "/lance");
  }

  Widget renduMobile(BuildContext context) {
    return Center(
      child: Text(
        "Project actuel : ${projetController.projet!.nomProjet}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget boutonApplication(VoidCallback action, Color couleurFond, IconData icone, String titre, String total) {
    Size ecran = MediaQuery.of(context).size;
    return Bouton(
      onTap: action,
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
