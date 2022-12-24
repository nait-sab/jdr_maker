import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/widgets/bouton.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe : Membres d'un Projet
///
/// Type : View
///
/// Contient la page des membres du projet actuel
class MembresProjetView extends StatefulWidget {
  @override
  State<MembresProjetView> createState() => _MembresProjetViewState();
}

class _MembresProjetViewState extends State<MembresProjetView> {
  late bool chargement;
  late ProjetController projetController;

  /// Liste des [membres] du projet
  late List<UtilisateurModel> membres;
  late UtilisateurModel createur;

  @override
  void initState() {
    super.initState();
    chargement = true;
    membres = [];
  }

  Future recupererMembres() async {
    membres = []; // A ajuster après avoir fait la mécanique d'ajout de membres
    String createurID = projetController.projet!.idCreateur;
    createur = UtilisateurModel.fromMap(
      await FirebaseGlobalTool.getdocumentID(UtilisateurModel.nomCollection, createurID),
    );
    if (mounted) {
      setState(() => chargement = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    recupererMembres();
    return AppInterface(
      child: chargement
          ? Chargement()
          : Platform.isAndroid
              ? renduMobile()
              : renduDesktop(),
    );
  }

  Widget renduMobile() {
    return Container();
  }

  Widget renduDesktop() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          EnteteApplication(routeRetour: "/options", titreFormulaire: "Membres du projet"),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: renduMembres(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Bouton(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Couleurs.violet,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.add_rounded,
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
    );
  }

  List<Widget> renduMembres() {
    List<Widget> liste = [];

    liste.add(afficherCreateur());

    if (membres.isNotEmpty) {
      liste.add(SizedBox(height: 20));
      liste.add(Container(color: Couleurs.texte, width: double.infinity, height: 1));
    }

    for (UtilisateurModel membre in membres) {
      liste.add(SizedBox(height: 20));
      liste.add(afficherMembre(membre));
    }

    return liste;
  }

  Widget afficherMembre(UtilisateurModel utilisateurModel) {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Couleurs.fondSecondaire,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            utilisateurModel.username,
            style: TextStyle(
              color: Couleurs.texte,
              fontWeight: FontWeight.bold,
              fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
            ),
          ),
          Row(
            children: [
              Text(
                "Membre",
                style: TextStyle(
                  color: Couleurs.violet,
                  fontWeight: FontWeight.bold,
                  fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
                ),
              ),
              SizedBox(width: 20),
              Bouton(
                onTap: () => {},
                child: Icon(
                  Icons.settings_rounded,
                  color: Couleurs.violet,
                  size: 30,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget afficherCreateur() {
    Size ecran = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Couleurs.fondSecondaire,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            createur.username,
            style: TextStyle(
              color: Couleurs.texte,
              fontWeight: FontWeight.bold,
              fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
            ),
          ),
          Text(
            "Créateur",
            style: TextStyle(
              color: Couleurs.violet,
              fontWeight: FontWeight.bold,
              fontSize: Platform.isAndroid ? 20 : ecran.width * 0.01,
            ),
          ),
        ],
      ),
    );
  }
}
