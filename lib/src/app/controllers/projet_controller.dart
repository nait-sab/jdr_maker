import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:provider/provider.dart';

/// Classe : Projet
///
/// Type : Controller
///
/// Contient le projet actuel dans l'application
class ProjetController extends ChangeNotifier {
  ProjetModel? projet;

  void _actualiser(ProjetModel projetModel) {
    projet = projetModel;
    notifyListeners();
  }

  static void changerView(BuildContext context, ProjetModel projet) {
    Provider.of<ProjetController>(context, listen: false)._actualiser(projet);
  }
}
