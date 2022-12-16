import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:provider/provider.dart';

/// Classe : Evenement
///
/// Type : Controller
///
/// Contient la route actuelle dans l'application
class EvenementController extends ChangeNotifier {
  /// Projet sélectionné
  EvenementModel? evenement;

  void actualiser(EvenementModel evenement) {
    this.evenement = evenement;
    notifyListeners();
  }

  static void changerUtilisateur(BuildContext context, EvenementModel evenement) {
    Provider.of<EvenementController>(context, listen: false).actualiser(evenement);
  }
}
