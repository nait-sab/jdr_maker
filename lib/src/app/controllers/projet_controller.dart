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
  /// Projet sélectionné
  ProjetModel? projet;

  /// Liste des événements du projet
  List<EvenementModel>? evenements;

  /// Liste des personnages du projet
  List<PersonnageModel>? personnages;

  /// Liste des lieux du projet
  List<LieuModel>? lieux;

  /// Liste des objets du projet
  List<ObjetModel>? objets;

  /// Événement sélectionné
  EvenementModel? evenement;

  /// Personnage sélectionné
  PersonnageModel? personnage;

  /// Lieux sélectionné
  LieuModel? lieu;

  /// Objet sélectionné
  ObjetModel? objet;

  Future _actualiserProjet(ProjetModel projet) async {
    this.projet = projet;

    await FirebaseGlobalTool.recupererListe(EvenementModel.nomCollection, (data) {
      evenements!.add(EvenementModel.fromMap(data));
    });

    await FirebaseGlobalTool.recupererListe(PersonnageModel.nomCollection, (data) {
      personnages!.add(PersonnageModel.fromMap(data));
    });

    await FirebaseGlobalTool.recupererListe(LieuModel.nomCollection, (data) {
      lieux!.add(LieuModel.fromMap(data));
    });

    await FirebaseGlobalTool.recupererListe(ObjetModel.nomCollection, (data) {
      objets!.add(ObjetModel.fromMap(data));
    });

    notifyListeners();
  }

  Future _actualiserEvenement(String evenementID) async {
    for (EvenementModel event in evenements!) {
      if (event.id == evenementID) {
        evenement = event;
      }
    }
    print(evenement!.id);
    notifyListeners();
  }

  static Future changerProjet(BuildContext context, ProjetModel projet) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserProjet(projet);
  }

  static void changerEvenement(BuildContext context, String evenementID) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiserEvenement(evenementID);
  }
}
