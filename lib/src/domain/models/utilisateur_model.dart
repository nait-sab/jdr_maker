import 'package:flutter/material.dart';

/// Classe : Utilisateur
///
/// Type : Model
///
/// Contient la route actuelle dans l'application
class UtilisateurModel extends ChangeNotifier {
  // Contenu d'exemple pour RoRo

  String id;

  UtilisateurModel({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
    };
  }
}
