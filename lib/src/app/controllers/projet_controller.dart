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
  /// Projets
  List<ProjetModel> projets = [];
  ProjetModel? projet;

  /// Événements
  List<EvenementModel>? evenements;
  EvenementModel? evenement;

  /// Personnages
  List<PersonnageModel>? personnages;
  PersonnageModel? personnage;

  /// Lieux
  List<LieuModel>? lieux;
  LieuModel? lieu;

  /// Objets
  List<ObjetModel>? objets;
  ObjetModel? objet;

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

  Future _actualiserEvenement(String evenementID) async {
    for (EvenementModel event in evenements!) {
      if (event.id == evenementID) {
        evenement = event;
      }
    }
    notifyListeners();
  }

  Future _actualiserPersonnage(String personnageID) async {
    for (PersonnageModel perso in personnages!) {
      if (perso.id == personnageID) {
        personnage = perso;
      }
    }
    notifyListeners();
  }

  Future _actualiserLieu(String lieuID) async {
    for (LieuModel li in lieux!) {
      if (li.id == lieuID) {
        lieu = li;
      }
    }
    notifyListeners();
  }

  Future _actualiserObjet(String objetID) async {
    for (ObjetModel ob in objets!) {
      if (ob.id == objetID) {
        objet = ob;
      }
    }
    notifyListeners();
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

  static Future changerEvenement(BuildContext context, String evenementID) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserEvenement(evenementID);
  }

  static Future changerPersonnage(BuildContext context, String personnageID) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserPersonnage(personnageID);
  }

  static Future changerLieu(BuildContext context, String lieuID) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserLieu(lieuID);
  }

  static Future changerObjet(BuildContext context, String objetID) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserObjet(objetID);
  }
}
