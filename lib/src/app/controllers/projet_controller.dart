import 'package:flutter/material.dart';
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
  ProjetModel? projet;
  List<EvenementModel>? evenements;
  List<PersonnageModel>? personnages;
  List<LieuModel>? lieux;
  List<ObjetModel>? objets;

  void _actualiserProjet(
    ProjetModel projet,
    List<EvenementModel> evenements,
    List<PersonnageModel> personnages,
    List<LieuModel> lieux,
    List<ObjetModel> objets,
  ) {
    this.projet = projet;
    this.evenements = evenements;
    this.personnages = personnages;
    this.lieux = lieux;
    this.objets = objets;
    notifyListeners();
  }

  static void changerProjet(
    BuildContext context,
    ProjetModel projet,
    List<EvenementModel> evenements,
    List<PersonnageModel> personnages,
    List<LieuModel> lieux,
    List<ObjetModel> objets,
  ) {
    Provider.of<ProjetController>(context, listen: false)._actualiserProjet(
      projet,
      evenements,
      personnages,
      lieux,
      objets,
    );
  }
}
