import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:provider/provider.dart';

/// Classe : Personnage
///
/// Type : Controller
///
/// Contient le personnage actuel
class PersonnageController extends ChangeNotifier {
  /// Projet sélectionné
  PersonnageModel? personnage;

  void _actualiser(PersonnageModel personnage) {
    this.personnage = personnage;
    notifyListeners();
  }

  static void changerPersonnage(BuildContext context, PersonnageModel personnage) {
    Provider.of<PersonnageController>(context, listen: false)._actualiser(personnage);
  }
}
