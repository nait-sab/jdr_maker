import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:jdr_maker/src/domain/models/objet_model.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Projet
///
/// Type : Controller
///
/// Contient le projet actuel dans l'application
class ProjetController extends ChangeNotifier {
  /// Liste des projets
  List<ProjetModel> projets = [];

  /// Données du projet actuel
  ProjetModel? projet;
  List<EvenementModel>? evenements;
  List<PersonnageModel>? personnages;
  List<LieuModel>? lieux;
  List<ObjetModel>? objets;

  Future _actualiserProjet(ProjetModel projet) async {
    this.projet = projet;
    await _actualiserApplications();
    notifyListeners();
  }

  Future _chargerProjets() async {
    projets = [];
    await FirebaseGlobalTool.recupererListe(ProjetModel.nomCollection, (data) {
      projets.add(ProjetModel.fromMap(data));
    });
    notifyListeners();
  }

  Future _actualiserApplications() async {
    evenements = [];
    personnages = [];
    lieux = [];
    objets = [];

    await FirebaseGlobalTool.recupererListe(EvenementModel.nomCollection, (data) {
      if (data["idProjet"] == projet!.id) {
        evenements!.add(EvenementModel.fromMap(data));
      }
    });

    if (evenements!.isNotEmpty) {
      evenements!.sort((event1, event2) => event1.numero.compareTo(event2.numero));
    }

    await FirebaseGlobalTool.recupererListe(PersonnageModel.nomCollection, (data) {
      if (data["idProjet"] == projet!.id) {
        personnages!.add(PersonnageModel.fromMap(data));
      }
    });

    await FirebaseGlobalTool.recupererListe(LieuModel.nomCollection, (data) {
      if (data["idProjet"] == projet!.id) {
        lieux!.add(LieuModel.fromMap(data));
      }
    });

    await FirebaseGlobalTool.recupererListe(ObjetModel.nomCollection, (data) {
      if (data["idProjet"] == projet!.id) {
        objets!.add(ObjetModel.fromMap(data));
      }
    });
  }

  static Future changerProjet(BuildContext context, ProjetModel projet) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserProjet(projet);
  }

  static Future actualiser(BuildContext context) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserProjet(
      Provider.of<ProjetController>(context, listen: false).projet!,
    );
  }

  static Future chargerProjets(BuildContext context) async {
    await Provider.of<ProjetController>(context, listen: false)._chargerProjets();
  }
}
