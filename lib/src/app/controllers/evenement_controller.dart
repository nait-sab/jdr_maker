import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:provider/provider.dart';

/// Classe : Evenement
///
/// Type : Controller
///
/// Contient l'evenement actuel
class EvenementController extends ChangeNotifier {
  /// Projet sélectionné
  EvenementModel? evenement;

  void _actualiser(EvenementModel evenement) {
    this.evenement = evenement;
    notifyListeners();
  }

  static void changerEvenement(BuildContext context, EvenementModel evenement) {
    Provider.of<EvenementController>(context, listen: false)._actualiser(evenement);
  }
}
