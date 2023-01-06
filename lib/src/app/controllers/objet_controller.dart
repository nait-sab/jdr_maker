import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/objet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Lieu
///
/// Type : Controller
///
/// Contient l'objet actuel
class ObjetController extends ChangeNotifier {
  /// Projet sélectionné
  ObjetModel? objet;

  void _actualiser(ObjetModel objet) {
    this.objet = objet;
    notifyListeners();
  }

  static void changerObjet(BuildContext context, ObjetModel objet) {
    Provider.of<ObjetController>(context, listen: false)._actualiser(objet);
  }
}
