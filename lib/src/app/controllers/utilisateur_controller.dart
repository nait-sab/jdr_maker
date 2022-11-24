import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe : Utilisateur
///
/// Type : Controller
///
/// Contient la route actuelle dans l'application
class UtilisateurController extends ChangeNotifier {
  /// Projet sélectionné
  UtilisateurModel? utilisateur;

  void actualiser(UtilisateurModel utilisateur) {
    this.utilisateur = utilisateur;
    notifyListeners();
  }

  static void changerUtilisateur(BuildContext context, UtilisateurModel utilisateur) {
    Provider.of<UtilisateurController>(context, listen: false).actualiser(utilisateur);
  }
}
