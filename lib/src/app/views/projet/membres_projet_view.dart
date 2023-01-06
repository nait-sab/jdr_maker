import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/app/tools/get_random_string.dart';
import 'package:jdr_maker/src/app/widgets/alerte.dart';
import 'package:jdr_maker/src/app/widgets/boutons/bouton.dart';
import 'package:jdr_maker/src/app/widgets/boutons/icone_bouton.dart';
import 'package:jdr_maker/src/app/widgets/chargement.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:jdr_maker/src/domain/models/membre_model.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
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
  late bool membresTrouver;
  late ProjetController projetController;

  /// Liste des [membres] du projet
  late List<UtilisateurModel> membres;
  late UtilisateurModel createur;

  @override
  void initState() {
    super.initState();
    chargement = true;
    membresTrouver = false;
    membres = [];
  }

  Future recupererMembres() async {
    membres = [];
    String createurID = projetController.projet!.idCreateur;

    createur = UtilisateurModel.fromMap(
      await FirebaseGlobalTool.getdocumentID(UtilisateurModel.nomCollection, createurID),
    );

    // Récupérer la liste des membres s'ils sont membre du même projet
    List<MembreModel> cibles = [];
    await FirebaseGlobalTool.recupererListe(MembreModel.nomCollection, (data) {
      MembreModel cible = MembreModel.fromMap(data);
      if (cible.idProjet == projetController.projet!.id) {
        cibles.add(cible);
      }
    });

    // Les ajouter à la liste des membres à afficher
    for (MembreModel cible in cibles) {
      UtilisateurModel membre = UtilisateurModel.fromMap(
        await FirebaseGlobalTool.getdocumentID(UtilisateurModel.nomCollection, cible.idMembre),
      );
      membres.add(membre);
    }

    if (mounted) {
      membresTrouver = true;
      setState(() => chargement = false);
    }
  }

  Future genererCode() async {
    setState(() => chargement = true);
    ProjetModel projet = projetController.projet!;
    String codeGenerer = getRandomString(8);
    projet.codeMembre = codeGenerer;
    projet.codeUtilisable = true;
    await FirebaseGlobalTool.modifierDocument(ProjetModel.nomCollection, projet.id, projet.toMap());
    afficherCode(codeGenerer);
    setState(() => chargement = false);
  }

  void afficherCode(String code) {
    Alerte.message(
      context,
      "Ajouter un membre",
      "Nouveau code d'invitation : \"$code\"",
    );
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    if (!membresTrouver) {
      recupererMembres();
    }
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
                  child: BoutonIcone(
                    icone: Icons.add_rounded,
                    action: genererCode,
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
